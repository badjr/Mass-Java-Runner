# Mass-Java-Runner

This Bash script compiles multiple Java source files in a directory, runs them, and saves the output from the Java programs into .txt files. It's ideal for an instructor, for instance, who wants to speed up the compile and run process of their students' Java programs.

The script can be run without input files, or with one or more input files. The content of the input files are supplied to the Java programs as the standard input stream. The output for each Java program is appended to output .txt files. If input files are supplied, the output from each input file is also appended. The source code of the Java program(s) is also appended to the .txt files.

##How to Use

Place the Java source files, input files (if any), and the Bash script into a directory. From the command line, go to that directory and type `./massjavarunner.sh [ stdinFiles ]`

`stdinFiles`: One or more input files that would be supplied to the Java programs as stdin.

##Disclaimer

It's not bug free. Click [here](https://github.com/badjr/Mass-Java-Runner/issues) for known bugs.
