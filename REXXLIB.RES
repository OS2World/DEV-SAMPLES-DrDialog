� �� 0�   d   rexxlibf  addg  updatei  deletek  cante   h   j   l   �   error�  msg�   ,  rexxlist. procs1	 def2  3 filedate4 
importdate-  /  0 filename��� 0�  _DrsAideIniApp_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:34pm */

PROCEDURE
/* Usage is: iniApp = _DrsAideIniApp_() */
/* Returns .INI file application key of the form: file:dialog */
   PARSE SOURCE . . iniApp
   col = lastpos( '\', iniApp )
   IF col = 0 THEN col = lastpos( ':', iniApp )
   iniApp = translate( substr( iniApp, col + 1 ) )
   col    = lastpos( '.', iniApp )
   IF col <> 0 THEN iniApp = left( iniApp, col - 1 )
   RETURN iniApp':'Dialog()
_DrsAideDialogInit_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:34pm */

PROCEDURE EXPOSE x. y. dx. dy.
/* Usage is: CALL _DrsAideDialogInit hwnd, iniFile */
PARSE ARG hwnd, iniFile
IF left( hwnd, 2 ) = '-H' THEN DO
   dialog = Dialog()
   CALL DrDialog 'Owner', dialog
   PARSE VALUE SysIni( iniFile, _DrsAideIniApp_(), 'Pos' ) WITH x.dialog y.dialog dx.dialog dy.dialog
   IF x.dialog <> 'ERROR:' THEN CALL Position x.dialog y.dialog dx.dialog dy.dialog
   END
CALL Show
_DrsAideInit_�
/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:34pm */

PROCEDURE
/* Usage: rc = _DrsAideInit( hwnd, iniFile [, dialog] [, bitmap] ) */
IF RxFuncQuery( 'SysLoadFuncs' ) THEN DO
   CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
   CALL SysLoadFuncs
   END
PARSE ARG hwnd, iniFile, dialog, bitmap
IF hwnd = '-I' THEN DO
   IF bitmap <> '' THEN DO
      apps = SysIni( iniFile, 'DrsAide', 'Apps' )
      IF apps = 'ERROR:' THEN apps = ''
      PARSE SOURCE . . resFile
      col = pos( ' 'resFile'(', apps )
      IF col <> 0 THEN DO
         col2 = pos( ')', apps, col + length( resFile ) + 2 )
         apps = left( apps, col - 1 ) || substr( apps, col2 + 1 )
         END
      CALL SysIni iniFile, 'DrsAide', 'Apps', apps,
           translate( resFile, '01'X, ' ' )'('translate( bitmap, '01'X, ' ' )')'
      CALL RxMessageBox resFile 'added to DrsAide', 'DrsAide', 'OK', 'NONE'
      END
   ELSE CALL RxMessageBox resFile 'has no bitmap', 'DrsAide', 'CANCEL', 'NONE'
   EXIT
   END
IF left( hwnd, 2 ) <> '-H' THEN RETURN 0
CALL DrDialog 'Init', hwnd
IF dialog = '' THEN DO
   CALL Dialogs
   dialog = dialogs.1
   DROP dialogs
   END
CALL OpenFor dialog
RETURN 1
_DrsAideDialogExit_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:34pm */

PROCEDURE EXPOSE x. y. dx. dy.
/* Usage in: CALL _DrsAideDialogExit_ hwnd, iniFile */
PARSE ARG hwnd, iniFile
IF left( hwnd, 2 ) = '-H' THEN DO
   PARSE VALUE Position() WITH newX newY newDX newDY
   dialog = Dialog()
   IF (newx  <> x.dialog)  | (newY  <> y.dialog) |,
      (newDX <> dx.dialog) | (newDY <> dy.dialog) THEN
      CALL SysIni iniFile, _DrsAideIniApp_(), 'Pos', newX newY newDX newDY
   END
Initp/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

SIGNAL DoInit�� �d 0�  �  �  ��          �  z ( � d ��$         ( � < Q < f ����         ) �Y < Q < g ����         * �� < Q < i ����         + �  � , k ����     , 3  � ; S G e ����     : A  �X ; S G h ����     J Q  �� ; S G j ����     Z6 a  �  � 7 l ����REXXLib       CANVAS Added: CANVAS Updated: CANVAS Deleted: CANVAS Couldn't add because: (Double-click entry to override) ���d 0�   �d Exit}PARSE VALUE Position() WITH newx newy . .
IF (newx <> x) | (newy <> y) THEN CALL SysIni iniFile, 'REXXLIB', 'Pos', newx newyInitSIGNAL DoArgs�k EnterSIGNAL Override�� �� 0~   ~   �  ��          h �  � x � ( � ��v          z @�  �  � ����        {  �P  (  � ����REXXLib error    OK ���� 0   �� ClickEXIT�� �,0�  �  �  ��            � 0 � ,��6         : � 0 L H .����      
   ; �R 0 � H 1����        <  �Q % � 
 2����         N�  � 
 3O��         s �  � 
 4t��     �
 �  � / N T -����     � �  �Q / � T /����     �  �  �  " 0����RexxLib: Procedure Viewer     Copy to clipboard            10.System Monospaced               10.System Monospaced    CANVAS Procedure: CANVAS Definition: CANVAS  ���,0�   �,Exit*CALL _DrsAideDialogExit_ hwnd, aideIniFileInitSIGNAL ListProcs�2ClickCALL ClipBoard def.Text()�.SelectSIGNAL ShowDef����,0�  ,RexxLib Procedure ViewerC0Name of the source file that defined the current selected procedureM4Date the file used to define the current selected procedure was last importedL3Date the file used to define the current selected procedure was last updated,2Copy the current definition to the clipboard,1Definition of the current selected procedure+.Names of the procedures in the REXX library���� 0�  /* DrsAide REXX procedure librarian */
/* Written by: David C. Morrill     */
/* Date: 12/17/93                   */

DoInit:
   CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
   CALL SysLoadFuncs

   iniFile = SysIni( 'SYSTEM', 'DRDIALOG', 'INIPATH' )
   IF iniFile <> 'ERROR:' THEN DO
      col = pos( '00'x, iniFile )
      IF col <> 0 THEN iniFile = left( iniFile, col - 1 )
      IF right( iniFile, 1 ) <> '\' THEN iniFile = iniFile'\'
      END
   ELSE DO
      PARSE SOURCE . . myName
      col     = lastpos( '\', myName )
      iniFile = left( myName, col )
      END
   iniFile = iniFile'RexxLib.INI'
   PARSE ARG hwnd aideIniFile rest
   IF _DrsAideInit_( hwnd, aideIniFile, 'rexxList' ) = 0 THEN
      IF hwnd = '' THEN CALL Error 'Usage is: RexxLib rexxFile'
   SIGNAL RETURN

DoArgs:
   CALL time 'R'
   rexFile = hwnd
   CALL SysFileTree rexFile, 'FILES', 'F'
   IF files.0 <> 1 THEN DO
      CALL Error 'Could not find:' rexFile
      SIGNAL RETURN
      END
   date1    = right( word( files.1, 1 ), 8, '0' )
   time1    = right( word( files.1, 2 )'m', 7, '0' )
   date2    = right( date( 'U' ), 8, '0' )
   time2    = right( time( 'C' ), 7, '0' )
   oldProcs = ' 'SysIni( iniFile, 'RexxFile', rexFile )' '
   IF oldProcs = ' ERROR: ' THEN oldProcs = ''
   newProcs  = ''
   cantProcs = ''
   curProc   = ''
   CALL Text 'RexxLib:' rexFile '(Processing...)'
   PARSE VALUE SysIni( iniFile, 'RexxLib', 'Pos' ) WITH x y
   IF x <> 'ERROR:' THEN CALL Position x, y
   CALL Show
   DO WHILE Lines( rexFile )
      line    = LineIn( rexFile )
      newProc = GetProcName()
      IF newProc = '' THEN DO
         IF curProc <> '' THEN curProcDef = curProcDef || line || '0D0A'x
         END
      ELSE DO
         CALL AddProc
         line = strip( substr( line, pos( ':', line ) + 1 ) )
         IF line <> '' THEN line = line || '0D0A'x
         curProc    = newProc
         curProcDef = rexFile date1 time1 date2 time2 '0D0A'x || line
         END
   END
   CALL AddProc
   DO i = 1 TO words( oldProcs )
      oldProc = word( oldProcs, i )
      CALL SysIni iniFile, 'RexxProc', oldProc, 'DELETE:'
      CALL delete.Add oldProc
   END
   IF words( newProcs ) = 0 THEN DO
      IF SysIni( iniFile, 'RexxFile', rexFile ) <> 'ERROR:' THEN
         CALL SysIni iniFile, 'RexxFile', rexFile, 'DELETE:'
      END
   ELSE CALL SysIni iniFile, 'RexxFile', rexFile, newProcs
   took = time( 'E' );
   CALL Text 'RexxLib:' rexFile '(Completed:' left( took, length( took ) - 4 ) 'sec)'
   CALL Beep 440, 50
   SIGNAL RETURN

GetProcName:
   IF left( line, 1 ) <> '_' THEN RETURN ''
   col = pos( '_:', line )
   IF col < 2 THEN RETURN ''
   col2 =  pos( ' ', line )
   IF (col2 <> 0) & (col2 < col) THEN RETURN ''
   RETURN left( line, col )

AddProc:
   DO WHILE right( curProcDef, 4 ) = '0D0A0D0A'X
      curProcDef = left( curProcDef, length( curProcDef ) - 2 )
   END
   IF curProc = '' THEN RETURN
   checkProc = ' 'curProc' '
   IF pos( checkProc, ' 'newProcs' 'cantProcs' ' ) <> 0 THEN DO
      CALL cant.Add curProc 'is defined more than once'
      RETURN
      END
   oldProcDef = SysIni( iniFile, 'RexxProc', curProc )
   col        = pos( checkProc, oldProcs )
   IF col <> 0 THEN DO
      oldProcs = left( oldProcs, col ) ||,
                 substr( oldProcs, col + length( curProc ) + 2 )
      CALL update.Add curProc
      col  = pos( '0D'x, oldProcDef )
      col2 = pos( '0D'x, curProcDef )
      IF substr( oldProcDef, col ) = substr( curProcDef, col2 ) THEN DO
         newProcs = newProcs curProc
         RETURN
         END
      END
   ELSE DO
      IF oldProcDef = 'ERROR:' THEN CALL add.Add curProc
      ELSE DO
         oldFile = word( oldProcDef, 1 )
         CALL cant.Add curProc "is defined by '"oldFile"'", 'Last',,
                       curProc oldFile
         cant.curProc = curProcDef
         cantProcs    = cantProcs curProc
         RETURN
         END
      END
   CALL SysIni iniFile, 'RexxProc', curProc, curProcDef
   newProcs = newProcs curProc
   RETURN

Override:
   item    = Select()
   curProc = Item( item, 'Data' )
   IF curProc = '' THEN CALL Beep 440, 50
   ELSE DO
      CALL Delete item
      oldFile = word( curProc, 2 )
      curProc = word( curProc, 1 )
      CALL add.Add curProc
      CALL SysIni iniFile, 'RexxProc', curProc, cant.curProc
      newProcs = newProcs curProc
      CALL SysIni iniFile, 'RexxFile', rexFile, newProcs
      temp = ' 'SysIni( iniFile, 'RexxFile', oldFile )' '
      col  = pos( ' 'curProc' ', temp )
      CALL SysIni iniFile, 'RexxFile', oldFile,,
           strip( left( temp, col ) || substr( temp, col + length(curProc) + 2 ) )
      END
   SIGNAL RETURN

ListProcs:
   CALL SysIni iniFile, 'RexxProc', 'ALL:', 'PROC'
   DO i = 1 TO proc.0
      CALL procs.Add proc.i
   END
   CALL _DrsAideDialogInit_ hwnd, aideIniFile
   SIGNAL RETURN

ShowDef:
   curProc    = Item( Select() )
   curProcDef = SysIni( iniFile, 'RexxProc', curProc )
   CALL filename.Text 'Source file:' word( curProcDef, 1 )
   CALL filedate.Text 'File last modified on:        ' word( curProcDef, 2 ),
                      'at' word( curProcDef, 3 )
   CALL importdate.Text 'Procedure added to library on:' word( curProcDef, 4 ),
                      'at' word( curProcDef, 5 )
   CALL def.Text substr( curProcDef, pos( '0D'X, curProcDef ) + 2 )
   SIGNAL RETURN

Error:
   CALL error.Open
   CALL error.msg.Text arg(1)
   CALL error.Show
   RETURN
