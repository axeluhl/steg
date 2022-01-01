# steg
Tool for steghide to embed large files in a collection of files

If you don't have it already, install the ``steghide`` tool on your distribution, e.g., using
```
   sudo apt-get install steghide
```
Then you can use the ``steg`` bash script as follows:

```
  steg [ -x ] [ -d <directory-with-cover-files> ] [ -p <passphrase> ] [ -e <encryption-algorithm> ] [ -h ] [ <embed-file> ]
```

If ``-x`` is provided, extracts a file from the cover files; otherwise, the <embed-file> or standard input will be embedded into the cover files in place, modifying one or more of the cover files.

To see the list of available encryption algorithms call ``steghide encinfo``.

If a directory is provided using ``-d``, all JPEG/jpeg/JPG/jpg files are listed and sorted by path and the files will be used in that order as cover files to extract or embed the content of the embed file. If no directory is provided with ``-d``, the cover files will be searched recursively, starting from the current directory.

If no ``<embed-file>`` is provided, the standard input will be embedded, or extraction will go to standard output, respectively.

If no passphrase is provided using the ``-p`` parameter, the tool will prompt for one.

Progress output goes to standard error.

The program exits with code 0 in case all went well; 1 in case there was input left that did not
fit into the cover file(s), and 2 if this usage hint was requested.

Request this usage hint by invoking with ``-h`` or without any arguments.
