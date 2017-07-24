# sspell
A spell checker for (free)pascal source code files.

Compile with:

    fpc sspell.pp

Use with:

    ./sspell EN_GB sspell.pp

This command will invoke sspell with the EN_GB dictionary. You can use any language as long as it's installed. In this example sspell will check its own source file and display any spelling error with the approximate location the word has been found in the file. Each spelling error will be accompanied with a number of suggestions.

Example output:

    processing: sspell.pp
    language: EN_GB

    (428,12)
      "sline" saline sling Sloane slain spline Aline slime line sine sluing soling Seine seine slink Cline Kline Salinger Stine slice slide spine swine Sloan Solon salon alien salines saltine lien sullen liner lone sailing sinew singe sloe slue soloing Lin sin skyline Milne Slinky seiner slings slinky sealing selling soiling Lane Lina cine lane ling lino sane sing zine saline's sling's
      "srow" SRO stow row sow Crow Snow brow crow grow prow scow slow snow trow show
    (461,12)
      "sline" saline sling Sloane slain spline Aline slime line sine sluing soling Seine seine slink Cline Kline Salinger Stine slice slide spine swine Sloan Solon salon alien salines saltine lien sullen liner lone sailing sinew singe sloe slue soloing Lin sin skyline Milne Slinky seiner slings slinky sealing selling soiling Lane Lina cine lane ling lino sane sing zine saline's sling's
      "srow" SRO stow row sow Crow Snow brow crow grow prow scow slow snow trow show
    (498,12)
      "sline" saline sling Sloane slain spline Aline slime line sine sluing soling Seine seine slink Cline Kline Salinger Stine slice slide spine swine Sloan Solon salon alien salines saltine lien sullen liner lone sailing sinew singe sloe slue soloing Lin sin skyline Milne Slinky seiner slings slinky sealing selling soiling Lane Lina cine lane ling lino sane sing zine saline's sling's
      "srow" SRO stow row sow Crow Snow brow crow grow prow scow slow snow trow show
    (523,12)
      "sline" saline sling Sloane slain spline Aline slime line sine sluing soling Seine seine slink Cline Kline Salinger Stine slice slide spine swine Sloan Solon salon alien salines saltine lien sullen liner lone sailing sinew singe sloe slue soloing Lin sin skyline Milne Slinky seiner slings slinky sealing selling soiling Lane Lina cine lane ling lino sane sing zine saline's sling's
      "srow" SRO stow row sow Crow Snow brow crow grow prow scow slow snow trow show
    (560,4)
      "linecount" line count line-count lineament lenient encounter liniment conjoint linking L'Enfant longhorn longboat longhand longhorns litigant longhorn's
    562 lines processed, 0.4 sec


## Todo
This tool has a lot of todo's! Any help is greatly appreciated. Please fork and make pull requests to improve this tool.

- [ ] implement interactive cli
- [ ] add custom ignore words
- [ ] show context while scanning
- [ ] update source files immediately
- [ ] recursive scanning
- [ ] remember changes within same session for duplicates
- [ ] auomatically ignore variable names
