� �� 0x   d   calcv  Resulte   f   g   s   p   j   i   h   t   w   m   l   k   r   y   n   o   q   x   u   ��� 0�  _DrsAideIniApp_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:31pm */

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
/* Procedure imported on:         01/06/94 at 06:31pm */

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
/* Procedure imported on:         01/06/94 at 06:31pm */

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
_DrsAideDialogInit_�/* Source file: F:\DrDialog\DrRexx\DrsAide.RXL */
/* File last modified on:         01/06/94 at 05:45pm */
/* Procedure added to library on: 01/06/94 at 05:46pm */
/* Procedure imported on:         01/06/94 at 06:31pm */

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
Init�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

PARSE ARG hwnd iniFile rest
CALL _DrsAideInit_ hwnd, iniFileValue�select
  when oper = "*" then accum = accum * number
  when oper = "/" then accum = accum / number
  when oper = "-" then accum = accum - number
  when oper = "+" then accum = accum + number
  when oper = "=" then accum = accum
  otherwise accum = number
end
call Reset
arg operResetXsign    = ""
number  = 0
divisor = 0
after   = 0
digits  = 0
call Result.Text accumAddDigit�arg digit
digits = 1
if number < 0 then sign = -1; else sign = 1
number = sign * number
if divisor = 0 then number = 10 * number + digit
else do
  after   = after + 1
  divisor = 10 * divisor
  number  = number + digit / divisor
end
number = Format( sign * number,, after )
call Result.Text number 
if oper = "=" then oper = ""�� �d 0�  �  �  ��          ��  � V u [ d ���         �� M f  v ����        �  � 9   e ����        �  � 9   f ����        �  �1 9   g ����        �  �G 9   s ����        �  �^ 9   p ����        �  � '   j ����        �  � '   i ����        �  �1 '   h ����        �  �G '   t ����        �  �^ '   w ����        �  �    m ����        �  �    l ����        �  �1    k ����        �  �G    r ����        �  �    y ����        �  �    n ����        �  �1    o ����        �  �G    q ����        �  �^   " x ����         �  � K n  u ����DrRexx Calculator    7 8 9 / C 4 5 6 * AC 1 2 3 - +/- 0 . + =  ���d 0  �d Init&CALL _DrsAideDialogInit_ hwnd, iniFileExit&CALL _DrsAideDialogExit_ hwnd, iniFile�x Clickcall Value "="�q Clickcall Value "+"�o ClickZif divisor = 0 then do
  divisor = 1
  call Result.Text number"."
  end
else call Bong�n Clickcall AddDigit 0�y Click�if digits then do
  number = -number
  call Result.Text number
  end
else do
  accum = -accum
  call Result.Text accum
end
�r Clickcall value "-"�k Clickcall AddDigit 3�l Clickcall AddDigit 2�m Clickcall AddDigit 1�w Clickaccum = 0
call Reset�t Clickcall Value "*"�h Clickcall AddDigit 6�i Clickcall AddDigit 5�j Clickcall AddDigit 4�p Click
call Reset�s Clickcall Value "/"�g Clickcall AddDigit 9�f Clickcall AddDigit 8�e Clickcall AddDigit 7�v Init accum = 0
oper = ""
call Reset�