# steg
A tool for [steghide](http://steghide.sourceforge.net/) to embed large files in a collection of files steganographically.

While the ``steghide`` tool can nicely embed a single "embed" file in one other "cover" file as long as the "cover" file's capacity is large enough, "embed" files larger than the capacity of a single "cover" file cannot be handled by ``steghide``. The ``steg`` script presented here aims at solving this problem by allowing you to specify a collection of "cover" files whose cumulative capacity must suffice to embed the "embed" file into them. Then, the capacity of each single "cover" file is determined, and with a certain safety margin (currently using 80% of the capacity listed by ``steghide info <cover-file>``) the "embed" file is encoded in chunks into the "cover" files. If the aggregated "cover" file capacity does not suffice, the command will exit with code 1. Note that if the capacity suffices, most likely not all "cover" files were really used. The standard error output will tell the files used.

By default, JPEG files in the current directory and its subdirectories (recursively) are used, but finding the cover files can be controlled by specifying a different directory (``-d``) and different file extensions (``-f``). Of course, only files acceptable as cover files for ``steghide`` must be specified (JPEG, BMP, WAV, AU).

Example:
```
	steg -p mysecretpassword IMG_1234.JPG
```
This will find all JPEG/jpeg/JPG/jpg files in the current folder and all its subfolders as "cover" files and will embed the file ``IMG_1234.JPG`` in as many of those "cover" files as are required based on their capacity. To extract from the same set of "cover" files, use
```
	steg -x -p mysecretpassword IMG_1234.JPG.copy
```
Trying this you should notice that the ``.copy`` file's contents will equal those of the original file.

### Installation

If you don't have it already, install the ``steghide`` tool on your distribution, e.g., using
```
   sudo apt-get install steghide
```
Clone the ``git@github.com:axeluhl/steg`` repo, e.g., to your ``/usr/local/src`` folder, like this:
```
	git clone git@github.com:axeluhl/steg.git
```
Link the script to your ``/usr/local/bin`` folder, like this:
```
	sudo ln -s /usr/local/src/steg/steg /usr/local/bin
```

## Synopsis
You can use the ``steg`` bash script as follows:
```
  steg [ -x ] [ -d <directory-with-cover-files> ] [ -p <passphrase> ] [ -e <encryption-algorithm> ] [ -f <comma-separated-list-of-file-extensions> ] [ -h ] [ <embed-file> ]
```

If ``-x`` is provided, extracts a file from the cover files; otherwise, the <embed-file> or standard input will be embedded into the cover files in place, modifying one or more of the cover files.

To see the list of available encryption algorithms call ``steghide encinfo``.

If a directory is provided using ``-d``, all JPEG/jpeg/JPG/jpg files are listed and sorted by path and the files will be used in that order as cover files to extract or embed the content of the embed file. If no directory is provided with ``-d``, the cover files will be searched recursively, starting from the current directory.

If no ``<embed-file>`` is provided, the standard input will be embedded, or extraction will go to standard output, respectively.

If no passphrase is provided using the ``-p`` parameter, the tool will prompt for one.

To override the default file extension list ``jpeg,jpg``, use the ``-f`` parameter. File name matching by extension is case-insensitive.

Progress output goes to standard error.

The program exits with code 0 in case all went well; 1 in case there was input left that did not
fit into the cover file(s), and 2 if this usage hint was requested.

Request this usage hint by invoking with ``-h`` or without any arguments.
