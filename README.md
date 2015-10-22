# Mass-Java-Runner

This Bash script compiles multiple Java source files in a directory, runs them, and saves the output from the Java programs into .txt files.

The script can also be run with one or more input files, and the content of the input files will be supplied to the Java programs as the stdin. The output of the Java program from running with the different input files would be appended to the .txt files.

##How to Use

From the command line, type `massjavarunner.sh [ stdinFiles ]`

`stdinFiles`: One or more input files that would be supplied to the Java programs as stdin.
