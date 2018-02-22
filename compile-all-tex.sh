#!/bin/bash

# grep -v -e '^$' -e '^#' .gitignore |sort -u

pdflatex_cmd="pdflatex -interaction=batchmode -quiet"
tmp_extensions="aux bib.bbl bcf bib.blg cmptexlog idx log nav out run.xml snm synctex.gz toc vrb"

cmd=$0
nothing_processed=1

set -e
set -u

usage() {
    echo "Usage: $0 FILE [FILE [FILE ...]]"
    echo "       $0 [DIRECTORY]"
    #echo "Usage: $0 [-f|--force] FILE [FILE [FILE ...]]"
    #echo "       $0 [-f|--force] [DIRECTORY]"
    echo "Compile the Tex FILE(s) listed"
    echo "Compile all Tex files in 'DIRECTORY' and its subdirs (default value: .)"
    echo "By default, the files are compiled only if the Tex file is newer than the PDF"
    #echo " -f, --force : *always* process the files, also if the TeX file is newer"
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
    if [ -s ${filebase}.pdf -a ${filebase}.pdf -nt ${filebase}.tex ]; then
        echo "=== skipping $1 (PDF newer than TEX)"
        #ls -lrt ${filebase}.{tex,pdf} #for debugging
    else
        exitcode=0
        echo "=== compiling $1"
        rm -f ${filebase}.pdf
        $pdflatex_cmd ${filebase}.tex || exitcode=$?
        if [ $exitcode -eq 0 ]; then
            echo "    OK"
            # cleanup stuff
            for i in $tmp_extensions; do rm -f ${filebase}.$i; done
            #ls -l ${filebase}.* #for debugging
        else
            echo # because errors from pdflatex doesn't always end with newline
        fi
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
