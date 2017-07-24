# sspell
A spell checker for (free)pascal source code files.

Compile with:

    fpc sspell.pp

Use with:

    ./sspell EN_GB sspell.pp

This command will invoke sspell with the EN_GB dictionary. Sspell will check its own source file and display any spelling error with the approximate location the word has been found in the file. Each spelling error will be accompanied with a number of suggestions.

## Todo
This tool has a lot of todo's! Any help is greatly appreciated. Please for and make pull requests.

- [ ] make sspell interactive
- [ ] add custom ignore words
- [ ] show context
- [ ] update source files immediately
- [ ] recursive scanning
