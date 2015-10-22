# Mass-Java-Runner

This Bash script compiles multiple Java source files in a directory, runs them, and saves the output from the Java programs into .txt files.

The script can also be run with one or more input files, and the content of the input files will be supplied to the Java programs as the stdin. The output of each Java program from running with each input file would be appended to the .txt files.

The source code of the Java program(s) is also appended to the .txt files.

##How to Use

From the command line, type `massjavarunner.sh [ stdinFiles ]`

`stdinFiles`: One or more input files that would be supplied to the Java programs as stdin.
