#!/bin/bash

# grep -v -e '^$' -e '^#' .gitignore |sort -u

pdflatex_cmd="pdflatex -interaction=batchmode -quiet"
biber_cmd="biber --quiet"
tmp_extensions="aux bcf bbl blg idx log nav out run.xml snm synctex.gz toc vrb"

set -e
set -u

cmd=$0
nothing_processed=1
force=0
cleanup=0
nocleanup=0

usage() {
    echo "Usage: $0 [-a] FILE [FILE [FILE ...]]"
    echo "       $0 [-a] [DIRECTORY]"
    echo "Compile the TeX FILE(s) listed"
    echo "Compile all TeX files in 'DIRECTORY' and its subdirs (default value: .)"
    echo "By default, the files are compiled only if the TeX file is newer than the PDF"
    echo "By default, all temporary files are removed, but only after a successful build"
    echo " -f, --force   : always process the files, also if the TeX file is newer"
    echo " -c, --cleanup : always remove tmp files, also if build failed or file is skipped"
    echo " -nc, --nocleanup: never remove temporary files, even if build was successful"
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
    for i in $(grep --files-with-matches '^\\documentclass' $(find $1 -type f -name '*.tex')); do
        compile_file $i
    done
}

compile_file() {
    cd $(dirname $1)
    filebase=$(basename $1)
    filebase=${filebase%.tex}
    if [ $force -eq 0 -a -s ${filebase}.pdf -a ${filebase}.pdf -nt ${filebase}.tex ]; then
        echo "=== skipping $1 (PDF newer than TEX)"
        if [ $cleanup -eq 1 ]; then cleanup; fi
    else
        echo "=== compiling $1"
        for i in $tmp_extensions; do rm -f ${filebase}.$i; done
        rm -f ${filebase}.pdf ${filebase}-withERRORS.pdf
        exitcode=0
        $pdflatex_cmd ${filebase}.tex || exitcode=$?
        if [ $exitcode -eq 0 -a -f ${filebase}.bcf ]; then
            if grep 'bcf:citekey' ${filebase}.bcf >/dev/null; then
                echo "    running biber and recompiling"
                exitcode=0
                $biber_cmd $filebase || exitcode=$?
                if [ $exitcode -eq 0 ]; then
                    rm -f ${filebase}.pdf
                    exitcode=0
                    $pdflatex_cmd ${filebase}.tex || exitcode=$?
                fi
            fi
        fi
        if [ $exitcode -eq 0 ]; then
            echo "    OK"
            if [ $nocleanup -eq 0 ]; then cleanup; fi
        else
            # add '\n' because errors from pdflatex doesn't always end with newline
            echo 
            # rename pdf if build failed
            if [ -f ${filebase}.pdf ]; then
                mv ${filebase}.pdf ${filebase}-withERRORS.pdf
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
    -f|--force) force=1 ;;
    -c|--cleanup) cleanup=1 ;;
    -nc|--nocleanup) nocleanup=1 ;;
    -*) die "Unexpected argument '$i'";;
    esac
done

# get rid all options in beginning of command line
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
    usage
else
    echo "=== done! ==="
fi
