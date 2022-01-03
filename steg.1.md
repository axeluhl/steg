% STEG(1) steg 0.0.1
% Axel Uhl
% January 2022

# NAME
steg - A tool to hide a large file in several "cover" files

# SYNOPSIS

steg [ -x ] [ -d &lt;directory-with-cover-files&gt; ] [ -p &lt;passphrase&gt; ] [ -e &lt;encryption-algorithm&gt; ] [ -f &lt;comma-separated-list-of-file-extensions&gt; ] [ -h ] [ &lt;embed-file&gt; ]

# DESCRIPTION

A tool for [steghide](http://steghide.sourceforge.net/) to embed large files in a collection of files steganographically.

While the ``steghide`` tool can nicely embed a single "embed" file in one other "cover" file as long as the "cover" file's capacity is large enough, "embed" files larger than the capacity of a single "cover" file cannot be handled by ``steghide``. The ``steg`` script presented here aims at solving this problem by allowing you to specify a collection of "cover" files whose cumulative capacity must suffice to embed the "embed" file into them. Then, the capacity of each single "cover" file is determined, and with a certain safety margin (currently using 80% of the capacity listed by ``steghide info <cover-file>``) the "embed" file is encoded in chunks into the "cover" files. If the aggregated "cover" file capacity does not suffice, the command will exit with code 1. Note that if the capacity suffices, most likely not all "cover" files were really used. The standard error output will tell the files used.

By default, JPEG files in the current directory and its subdirectories (recursively) are used, but finding the cover files can be controlled by specifying a different directory (``-d``) and different file extensions (``-f``). Of course, only files acceptable as cover files for ``steghide`` must be specified (JPEG, BMP, WAV, AU).

If no ``<embed-file>`` is provided, the standard input will be embedded, or extraction will go to standard output, respectively.

Progress output goes to standard error.

# OPTIONS

**-x**
: If ``-x`` is provided, extracts a file from the cover files; otherwise, the _embed-file_ or standard input will be embedded into the cover files in place, modifying one or more of the cover files.

**-d** _directory-with-cover-files_
: If a directory is provided using ``-d``, all JPEG/jpeg/JPG/jpg files are listed and sorted by path and the files will be used in that order as cover files to extract or embed the content of the embed file. If no directory is provided with ``-d``, the cover files will be searched recursively, starting from the current directory.

**-p** _passphrase_
: If no passphrase is provided using the ``-p`` parameter, the tool will prompt for one. When embedding, the prompt is repeated for confirmation.

**-e** _encryption-algorithm_
: Specifies the encryption algorithm to use. Defaults to rijndael-256. To see the list of available encryption algorithms call ``steghide encinfo``.

**-f** _comma-separated-list-of-file-extensions_
: To override the default file extension list "jpeg,jpg", use the -f parameter. File name matching is case-insensitive, so "-f wav" will match all possible .wav and .WAV (and even .WaV) files.


**-h**
: displays a help text

# EXAMPLES

**steg -p mysecretpassword IMG_1234.JPG**
: This will find all JPEG/jpeg/JPG/jpg files in the current folder and all its subfolders as "cover" files and will embed the file **IMG_1234.JPG** in as many of those "cover" files as are required based on their capacity. To extract from the same set of "cover" files, use

**steg -x -p mysecretpassword IMG_1234.JPG.copy**
: Trying this you should notice that the **.copy** file's contents will equal those of the original file.
    
# EXIT VALUES

The program exits with code 0 in case all went well; 1 in case there was input left that did not
fit into the cover file(s), and 2 if this usage hint was requested. The tool exits with code 4 in
case an unknown option was found, and with 5 in case the confirmation password did not match
the original embed password.

# BUGS

None known so far.

# COPYRIGHT

This script is published under the Apache 2.0 license.
