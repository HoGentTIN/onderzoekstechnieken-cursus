#!/bin/bash

# grep -v -e '^$' -e '^#' .gitignore |sort -u

pdflatex_cmd="pdflatex -interaction=batchmode -quiet"
tmp_extensions="aux bbl bcf blg cmptexlog idx latexmain log nav out run.xml snm toc vrb"

cmd=$0
nothing_processed=1

set -e
set -u

usage() {
    echo "Usage: $0 FILE [FILE [FILE ...]]"
    echo "       $0 [DIRECTORY]"
    echo "Compile one or more LaTex files"
    echo "Compile all LaTex files in 'DIRECTORY' and its subdirs (default value: .)"
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
    exitcode=0
    echo "=== compiling $1 ==="
    $pdflatex_cmd ${filebase}.tex || exitcode=$?
    if [ $exitcode -eq 0 ]; then
        # cleanup stuff
        for i in $tmp_extensions; do rm -f ${filebase}.$i; done
        # show remaining stuff (for debugging)
        #ls -l ${filebase}.*
    else
        echo
    fi
    cd - >/dev/null
    nothing_processed=0
}

if [ $# -eq 0 ]; then
    search_files .
fi
while [ $# -gt 0 ]; do
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
