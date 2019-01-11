#!/bin/bash

set -o errexit # exit immediately if a command exits with a non-zero status
set -o nounset # do not allow to use an unset variable
set -o pipefail # force exit code of a pipeline to non-zero, if one of commands fails with non-zero

compiler="pdflatex"
biber_cmd="biber --quiet"

# tmp_extensions: these files will be removed after a successful run
tmp_extensions="aux,bcf,bbl,blg,idx,lof,log,lot,nav,out,run.xml,snm,synctex.gz,toc,vrb"

# variables for argument parsing
force=0
cleanup=0
nocleanup=0

# variables for statistics
n_skipped=0
n_failed=0
n_succes=0

tmpname=${0}.tmp

usage() {
cat << _EOF_

Usage: $0 [-f] [-c|-nc] FILE [FILE [FILE ...]]
   or: $0 [-f] [-c|-nc] [DIR [DIR [DIR ...]]]
Compile the specified TeX FILE(s) or compile *all* TeX files
in the specified DIR(s) and all the underlying subdirs (default value: .)
By default, the files are compiled only if the TeX file is newer than the PDF
By default, all temporary files are removed, but only after a successful build
 -f, --force     : always process the files, also if the PDF file is newer
 -c, --cleanup   : always remove tmp files, also if build failed or PDF newer
 -nc, --nocleanup: never remove temporary files, even if build was successful
 -h, --help      : show this help message
 -x, --xelatex   : use xelatex as compiler instead of pdflatex
Send questions, requests, issues, bugs, ... to wim.goedertier@hogent.be
_EOF_

#TODO -b, --biber   : force to run biber (by default only if .bcf contains 'citekey')
#TODO -nb, --nobiber: don't run biber
}

die() {
    echo "ERROR: $1"
    echo
    usage
    exit 1
}

search_files() {
    #echo search_files $1 #debug
    for i in $(grep --files-with-matches '^\\documentclass' $(find $1 -type f -name '*.tex') /dev/null); do
        process_file $i
    done
}
check_needrebuild() {
    # $1 is a filename (without extension) to be checked
    # return 0 (true) if rebuild is needed
    # return 1 (false) if rebuild is not needed

    if grep '^\\solution' ${filebase}.tex >/dev/null; then
        [ -s ${filebase}-vragen.pdf ] || return 0
        [ ${filebase}-vragen.pdf -nt ${filebase}.tex ] || return 0
        for tmpfile in $(grep '\\include{' ${filebase}.tex|cut -b10-|tr -d '}'); do
            [ ${filebase}-vragen.pdf -nt ${tmpfile}.tex ] || return 0
        done
        [ -s ${filebase}-oploss.pdf ] || return 0
        [ ${filebase}-oploss.pdf -nt ${filebase}.tex ] || return 0
        for tmpfile in $(grep '\\include{' ${filebase}.tex|cut -b10-|tr -d '}'); do
            [ ${filebase}-oploss.pdf -nt ${tmpfile}.tex ] || return 0
        done
    else
        [ -s ${filebase}.pdf ] || return 0
        [ ${filebase}.pdf -nt ${filebase}.tex ] || return 0
        for tmpfile in $(grep '\\include{' ${filebase}.tex|cut -b10-|tr -d '}'); do
            [ ${filebase}.pdf -nt ${tmpfile}.tex ] || return 0
        done
    fi
    return 1
}
process_file() {
    #echo process_file $1 #debug
    foldername=$(dirname $1)
    cd $foldername
    filebase=$(basename $1)
    filebase=${filebase%.tex}

    if check_needrebuild $filebase; then needrebuild=1
    else needrebuild=0; fi

    if [ $force -eq 0 -a $needrebuild -eq 0 ]; then
        n_skipped=$((n_skipped + 1))
        echo "=== skipping ${foldername}/${filebase}.tex"
        if [ $cleanup -eq 1 ]; then
            if grep '^\\solution' ${filebase}.tex >/dev/null; then
                cleanup ${filebase}-vragen
                cleanup ${filebase}-oploss
            else
                cleanup $filebase
            fi
        fi
    else
        if grep '^\\solution' ${filebase}.tex >/dev/null; then
            sed 's/^\\solution.*/\\solutionfalse/' ${filebase}.tex >$tmpname
            compile_file $foldername $tmpname ${filebase}-vragen
            sed 's/^\\solution.*/\\solutiontrue/' ${filebase}.tex >$tmpname
            compile_file $foldername $tmpname ${filebase}-oploss
            rm $tmpname
        else
            compile_file $foldername ${filebase}.tex ${filebase}
        fi
    fi
    cd - >/dev/null
}

compile_file() {
    foldername=$1
    inputname=$2
    outputname=$3
    echo "=== creating ${foldername}/${outputname}.pdf"
    # remove old tmp files from previous run
    #eval rm -f ${outputname}.{$tmp_extensions}
    exitcode=0
    rm -f ${outputname}.pdf ${outputname}-withERRORS.pdf || exitcode=$?
    # compile, only if we were able to remove the previous pdf
    if [ $exitcode -eq 0 ]; then
        $compiler_cmd -jobname=$outputname $inputname || exitcode=$?
        compilecount=1
    fi
    # run biber, only if necessary
    if [ $exitcode -eq 0 -a -f ${outputname}.bcf ]; then
        if grep 'bcf:citekey' ${outputname}.bcf >/dev/null; then
            echo "    running biber and recompiling (pass 2)"
            $biber_cmd $outputname || exitcode=$?
            # compile 2nd time, only if biber was successful
            if [ $exitcode -eq 0 ]; then
                $compiler_cmd -jobname=$outputname $inputname || exitcode=$?
                compilecount=2
            else
                echo "    if biber failed due to UTF-8 errors, it might help to run following command:"
                echo "    iconv -f WINDOWS-1252 -t UTF-8 biblio.bib >tmpfile; mv tmpfile biblio.bib"
            fi
        fi
    fi
    while [ $exitcode -eq 0 ]; do
        # check if need to rerun
        if grep 'Rerun to' ${outputname}.log >/dev/null; then
            compilecount=$((compilecount + 1))
            echo "    compiling again (pass ${compilecount})"
            $compiler_cmd -jobname=$outputname $inputname || exitcode=$?
        else
            break
        fi
    done
    if [ $exitcode -eq 0 ]; then
        n_succes=$((n_succes + 1))
        echo "    OK"
        if [ $nocleanup -eq 0 ]; then cleanup $outputname; fi
    else
        n_failed=$((n_failed + 1))
        # errors from pdflatex doesn't always end with a newline
        # so, the 'echo' below will add a newline
        echo " !! Build FAILED !!"
        # rename pdf if build failed
        if [ -f ${outputname}.pdf ]; then
            mv ${outputname}.pdf ${outputname}-withERRORS.pdf || tmp=0 #don't die on failure
        fi
        # cleanup if requested
        if [ $cleanup -eq 1 ]; then cleanup $outputname; fi
    fi
}

cleanup() {
    # if the TeX-file contains 'includes', there will be additional files listed in aux-file
    # they are removed one-by-one
    if [ -f ${1}.aux ]; then
        for i in $( grep '^\\\@input' ${1}.aux | tr '{' '}'|cut -d'}' -f2);
            do rm -f $i;
        done
    fi
    eval rm -f ${1}.{$tmp_extensions}
}

## main ##

for i in "$@"; do
    case $i in
    -h|--help) usage; exit 1 ;;
    -f|--force) force=1 ;;
    -c|--cleanup) cleanup=1 ;;
    -nc|--nocleanup) nocleanup=1 ;;
    -x|--xelatex) compiler=xelatex ;;
    -*) die "Unexpected argument '$i'";;
    esac
done

# define the commands and their options here, for maintainability
if [ "${compiler}" = 'xelatex' ]; then
    compiler_cmd="xelatex -interaction=batchmode"
elif pdflatex --help|grep '\-quiet'>/dev/null; then
    compiler_cmd="pdflatex -interaction=batchmode -quiet"
else
    # some versions of pdflatex (eg. on Mac) don't recognize the '-quiet' option
    compiler_cmd="pdflatex -interaction=batchmode"
fi
echo "=== type 'sh $0 --help' for more details"

# get rid of all options in beginning of command line
while [ $# -gt 0 ]; do
    case $1 in
    -*) shift;;
    *) break;;
    esac
done

# if no "real" argument, search in current directory
if [ $# -eq 0 ]; then search_files .; fi

while [ $# -gt 0 ]; do
    # get rid of options in between the arguments
    case $1 in
    -*) shift; continue;;
    esac
    if [ -f $1 ]; then
        if echo $1 | grep '\.tex$' >/dev/null; then
            if grep '^\\documentclass' $1 >/dev/null; then
                process_file $1
            else
                echo "=== skipping $1 (\\documentclass is missing) ==="
            fi
        else
            echo "=== skipping $1 (not a .tex file) ==="
        fi
    elif [ -d $1 ]; then search_files $1;
    else
        echo "=== skipping $1 (not a FILE or DIRECTORY) ==="
    fi
    shift
done

n_total=$((n_skipped + n_failed + n_succes))
echo
echo "= REPORT ="
if [ $n_total -eq 0 ]; then
    echo "  There were no valid TeX files found"
    echo "  Type 'sh $0 --help' for more details"
else
    [ $n_skipped -eq 0 ] || echo "  $n_skipped/$n_total files were skipped because PDF was newer than TeX file"
    [ $n_succes -eq 0 ] || echo "  $n_succes/$n_total TeX files successfully compiled into PDF file"
    [ $n_failed -eq 0 ] || echo "  $n_failed/$n_total ERRORS: TeX files were NOT compiled successfully"
fi
