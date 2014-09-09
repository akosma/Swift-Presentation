#!/bin/sh

# Exports all the .swift files into .html files with the same names. The application
# then loads the contents of the HTML files into the application, to show the
# source code for any demo.

# This script requires Pygments 2.0pre to be installed in the local system:
# Pygments version 2.0pre, (c) 2006-2014 by Georg Brandl.
# When this project was created, the version of Pygments available
# through PIP was 1.6; however, version 2.0 (including Swift support)
# must be installed manually, downloading the code from
# https://bitbucket.org/birkenfeld/pygments-main/downloads
# and running the commands
# sudo ./setup.py build
# sudo ./setup.py install

DIR=html
PYG=/usr/local/bin/pygmentize
OPTS="-f html -O full,encoding=utf-8"

if [ -d "${DIR}" ];
    then rm -r ${DIR};
fi;
mkdir ${DIR}

# Find all the *.swift files, in all subfolders, and format them as HTML.
find PresentationKit/Demos -name \*.swift -exec ${PYG} ${OPTS} -o {}.html {} \;

# Move all the HTML files into a folder, which is automatically included inside
# of the bundle when Xcode builds the project.
find . -name \*.html -exec mv {} ${DIR} \; 2> /dev/null
