� �� 0   d   framee  time��� 0  _DrsAideIniApp_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:32pm */

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
_DrsAideInit_�
/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:32pm */

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
_DrsAideDialogInit_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:32pm */

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
_DrsAideDialogExit_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:32pm */

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
Init�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

PARSE ARG hwnd iniFile rest
CALL _DrsAideInit_ hwnd, iniFile	SetFormat�format   = arg(1)
trailing = arg(2)
interval = arg(3)
CALL frame.Timer interval
IF arg() = 3 THEN DO
   CALL Mode.MenuChecked 0
   CALL MenuChecked 1
END
CALL ShowTimeShowTimenCALL time.Hide "N"
now = Time( format )
CALL time.Text left( now, length( now ) - trailing )
CALL time.Show�� �d 0d   d   �  ��          J   � b � 1 d ��W      [   c #��  � " e ����DrRexx Clock   MARQUEE  � �d 0J   J   �      Format 3   �      Civil     Military     Elapsed ���d 0k    ModeCALL SetFormat "C", 0, 60000 ModeCALL SetFormat "N", 3, 60000 ModeCALL SetFormat "E", 4, 1000���d 0�   �d TimerCALL ShowTimeExit&CALL _DrsAideDialogExit_ hwnd, iniFileInit5CALL Time "R"
CALL _DrsAideDialogInit_ hwnd, iniFile�e Init.CALL SetFormat "C", 0, 60000, 1
CALL ShowTime����d 0   d DrRexx clocke Current time�