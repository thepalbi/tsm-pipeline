import javascript

query int linesOfCode() {
    result = sum(File f || f.getNumberOfLinesOfCode())
}