(*
   simple spellchecker for pascal programs
*)
program sspell;

{$mode objfpc}{$H+}

uses
  Classes,
  SysUtils,
  SpellCheck;

var
  buf: TMemoryStream;
  linecount: integer = 1;
  rowcount: integer = 1;
  stime: TDateTime;
  commentlevel: integer = 0;
  Speller: TWordSpeller;

  procedure readchar(var ch: char);
  begin
    buf.Read(ch, 1);

    if ch = #10 then
    begin
      inc(linecount);
      rowcount := 1;
    end;

    if (ch <> #10) and (ch <> #13) then
      inc(rowcount);
  end;

  function nextchar: char;
  var
    ch: char = #0;
  begin
    buf.Read(ch, 1);
    buf.Seek(-1, soFromCurrent);

    exit(ch);
  end;

  procedure backchar;
  begin
    buf.Seek(-1, soFromCurrent);
    dec(rowcount);
  end;

  function IgnoreWord(s: string): boolean;
  const
    IgnoreList: array[1..262] of string = (
      'activepage',
      'actncolormaps',
      'actnctrls',
      'actnlist',
      'actnman',
      'actnmenus',
      'actnpopup',
      'actnres',
      'adoconst',
      'adodb',
      'adoint',
      'ansicomparestr',
      'ansicomparetext',
      'ansiuppercase',
      'appevnts',
      'asboolean',
      'asdatetime',
      'asfloat',
      'asinteger',
      'assign',
      'asstring',
      'asvariant',
      'axctrls',
      'bandactn',
      'bdeconst',
      'bdemts',
      'begindrag',
      'buttons',
      'caption',
      'checked',
      'checklst',
      'classes',
      'classname',
      'clear',
      'clipbrd',
      'close',
      'cmadmctl',
      'comctrls',
      'components',
      'comstrs',
      'consts',
      'controls',
      'count',
      'create',
      'ctlconsts',
      'ctlpanel',
      'customizedlg',
      'data',
      'databkr',
      'db',
      'dbactns',
      'dbcgrids',
      'dbclient',
      'dbclientactnres',
      'dbclientactns',
      'dbcommon',
      'dbconnadmin',
      'dbconsts',
      'dbctrls',
      'dbexcept',
      'dbgrids',
      'dblocal',
      'dblocali',
      'dblogdlg',
      'dblookup',
      'dbolectl',
      'dbpwdlg',
      'dbtables',
      'dbxpress',
      'ddeman',
      'dec',
      'delete',
      'destroy',
      'dialogs',
      'drtable',
      'dsintf',
      'enabled',
      'enddrag',
      'eof',
      'exception',
      'execute',
      'extactns',
      'extctrls',
      'extdlgs',
      'false',
      'fieldbyname',
      'filectrl',
      'first',
      'fmtbcd',
      'forms',
      'free',
      'freeandnil',
      'getfirstchild',
      'graphics',
      'graphutil',
      'grids',
      'height',
      'httpintr',
      'ib',
      'ibblob',
      'ibcustomdataset',
      'ibdatabase',
      'ibdatabaseinfo',
      'ibdclconst',
      'iberrorcodes',
      'ibevents',
      'ibexternals',
      'ibextract',
      'ibgeneratoreditor',
      'ibheader',
      'ibintf',
      'ibquery',
      'ibrestoreeditor',
      'ibsecurityeditor',
      'ibserviceeditor',
      'ibsql',
      'ibsqlmonitor',
      'ibstoredproc',
      'ibtable',
      'ibupdatesql',
      'ibutils',
      'ibxconst',
      'idabort',
      'idcancel',
      'idignore',
      'idispatch',
      'idno',
      'idok',
      'idretry',
      'idyes',
      'imglist',
      'inc',
      'initialize',
      'inttostr',
      'itemindex',
      'iunknown',
      'lines',
      'listactns',
      'mask',
      'math',
      'maxvalue',
      'mbabort',
      'mball',
      'mbcancel',
      'mbhelp',
      'mbignore',
      'mbno',
      'mbok',
      'mbretry',
      'mbyes',
      'mbyestoall',
      'mconnect',
      'menus',
      'messages',
      'midas',
      'midascon',
      'midconst',
      'minvalue',
      'mnnotoall',
      'mplayer',
      'mrabort',
      'mrall',
      'mrcancel',
      'mrignore',
      'mrno',
      'mrnone',
      'mrnotoall',
      'mrok',
      'mrretry',
      'mryes',
      'mryestoall',
      'mtconfirmation',
      'mtcustom',
      'mterror',
      'mtinformation',
      'mtsrdm',
      'mtwarning',
      'mxconsts',
      'name',
      'next',
      'nil',
      'objbrkr',
      'oleauto',
      'oleconst',
      'olectnrs',
      'olectrls',
      'oledb',
      'oleserver',
      'open',
      'ord',
      'outline',
      'paramstr',
      'pchar',
      'perform',
      'printers',
      'processmessages',
      'provider',
      'read',
      'readonly',
      'recerror',
      'recordcount',
      'register',
      'release',
      'result',
      'scktcnst',
      'scktcomp',
      'scktmain',
      'sconnect',
      'sender',
      'setfocus',
      'shadowwnd',
      'show',
      'showmessage',
      'simpleds',
      'smintf',
      'source',
      'sqlconst',
      'sqlexpr',
      'sqltimst',
      'stdactnmenus',
      'stdactns',
      'stdctrls',
      'stdstyleactnctrls',
      'strtoint',
      'svcmgr',
      'sysutils',
      'tabnotbk',
      'tabs',
      'tautoobject',
      'tbutton',
      'tcomponent',
      'tconnect',
      'tdatamodule',
      'text',
      'tform',
      'tframe',
      'themes',
      'tlist',
      'tnotifyevent',
      'tobject',
      'tobjectlist',
      'toolwin',
      'tpagecontrol',
      'tpersistent',
      'true',
      'tstringlist',
      'tstrings',
      'ttabsheet',
      'unassigned',
      'valedit',
      'value',
      'vdbconsts',
      'visible',
      'widestring',
      'width',
      'windows',
      'winhelpviewer',
      'write',
      'writeln',
      'xpactnctrls',
      'xpman',
      'xpstyleactnctrls');
  var
    item: string = '';
  begin

    //ignore one letter words or empty strings
    if length(s) <= 1 then
      exit(True);

    //ignore some
    for item in IgnoreList do
    begin
      if lowercase(s) = item then
        exit(True);
    end;

    exit(false);
  end;

  procedure parsestring(sline, srow: integer; s: string);
  var
    i, j: integer;
    sl: TStringList;
    first: boolean;
    spell: TSuggestionArray;
  begin
    if sline = 582 then
    begin
      sline := sline;
    end;

    //replace all non-alphabetical characters with white space
    for i := 1 to Length(s) do
    begin
      if not (s[i] in ['a'..'z', 'A'..'Z']) then
      begin
        s[i] := ' ';
      end;
    end;

    sl := TStringList.Create;
    sl.Clear;
    sl.Delimiter := ' ';
    sl.StrictDelimiter := True;
    sl.DelimitedText := Trim(s);

    //print line and row number
    first := True;

    for i := 0 to sl.Count - 1 do
    begin
      //skip one letter "words"
      if not IgnoreWord(sl[i]) then
      begin
        spell := Speller.SpellCheck(sl[i]);

        if Length(spell) > 0 then
        begin // we need to write suggestions

          if first then
          begin
            writeln(format('(%d,%d)', [sline, srow]));
            first := False;
          end;

          write('  "', sl[i], '"');

          for j := 0 to high(spell) do
            write(' ', spell[j]); // write out the suggestions

          writeln;
        end;
      end;
    end;

    sl.Free;
  end;

  {
  this function parses the following constructs

   - line comment   e.g. //blah blah
   - block comment  e.g. {} or (* *)
   - string literal e.g. ''
  }
  procedure parsefile;
  var
    ch: char = #0;
    s: string = '';
    sline, srow: integer;
  begin
    readchar(ch);
    //write(ch);

    case ch of

      '/':
      begin
        sline := linecount;
        srow := rowcount;

        readchar(ch);
        if ch = '/' then
        begin
          s := '';

          while (buf.Position < buf.Size) and (ch <> #10) do
          begin
            readchar(ch);
            s := s + ch;
          end;

          //writeln(format('(%d,%d) comment: "%s"', [sline, srow, trim(s)]));
          parsestring(sline, srow, s);
        end;
      end;

      '{':
      begin
        sline := linecount;
        srow := rowcount;

        readchar(ch);
        if ch <> '$' then
        begin
          if ch <> '}' then
            commentlevel := 1
          else
            commentlevel := 0;

          s := ch;

          while (buf.Position < buf.Size) and (commentlevel <> 0) do
          begin
            readchar(ch);

            if ch = '{' then
              inc(commentlevel);
            if ch = '}' then
              dec(commentlevel);

            if commentlevel > 0 then
              s := s + ch;
          end;

          //writeln(format('(%d,%d) comment: "%s"', [sline, srow, trim(s)]));
          parsestring(sline, srow, s);
        end;
      end;

      '(':
      begin
        sline := linecount;
        srow := rowcount;

        readchar(ch);
        if ch = '*' then
        begin
          readchar(ch);

          if (ch <> '*') and (nextchar <> ')') then
            commentlevel := 1
          else
            commentlevel := 0;

          s := ch;

          while (buf.Position < buf.Size) and (commentlevel <> 0) do
          begin
            readchar(ch);

            if (ch = '(') and (nextchar = '*') then
              inc(commentlevel);
            if (ch = '*') and (nextchar = ')') then
              dec(commentlevel);

            if commentlevel > 0 then
              s := s + ch;
          end;
          //swallow the last closing parenthesis
          readchar(ch);

          //writeln(format('(%d,%d) comment: "%s"', [sline, srow, trim(s)]));
          parsestring(sline, srow, s);
        end
        else
          //go back one just to be able to detect the (' construct.
          backchar;
      end;

      '''':
      begin
        sline := linecount;
        srow := rowcount;

        readchar(ch);
        if ch <> '''' then
        begin
          s := ch;

          while (buf.Position < buf.Size) and (ch <> '''') do
          begin
            readchar(ch);

            if ch <> '''' then
              s := s + ch;
          end;
          //writeln(format('(%d,%d) literal: "%s"', [sline, srow, trim(s)]));
          parsestring(sline, srow, s);
        end;
      end;
    end;
  end;

begin
  stime := now;

  Speller := TWordSpeller.Create;
  Speller.Language := ParamStr(1);

  writeln('Source code speller version 1.0.0 [', {$I %DATE%}, '] for ', {$I %FPCTARGETCPU%});
  writeln('Copyright (c) 2017 by Darius Blaszyk');

  writeln('processing: ', ParamStr(2));
  writeln('language: ', Speller.Language);
  writeln;

  //embed the file creation in a try/except block to handle errors gracefully
  try
    buf := TMemoryStream.Create;

    //set the name of the file that will be parsed
    buf.LoadFromFile(ParamStr(2));

    while buf.Position < buf.Size do
      parsefile;

    buf.Free;

  except
    //if there was an error the reason can be found here
    on E: EInOutError do
      writeln('File handling error occurred. Details: ', E.ClassName, '/', E.Message);
  end;

  Speller.Free;

  //linecount - 1 because a file always ends with #10
  writeln(format('%d lines processed, %.1f sec', [linecount - 1, (now - stime) * 24 * 3600]));
end.
