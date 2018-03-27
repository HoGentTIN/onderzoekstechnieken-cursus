#!/bin/bash

# grep -v -e '^$' -e '^#' .gitignore |sort -u

if pdflatex --help|grep '\-quiet'>/dev/null; then
    pdflatex_cmd="pdflatex -interaction=batchmode -quiet"
else
    pdflatex_cmd="pdflatex -interaction=batchmode"
fi
biber_cmd="biber --quiet"
tmp_extensions="aux bcf bbl blg idx log nav out run.xml snm synctex.gz toc vrb"

set -e
set -u

cmd=$0
nothing_processed=1

force=0
cleanup=0
nocleanup=0

n_skipped=0
n_failed=0
n_succes=0

usage() {
    echo "Usage: $0 [-a] FILE [FILE [FILE ...]]"
    echo "   or: $0 [-a] [DIR [DIR [DIR ...]]]"
    echo "Compile the specified TeX FILE(s) compile *all* TeX files"
    echo "in the specified DIR(s) and all the underlying subdirs (default value: .)"
    echo "By default, the files are compiled only if the TeX file is newer than the PDF"
    echo "By default, all temporary files are removed, but only after a successful build"
    echo " -f, --force     : always process the files, also if the PDF file is newer"
    echo " -c, --cleanup   : always remove tmp files, also if build failed or PDF newer"
    echo " -nc, --nocleanup: never remove temporary files, even if build was successful"
    echo " -h, --help      : show this help message"
    #TODO echo " -b, --biber   : force to run biber (by default only if .bcf contains 'citekey')"
    #TODO echo " -nb, --nobiber: don't run biber"
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
        compile_file $i
    done
}

compile_file() {
    #echo compile_file $1 #debug
    cd $(dirname $1)
    filebase=$(basename $1)
    filebase=${filebase%.tex}
    # checking if (one of) the tex file(s) has changed
    needrebuild=1
    if [ -s ${filebase}.pdf ]; then
        if [ ${filebase}.pdf -nt ${filebase}.tex ]; then
            needrebuild=0
            for tmpfile in $(grep '\\include{' ${filebase}.tex|cut -b10-|tr -d '}'); do
                if [ ${filebase}.pdf -ot ${tmpfile}.tex ]; then
                    needrebuild=1
                    break
                fi
            done
        fi
    fi
    if [ $force -eq 0 -a $needrebuild -eq 0 ]; then
        n_skipped=$((n_skipped + 1))
        echo "=== skipping $1"
        if [ $cleanup -eq 1 ]; then cleanup; fi
    else
        echo "=== compiling $1"
        # remove old tmp files from previous run
        for i in $tmp_extensions; do rm -f ${filebase}.$i; done
        exitcode=0
        rm -f ${filebase}.pdf ${filebase}-withERRORS.pdf || exitcode=$?
        # compile, only if we were able to remove the previous pdf
        if [ $exitcode -eq 0 ]; then
            $pdflatex_cmd ${filebase}.tex || exitcode=$?
        fi
        # run biber, only if necessary
        if [ $exitcode -eq 0 -a -f ${filebase}.bcf ]; then
            if grep 'bcf:citekey' ${filebase}.bcf >/dev/null; then
                echo "    running biber and recompiling"
                $biber_cmd $filebase || exitcode=$?
                # compile 2nd time, only if biber was successful
                if [ $exitcode -eq 0 ]; then
                    $pdflatex_cmd ${filebase}.tex || exitcode=$?
                fi
            fi
        elif [ $exitcode -eq 0 ]; then
            # compile 2nd time, if necessary
            changed=1
            grep 'Package rerunfilecheck Info: File' -A1 ${filebase}.log | tr -d '\n' | grep -e 'has not changed' >/dev/null && changed=0
            #TODO: add double check
            #grep 'Package rerunfilecheck Warning: File' -A1 ${filebase}.log | tr -d '\n' | grep -e 'has changed' && changed=1
            if [ $changed -eq 1 ]; then
                echo "    compiling 2nd time"
                $pdflatex_cmd ${filebase}.tex || exitcode=$?
            fi
        fi
        if [ $exitcode -eq 0 ]; then
            n_succes=$((n_succes + 1))
            echo "    OK"
            if [ $nocleanup -eq 0 ]; then cleanup; fi
        else
            n_failed=$((n_failed + 1))
            # errors from pdflatex doesn't always end with a newline
            # so, the 'echo' below will add a newline
            echo 
            # rename pdf if build failed
            if [ -f ${filebase}.pdf ]; then
                mv ${filebase}.pdf ${filebase}-withERRORS.pdf || tmp=0 #don't die on failure
            fi
            # cleanup if requested
            if [ $cleanup -eq 1 ]; then cleanup; fi
        fi
    fi
    cd - >/dev/null
    nothing_processed=0
}

cleanup() {
    if [ -f ${filebase}.aux ]; then
        for i in $( grep '^\\\@input' ${filebase}.aux | tr '{' '}'|cut -d'}' -f2);
            do rm -f $i;
        done
    fi
    for i in $tmp_extensions; do rm -f ${filebase}.$i; done
}

## main ##

for i in "$@"; do
    case $i in
    -h|--help) usage; exit 1 ;;
    -f|--force) force=1 ;;
    -c|--cleanup) cleanup=1 ;;
    -nc|--nocleanup) nocleanup=1 ;;
    -*) die "Unexpected argument '$i'";;
    esac
done

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
    if [ -f $1 ]; then compile_file $1;
    elif [ -d $1 ]; then search_files $1;
    else
        echo "=== skipping $1 (not a FILE or DIRECTORY) ==="
    fi
    shift
done

if [ $nothing_processed -eq 1 ]; then
    die 'no valid TeX files found'
else
    n_total=$((n_skipped + n_failed + n_succes))
    echo
    echo "= REPORT ="
    [ $n_skipped -eq 0 ] || echo "  $n_skipped/$n_total files were skipped because TeX file was newer than PDF ==="
    [ $n_succes -eq 0 ] || echo "  $n_succes/$n_total TeX files successfully compiled into PDF file ==="
    [ $n_failed -eq 0 ] || echo "  $n_failed/$n_total ERRORS: TeX files were NOT compiled successfully ==="
fi
