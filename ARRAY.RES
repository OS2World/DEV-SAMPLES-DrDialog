� �� 0q   d   arrayi   k   h  rowsj  colse  creates  deletet  donep   n   q  cyo  cxr  spacel   m   ��� 0  _DrsAideIniApp_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:33pm */

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
/* Procedure imported on:         01/06/94 at 06:33pm */

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
/* Procedure imported on:         01/06/94 at 06:33pm */

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
/* Procedure imported on:         01/06/94 at 06:33pm */

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
IF _DrsAideInit_( hwnd, iniFile ) = 0 THEN
   SAY 'This program can only be run from DrDialog'�� �d 0>  >  �  ��          ��  � V ~ Z d ���        �� F ) 
 i ����        � � : ) 
 k ����          � �0 F   h ����          � �0 9   j ����        �  �O F (  e ����        �  �O 9 (  s ����          �O , (  t ����        
�  ) 
 p ����         �  ) 
 n ����           �0    q ����           �0    o ����          �P  (  r ����        !  � ( y 1 l ����        5  �  y & m ����Array of controls   Rows: Columns:   Create Delete Done Rows: Columns:   Space Number of elements: Spacing: ���d 0�  �d Exit&CALL _DrsAideDialogExit_ hwnd, iniFileInitbCALL delete.Disable
CALL done.Disable
CALL space.Disable
CALL _DrsAideDialogInit_ hwnd, iniFile�r Click�PARSE VALUE DrDialog( 'Pos', baseId ) WITH x y dx dy
cx = cx.Select()
cy = cy.Select()
i   = 1
DO r = 1 TO rows
    xc = x
    DO c = 1 TO cols
        id = word( ids, i )
        i  = i + 1
        CALL DrDialog 'Pos', id, xc, y
        xc = xc + dx + cx 
    END
    y = y - dy - cy
END�o InitCALL Range 0, 30�q InitCALL Range 0, 30�t ClickNCALL create.Enable
CALL delete.Disable
CALL done.Disable
CALL space.Disable�s Click�DO i = 2 TO words( ids )
    CALL DrDialog 'DropControl', word( ids, i )
END
CALL create.Enable
CALL delete.Disable
CALL done.Disable
CALL space.Disable
�e Click�baseId = DrDialog( 'Control' )
IF baseId = '' THEN DO
   CALL Beep 440, 50
   SIGNAL RETURN
   END
type = DrDialog( 'Class', baseId )
IF type = 'DIALOG' THEN DO
   CALL Beep 440, 50
   SIGNAL RETURN
   END
PARSE VALUE DrDialog( 'Pos', baseId ) WITH x y dx dy
rows   = rows.Select()
cols    = cols.Select()
cx      = cx.Select()
cy      = cy.Select()
nextId = baseId
ids      = baseId
DO r = 1 TO rows
    xc = x
    DO c = 1 TO cols
        IF (r <> 1) | (c <> 1) THEN DO
           nextId = nextId + 1
           id = DrDialog( 'NewControl', baseId, nextId )
           CALL DrDialog 'Pos', id, xc, y
           ids = ids id
           END
        xc = xc + dx + cx 
    END
    y = y - dy - cy
END
CALL DrDialog 'Select', ids
CALL create.Disable
CALL delete.Enable
CALL done.Enable
CALL space.Enable�j InitCALL Range 1, 20�h InitCALL Range 1, 20����d 0�  
d Array tool'r Space the controls in the current array9o Select the number of pels between each column of controls6q Select the number of pels between each row of controls)t Prepare to create a new array of controls=s Delete all but the top-left hand control in the current arraye Create an array of controls,j Select the desired number of control columns)h Select the desired number of control rows�