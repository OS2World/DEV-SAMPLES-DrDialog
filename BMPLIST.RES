� �� 0�   �   Lister�   p   q   �   g  Entryj  List�   o   d   Browser�  Centered�  Scaled�  
Replicated�  Bitmap�  Info��� 0J  _DrsAideIniApp_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
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
SetStyle�IF Initing = 1 THEN DO; Initing = 0; RETURN; END
PARSE ARG bit
CALL Bitmap.Style bit || '000080'X
CALL Bitmap.Hide "N"
CALL Bitmap.ShowInit�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
CALL SysLoadFuncs
NUMERIC DIGITS 12
PARSE ARG hwnd iniFile rest
CALL _DrsAideInit_ hwnd, iniFile, 'Browser'MakeList�path = Entry.Text()
IF right( path, 1 ) <> '\' THEN path = path'\'
IF SysFileTree( path'*.'ext, 'FILES', 'FO' ) <> 0 THEN DO
   CALL Beep 440, 50
   SIGNAL RETURN
END
CALL List.Hide "N"
CALL List.Delete
len = LENGTH( path ) + 1
DO i = 1 TO files.0
   col = POS( '.', files.i )
   CALL List.Add SUBSTR( files.i, len, col - len ), "A"
END
CALL List.Show�� �� 0    �  ��          �  � " r z � ��+    
 /
 :  � g   � ����        E �$ h # 	 p ����        J �I h # 	 q ����    
 O
 Z  � T   � ����        e � X P 	 g ����         s �  m Q j ����        t  ' A   	 � ����        y  � f P  o ����DrRexx Browser   ICONBUTTON BITMAP:#60 .BMP .GIF ICONBUTTON BITMAP:#33 C:\OS2\BITMAP  Push Type: ���� 0J  �� Init�imageFile   = ''
ext         = 'BMP'
nextBrowser = 2
IF left( hwnd, 2 ) <> '-H' THEN DO
   path = hwnd
   IF path <> "" THEN CALL entry.Text path
   END
CALL MakeList�� ClickCALL MakeList�j Select�CALL Time 'R'
imageFile = path || Item( Select() ) || '.' || ext
CALL Browser.Bitmap.Text imageFile
took = Time( 'E' )
took = left( took, length( took ) - 4 )
CALL SysFileTree imageFile, 'FILES', 'F'
CALL Browser.Text 'File:' imageFile
CALL Browser.Info.Text 'Size:' word( files.1, 3 ) ' Took:' took 'sec  Date:' word( files.1, 1 ) ' Time:' word( files.1, 2 )
IF left( hwnd, 2 ) = '-H' THEN DO
   id    = DrDialog( 'Control' )
   class = DrDialog( 'Class', id )
   IF (class = 'BILLBOARD') | (class = 'ICONBUTTON') THEN
      CALL DrDialog 'Text', id, imageFile
   END
�� ClickCALL MakeList�q Clickext = 'GIF'
CALL MakeList�p Clickext = 'BMP'
CALL MakeListInitCALL Select 1�� Click�IF imageFile = '' THEN DO; CALL Beep 1760, 50; SIGNAL RETURN; END
PARSE VALUE Browser.Position() WITH x y cx cy
newBrowser  = 'Browser'nextbrowser
nextbrowser = nextbrowser + 1
CALL Browser.Open newBrowser, 'Copy:' imageFile
IF left( hwnd, 2 ) = '-H' THEN CALL DrDialog 'Owner', newBrowser
me = translate( newBrowser )
PARSE VALUE PositionFor( newBrowser ) WITH x y cx.me cy.me
CALL PositionFor newBrowser,, x+16, y+16, cx, cy
style = Browser.Bitmap.Style()
CALL StyleFor newBrowser, Bitmap, style
digit = left( style, 1 )
SELECT
  WHEN digit = '00'X THEN CALL SelectFor newBrowser, Centered,   1
  WHEN digit = '01'X THEN CALL SelectFor newBrowser, Scaled,     1
  WHEN digit = '02'X THEN CALL SelectFor newBrowser, Replicated, 1
  OTHERWISE SAY digit
END
CALL TextFor newBrowser, Bitmap, imageFile
CALL TextFor newBrowser,, 'Copy:' imageFile
CALL TextFor newBrowser, Info, Browser.Info.Text()
CALL ShowFor newBrowser�� �d 0    �  ��          �   . 
 � d ���         �  �  2 	 � ����        �  �6  ( 	 � ����       
 �  �`  ; 	 � ����    	 �  �  ��  � � ����     �   0 � 
 
 � ����DrRexx Browser #  Centered Scaled Replicated BILLBOARD #119 CANVAS  ���d 0�  �d ExitZIF Dialog() = 'BROWSER' THEN DO
   CALL _DrsAideDialogExit_ hwnd,iniFile
   EXIT
   ENDSize�me = Dialog()
PARSE VALUE Position() WITH nx ny ncx ncy
PARSE VALUE Bitmap.Position() WITH bx by bcx bcy
CALL Bitmap.Position bx, by, bcx + ncx - cx.me, bcy + ncy - cy.me
PARSE VALUE Info.Position() WITH bx by bcx bcy
CALL Info.Position bx, by, bcx + ncx - cx.me, bcy
cx.me = ncx
cy.me = ncyInit�me = Dialog()
IF me = 'BROWSER' THEN DO
   PARSE VALUE Position() WITH x y cx.me cy.me
   CALL Lister.Open
   CALL Lister.Position x + cx.me, y
   CALL _DrsAideDialogInit_ hwnd, iniFile
   CALL Lister.Show
END
Initing = 1�� ClickCALL SetStyle '02'X�� ClickCALL SetStyle '01'X�� ClickCALL SetStyle '00'X�