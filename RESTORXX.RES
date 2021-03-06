� �� 0   d   restorxxe  msgf   ��� 0�  _DrsAideDialogInit_�/* Source file: D:\DRDIALOG\DRSAIDE.RXL */
/* File last modified on:         12/20/93 at 11:26pm */
/* Procedure added to library on: 12/20/93 at 11:26pm */
/* Procedure imported on:         12/21/93 at 00:36am */

/* Usage is: CALL _DrsAideDialogInit */
IF left( hwnd, 2 ) = '-H' THEN DO
   CALL DrDialog 'Init', hwnd
   CALL DrDialog 'Owner', Dialog()
   IF RxFuncQuery( 'SysLoadFuncs' ) THEN DO
      CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
      CALL SysLoadFuncs
      END
   PARSE SOURCE . . iniApp
   temp = lastpos( '\', iniApp )
   IF temp = 0 THEN temp = lastpos( ':', iniApp )
   iniApp = translate( substr( iniApp, temp + 1 ) )
   temp   = lastpos( '.', iniApp )
   IF temp <> 0 THEN iniApp = left( iniApp, temp - 1 )
   PARSE VALUE SysIni( iniFile, iniApp, 'Pos' ) WITH dlgX dlgY dlgDX dlgDY
   IF dlgX <> 'ERROR:' THEN CALL Position dlgX, dlgY, dlgDX, dlgDY
   END
CALL Show
�� �d 0y   y   �  ��          h �  � ~ � & d ��q          u @�  �  e ����        v  �N  (  f ����REStoRXX    OK ���d 0�   �d Initp/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

SIGNAL DoArgs�f ClickEXIT���� 08  /* Convert a .RES file to an annotated .REX file */
/* Written by: David C. Morrill                  */
/* Date: 11/16/93                                */

DoArgs:
   CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
   CALL SysLoadFuncs

   PARSE ARG hwnd iniFile rest
   IF left( hwnd, 2 ) = '-H' THEN DO
      CALL DrDialog 'Init', hwnd
      resData = DrDialog( 'GetRes' )
      resFile = DrDialog( 'FileName' )
      IF resFile = '' THEN resFile = 'C:\UNKNOWN.RES'
      col = lastpos( '.', resFile )
      IF col = 0 THEN col = length( resFile ) + 1
      rexFile = FilePrompt( left( resFile, col - 1 )'.RXX',,, 'Save' )
      IF rexFile = '' THEN EXIT
      END
   ELSE DO
      PARSE ARG resFile
      IF lastpos( '.', resFile ) = 0 THEN resFile = resFile'.RES'
      IF (SysFileTree( resFile, 'resFiles', 'FO' ) <> 0) |,
         (resFiles.0 <> 1) |,
         (rest <> '') THEN DO
         CALL msg.Text 'Please specify a DrRexx .RES file'
         CALL Show
         SIGNAL RETURN
         END
      resFile = resFiles.1
      col     = lastpos( '.RES', translate( resFile ) )
      rexFile = left( resFile, col )'RXX'
      resData = CharIn( resFile, 1, Chars( resFile ) )
      CALL Stream resFile, 'C', 'CLOSE'
      IF resData = '' THEN DO
         CALL msg.Text 'Could not read' resFile
         CALL Show
         SIGNAL RETURN
         END
      END
   CALL SysFileDelete( rexFile )
   column    = 1
   dialogs   = 0
   globals   = ''
   externals = ''
   blanks    = copies( ' ', 77 )
   dashes    = copies( '-', 77 )
   types     = 'DIALOG PUSHBUTTON CHECKBOX RADIOBUTTON TEXTBOX NOTEBOOK',
               'CONTAINER LISTBOX ENTRYFIELD MLE COMBOBOX SPINBUTTON',
               'VALUESET VSCROLLBAR HSCROLLBAR SLIDER GROUPBOX FRAME',
               'RECTANGLE BILLBOARD CANVAS PAINT ICONBUTTON BAGBUTTON',
               'TURTLE BITMAP USER MARQUEE'
   DO FOREVER
      IF column > length( resData ) THEN LEAVE
      IF substr( resData, column, 1 ) <> 'FF'X THEN DO
         CALL msg.Text resFile 'is not a valid .RES file'
         CALL Show
         SIGNAL RETURN
         END
      type   = C2D( reverse( substr( resData, column + 1, 2 ) ) )
      id     = C2D( reverse( substr( resData, column + 4, 2 ) ) )
      len    = C2D( reverse( substr( resData, column + 8, 4 ) ) )
      data   = substr( resData, column + 12, len )
      column = column + len + 12
      CALL DoResource type, id, data
   END
   CALL SysFileTree resFile, 'FILES', 'F'
   IF files.0 = 0 THEN date1 = ''
   ELSE DO
      date1 = right( word( files.1, 1 ), 8, '0' )
      time1 = right( word( files.1, 2 )'m', 7, '0' )
      END
   date2   = right( date( 'U' ), 8, '0' )
   time2   = right( time( 'C' ), 7, '0' )
   first   = 1
   sawInit = 0
   IF date1 = '' THEN
      CALL Comment 'REXX source code listing for DrRexx application:',,
           '  'resFile, '',,
           'Listing produced on:  ' date2 'at:' time2
   ELSE
      CALL Comment 'REXX source code listing for DrRexx application:',,
           '  'resFile, '',,
           'File last modified on:' date1 'at:' time1,,
           'Listing produced on:  ' date2 'at:' time2
   CALL LineOut rexFile, ''
   CALL LineOut rexFile, 'SIGNAL ON SYNTAX'
   CALL LineOut rexFile, 'SIGNAL ON HALT'
   CALL LineOut rexFile, 'SIGNAL INIT'
   CALL LineOut rexFile, ''
   CALL LineOut rexFile, 'RETURN:'
   CALL LineOut rexFile, '  SIGNAL VALUE DrRexxEvent()'
   CALL LineOut rexFile, ''
   CALL LineOut rexFile, 'L1:'
   CALL LineOut rexFile, '  EXIT -1'
   CALL LineOut rexFile, ''
   CALL LineOut rexFile, 'L2:'
   CALL LineOut rexFile, '  INTERPRET DrRexxInterpret()'
   CALL LineOut rexFile, '  SIGNAL RETURN'
   DO d = 1 TO dialogs
      id = dialog.d
      CALL GetNames names.id
      IF event.id <> '' THEN DO
         CALL Comment 'Event handlers for dialog:' dialogName
         CALL DoEvent event.id
         END
      IF class.id <> '' THEN DO
         CALL Comment 'Class handlers for dialog:' dialogName
         CALL DoClass class.id
         END
      IF menu.id <> '' THEN DO
         CALL Comment 'Menu handlers for dialog:' dialogName
         menuCode  = menu.id
         menuLevel = 1
         CALL LineOut rexFile, ''
         CALL DoMenu menuRes.id
         END
   END
   IF globals <> '' THEN DO
      CALL Comment 'Global procedures:'
      CALL DoProcs globals
      END
   IF sawInit = 0 THEN DO
      CALL Comment 'Default initialization:'
      CALL LineOut rexFile, ''
      CALL LineOut rexFile, 'INIT:'
      CALL LineOut rexFile, '  SIGNAL RETURN'
      END
   CALL Comment 'Default error handlers:'
   CALL LineOut rexFile, ""
   CALL LineOut rexFile, "SYNTAX:"
   CALL LineOut rexFile, "  SAY 'SYNTAX ERROR:' errortext( rc ) 'in:'"
   CALL LineOut rexFile, "  SAY sourceline( sigl )"
   CALL LineOut rexFile, "  SIGNAL ON SYNTAX"
   CALL LineOut rexFile, "  SIGNAL RETURN"
   CALL LineOut rexFile, ""
   CALL LineOut rexFile, "HALT:"
   CALL LineOut rexFile, "  SAY 'HALT occurred in:'"
   CALL LineOut rexFile, "  SAY sourceline( sigl )"
   CALL LineOut rexFile, "  SIGNAL ON HALT"
   CALL LineOut rexFile, "  SIGNAL RETURN"
   IF externals <> '' THEN DO
      CALL Comment 'External procedures:'
      CALL LineOut rexFile, ''
      CALL CharOut rexFile, externals
      END
   EXIT

DoResource:
   SELECT
     WHEN arg(1) = 3 THEN DO /* Menu */
       id         = arg(2)
       menuRes.id = arg(3)
       END
     WHEN arg(1) = 4 THEN DO /* Dialog */
       END
     WHEN arg(1) = 56320 THEN DO /* Dialog/control names */
       CALL DialogNames arg(3)
       END
     WHEN arg(1) = 56321 THEN DO /* Global procedures code */
       globals = left( arg(3), length( arg(3) ) - 1 )
       END
     WHEN arg(1) = 56322 THEN DO /* External code */
       externals = arg(3)
       END
     WHEN arg(1) = 56323 THEN DO /* Dialog menu code */
       id      = arg(2)
       menu.id = arg(3)
       END
     WHEN arg(1) = 56324 THEN DO /* Dialog event code */
       id       = arg(2)
       event.id = arg(3)
       END
     WHEN arg(1) = 56325 THEN DO /* Dialog class code */
       id       = arg(2)
       class.id = arg(3)
       END
     OTHERWISE /* Do nothing - unknown resource type */
   END
   RETURN

DialogNames:
   i     = 1
   start = 0
   data  = arg(1)
   DO WHILE i <= length( data )
      IF substr( data, i + 2, 2 ) = '0000'X THEN DO
         IF start <> 0 THEN DO
            names.id = substr( data, start, i - start )
            END
         id             = C2D( reverse( substr( data, i, 2 ) ) )
         dialogs        = dialogs + 1
         dialog.dialogs = id
         event.id       = ''
         class.id       = ''
         menu.id        = ''
         start          = i
         END
      i = i + C2D( substr( data, i + 4, 1 ) ) + 5
   END
   names.id = substr( data, start, i - start )
   RETURN

GetNames:
   DROP type. name.
   i    = 1
   data = arg(1)
   DO WHILE i <= length( data )
      curId      = C2D( reverse( substr( data, i, 2 ) ) )
      curType    = C2D( reverse( substr( data, i + 2, 2 ) ) )
      curLen     = C2D( substr( data, i + 4, 1 ) )
      type.curId = word( types, curType + 1 )
      IF curLen = 0 THEN DO
         IF curType = 0 THEN prefix = 'D'; ELSE prefix = 'C'
         name.curId = prefix || curId
         END
      ELSE name.curId = substr( data, i + 5, curLen )
      IF curType = 0 THEN dialogName = name.curId
      i = i + curLen + 5
   END
   RETURN

Usage:
   SAY 'Usage error'
   EXIT 100

Comment:
   IF first = 1 THEN first = 0
   ELSE CALL LineOut rexFile, ' '
   CALL LineOut rexFile, '/*'dashes'+'
   CALL LineOut rexFile, '|'blanks '|'
   DO i = 1 TO arg()
      CALL LineOut rexFile,,
                   '|  'arg(i) || copies( ' ', 76 - length( arg(i) ) )'|'
   END
   CALL LineOut rexFile, '|'blanks '|'
   CALL LineOut rexFile, '+'dashes'*/'
   RETURN

DoCode:
   code = arg(1)
   j    = 1
   DO WHILE j <= length( code )
      col = pos( '0D'X, code, j )
      IF col = 0 THEN col = length( code ) + 1
      line = substr( code, j, col - j )
      CALL LineOut rexFile, ' ' line
      j = col + 2
   END
   RETURN translate( word( line, 1 ) )

DoEvent:
   data = arg(1)
   i    = 1
   DO FOREVER
      curLen = C2D( substr( data, i, 1 ) )
      IF curLen = 255 THEN LEAVE
      IF curLen = 128 THEN DO
         curId  = C2D( reverse( substr( data, i + 1, 2 ) ) )
         i      = i + 3
         curLen = C2D( substr( data, i, 1 ) )
         CALL LineOut rexFile, ' '
         CALL LineOut rexFile, '/* Event handlers for:' name.curId '('type.curId') */'
         END
      curEvent = substr( data, i + 1, curLen )
      i        = i + curLen + 1
      curLen   = C2D( substr( data, i, 1 ) )
      IF curLen > 127 THEN DO
         i      = i + 1
         curLen = (curLen - 128) + 128 * C2D( substr( data, i, 1 ) )
         END
      CALL LineOut rexFile, ' '
      IF type.curId = 'DIALOG' THEN
         CALL LineOut rexFile, dialogName'_'curEvent':'
      ELSE
         CALL LineOut rexFile, dialogName'_'name.curId'_'curEvent':'
      IF DoCode( substr( data, i + 1, curLen ) ) <> 'SIGNAL' THEN
         CALL LineOut rexFile, '  SIGNAL RETURN'
      i = i + curLen + 1
   END
   RETURN

DoClass:
   data = arg(1)
   i    = 1
   DO FOREVER
      curLen = C2D( substr( data, i, 1 ) )
      IF curLen = 255 THEN LEAVE
      IF curLen = 128 THEN DO
         curType = word( types, C2D( reverse( substr( data, i + 1, 2 ) ) ) + 1 )
         i       = i + 3
         curLen  = C2D( substr( data, i, 1 ) )
         CALL LineOut rexFile, ' '
         CALL LineOut rexFile, '/* Class handlers for:' curType '*/'
         END
      curEvent = substr( data, i + 1, curLen )
      i        = i + curLen + 1
      curLen   = C2D( substr( data, i, 1 ) )
      IF curLen > 127 THEN DO
         i      = i + 1
         curLen = (curLen - 128) + 128 * C2D( substr( data, i, 1 ) )
         END
      CALL LineOut rexFile, ''
      CALL LineOut rexFile, dialogName'_'curType'_'curEvent':'
      IF DoCode( substr( data, i + 1, curLen ) ) <> 'SIGNAL' THEN
         CALL LineOut rexFile, '  SIGNAL RETURN'
      i = i + curLen + 1
   END
   RETURN

DoProcs:
   procs = arg(1)
   i     = 1
   DO WHILE i <= length( procs )
      len  = C2D( substr( procs, i, 1 ) )
      name = substr( procs, i + 1, len )
      IF translate( name ) = 'INIT' THEN sawInit = 1
      CALL LineOut rexFile, ''
      CALL LineOut rexFile, name':'
      i   = i + len + 1
      len = C2D( substr( procs, i, 1 ) )
      IF len > 127 THEN DO
         i   = i + 1
         len = (len - 128) + 128 * C2D( substr( procs, i, 1 ) )
         END
      IF DoCode( substr( procs, i + 1, len ) ) <> 'RETURN' THEN DO
         IF translate( name ) = 'INIT' THEN
            CALL LineOut rexFile, '  SIGNAL RETURN'
         ELSE CALL LineOut rexFile, '  RETURN'
         END
      i = i + len + 1
   END
   RETURN

DoMenu: PROCEDURE EXPOSE menuCode menuLevel rexFile
   MIS_TEXT      = '0100'x
   MIS_SEPARATOR = '0400'x
   MIS_SUBMENU   = '1000'x
   MIS_STATIC    = '0001'x
   MIA_CHECKED   = '0020'x
   MIA_DISABLED  = '0040'x
   data   = arg(1)
   n      = C2D( reverse( substr( data, 9, 2 ) ) )
   col    = 11
   nextId = -1
   IF length( menuCode ) >= 2 THEN
      nextId = C2D( reverse( substr( menuCode, 1, 2 ) ) )
   DO i = 1 TO n
      style    = substr( data, col, 2 )
      attr     = substr( data, col + 2, 2 )
      curId    = C2D( reverse( substr( data, col + 4, 2 ) ) )
      col      = col + 6
      attrText = ''
      label    = ''
      code     = ''
      IF curId = nextId THEN DO
         len   = C2D( substr( menuCode, 3, 1 ) )
         label = substr( menuCode, 4, len )
         col2  = 4 + len
         len   = C2D( substr( menuCode, col2, 1 ) )
         IF len > 127 THEN DO
            col2 = col2 + 1
            len = (len - 128) + 128 * C2D( substr( menuCode, col2, 1 ) )
            END
         code     = substr( menuCode, col2 + 1, len )
         menuCode = substr( menuCode, col2 + 1 + len )
         nextId   = -1
         IF length( menuCode ) >= 2 THEN
            nextId = C2D( reverse( substr( menuCode, 1, 2 ) ) )
         END
      IF BITAND( attr, MIA_CHECKED  ) <> '0000'x THEN attrText = '(Checked'
      IF BITAND( attr, MIA_DISABLED ) <> '0000'x THEN DO
         IF attrText = '' THEN attrText = '('; ELSE attrText = attrText' '
         attrText = attrText || 'Disabled'
         END
      IF attrtext <> '' THEN attrText = attrText') '
      IF BITAND( style, MIS_TEXT ) <> '0000'x THEN DO
         col2 = pos( '00'x, data, col )
         text = substr( data, col, col2 - col )
         col  = col2 + 1
         END
      ELSE text = ''
      IF BITAND( style, MIS_SEPARATOR ) <> '0000'x THEN DO
         CALL LineOut rexFile, '/*'copies( ' ', menuLevel )'----------' attrText'*/'
         IF label <> '' THEN
            CALL LineOut rexFile, '/*'copies(' ', menuLevel)'- Label:' label '*/'
         END
      ELSE DO
         CALL LineOut rexFile, '/*'copies( ' ', menuLevel ) || text attrText'*/'
         IF label <> '' THEN
            CALL LineOut rexFile, '/*'copies(' ', menuLevel)'- Label:' label '*/'
         IF BITAND( style, MIS_SUBMENU ) <> '0000'x THEN DO
            menuLevel = menuLevel + 2
            CALL DoMenu substr( data, col )
            menuLevel = menuLevel - 2
            col       = col + C2D( reverse( substr( data, col, 2 ) ) )
            END
         END
      IF code <> '' THEN DO
         col3 = 1
         CALL LineOut rexFile, '/*'copies( ' ', menuLevel )'- Action: */'
         DO WHILE col3 <= length( code )
            col4 = pos( '0D'X, code, col3 )
            IF col4 = 0 THEN col4 = length( code ) + 1
            line = substr( code, col3, col4 - col3 )
            CALL LineOut rexFile, copies( ' ', menuLevel + 4 ) || line
            col3 = col4 + 2
         END
         IF translate( word( line, 1 ) ) <> 'SIGNAL' THEN
            CALL LineOut rexFile, copies( ' ', menuLevel + 4 )'SIGNAL RETURN'
         END
   END
   RETURN
