� �� 0(   d   errore  msgf   �   log�  list��� 0w   Initp/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

SIGNAL DoArgs�� �d 0      �  ��          h �  � b � & d ��w          { @�  �  e ����        |  �?  (  f ����RexxUse: Error    OK ���d 0   �f ClickEXIT�� �� 0a   a   �  ��          J �  �� k � E � ��\          `  �   � D � ����RexxUse: Warnings    ���� 0   �� ExitEXIT
���� 0�  /* DrsAide REXX librarian: Procedure importer */
/* Written by: David C. Morrill               */
/* Date: 12/18/93                             */

DoArgs:
   PARSE ARG hwnd rest
   IF left( hwnd, 2 ) <> '-H' THEN DO
      CALL Error 'REXXUse is only for use with DrDialog'
      SIGNAL RETURN
      END
   CALL DrDialog 'Init', hwnd
   logging = 0

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

   resData    = DrDialog( 'GetRES' )
   column     = 1
   needProcs  = ''
   validChars = xrange( 'A', 'Z' ) || xrange( 'a', 'z' ) ||,
                xrange( '0', '9' ) || '?'
   xlateTab   = ';' || '0D0A'X
   date       = right( date( 'U' ), 8, '0' )
   time       = right( time( 'C' ), 7, '0' )
   DO FOREVER
      IF column > length( resData ) THEN LEAVE
      IF substr( resData, column, 1 ) <> 'FF'X THEN DO
         CALL Error 'Invalid .RES file format'
         SIGNAL RETURN
         END
      type   = C2D( reverse( substr( resData, column + 1, 2 ) ) )
      len    = C2D( reverse( substr( resData, column + 8, 4 ) ) )
      data   = substr( resData, column + 12, len )
      column = column + len + 12
      CALL DoResource type, data
   END
   CALL DoGlobals
   CALL Beep 440, 50
   IF \logging THEN EXIT
   SIGNAL RETURN

DoResource:
   SELECT
     WHEN arg(1) = 56322 THEN /* External code */
        CALL FindProcs arg(2)
     WHEN arg(1) = 56323 THEN /* Dialog menu code */
        CALL DoMenu arg(2)
     WHEN (arg(1) = 56324) | (arg(1) = 56325) THEN /* Dialog event/class code */
        CALL DoEvent arg(2)
     OTHERWISE /* ignore it */
   END
   RETURN

DoMenu:
   data = arg(1)
   i    = 1
   DO WHILE i <= length( data )
      mcol = i + 3 + C2D( substr( data, i + 2, 1 ) )
      len  = C2D( substr( data, mcol, 1 ) )
      IF len > 127 THEN DO
         mcol = mcol + 1
         len = (len - 128) + 128 * C2D( substr( data, mcol, 1 ) )
         END
      CALL FindProcs substr( data, mcol + 1, len )
      i = mcol + len + 1
   END
   RETURN

DoEvent:
   data = arg(1)
   i    = 1
   DO FOREVER
      curLen = C2D( substr( data, i, 1 ) )
      IF curLen = 255 THEN LEAVE
      IF curLen = 128 THEN DO
         i      = i + 3
         curLen = C2D( substr( data, i, 1 ) )
         END
      i      = i + curLen + 1
      curLen = C2D( substr( data, i, 1 ) )
      IF curLen > 127 THEN DO
         i      = i + 1
         curLen = (curLen - 128) + 128 * C2D( substr( data, i, 1 ) )
         END
      CALL FindProcs substr( data, i + 1, curLen )
      i = i + curLen + 1
   END
   RETURN

FindProcs:
   code = arg(1)
   c    = 1
   DO WHILE c <= length( code )
      col = pos( '_', code, c )
      IF col = 0 THEN LEAVE
      col2 = pos( '_', code, col + 1 )
      IF col2 = 0 THEN LEAVE
      c = col2
      IF col + 1 < col2 THEN DO
         IF verify( substr(code, col + 1, col2 - col - 1), validChars ) = 0 THEN DO
            IF col2 < length( code ) THEN next = substr( code, col2 + 1, 1 )
            ELSE next = ' '
            IF next = '0D'x THEN next = ' '
            IF (next = ' ') | (next = '(') THEN DO
               IF col > 1 THEN prev = substr( code, col - 1, 1 )
               ELSE prev = ' '
               IF verify( prev, validChars ) = 1 THEN DO
                  curProc = substr( code, col, col2 - col + 1 )
                  IF next = '(' THEN DO
                     CALL AddProc curProc
                     c = col2 + 1
                     END
                  ELSE IF col >= 6 THEN DO
                     IF col < 22 THEN len = col - 2
                     ELSE len = 20
                     IF translate( word( reverse( translate( substr( code,,
                                   col - len - 1, len ), '   ', xlateTab ) ),,
                                   1 ) ) = 'LLAC' THEN DO
                        CALL AddProc curProc
                        c = col2 + 1
                        END
                     END
                  END
               END
            END
         END
   END
   RETURN

AddProc:
   IF pos( ' 'arg(1)' ', needProcs' ' ) = 0 THEN needProcs = needProcs arg(1)
   RETURN

DoGlobals:
   globals     = DrDialog( 'Globals' )
   globalProcs = ''
   DO j = 1 TO words( globals )
      globalProc = word( globals, j )
      IF (length( globalProc ) >= 3)   &,
         (left( globalProc, 1 ) = '_') &,
         (right( globalProc, 1 ) = '_') THEN globalProcs = globalProcs globalProc
      ELSE CALL FindProcs DrDialog( 'Global', globalProc )
   END
   j     = 1
   words = words( needProcs )
   DO FOREVER
      IF j > words THEN LEAVE
      globalProc = word( needProcs, j )
      curDef     = SysIni( iniFile, 'RexxProc', globalProc )
      IF curDef = 'ERROR:' THEN CALL Log "'"globalProc"': No definition found"
      ELSE DO
         col    = pos( '0D'X, curDef )
         header = left( curDef, col - 1 )
         curDef = substr( curDef, col + 2 )
         CALL FindProcs curDef
         CALL DrDialog 'Global', globalProc,,
              '/* Source file:' word( header, 1 ) '*/' || '0D0A'x ||,
              '/* File last modified on:        ' word( header, 2 ) 'at' word( header, 3 ) '*/' || '0D0A'x ||,
              '/* Procedure added to library on:' word( header, 4 ) 'at' word( header, 5 ) '*/' || '0D0A'x ||,
              '/* Procedure imported on:        ' date 'at' time '*/' || '0D0A0D0A'x ||,
              curDef
         END
      j = j + 1
   END
   needProcs = needProcs' '
   DO j = 1 TO words( globalProcs )
      globalProc = word( globalProcs, j )
      IF pos( ' 'globalProc' ', needProcs ) = 0 THEN
         CALL DrDialog 'Global', globalProc, ''
   END
   RETURN

Log:
   IF \logging THEN DO
      logging = 1
      CALL log.Open
      CALL DrDialog 'Owner', 'log'
      END
   CALL log.list.Select log.list.Add( arg(1) ), 'Top'
   RETURN

Error:
   CALL error.Open
   CALL msg.Text arg(1)
   CALL error.Show
   IF left( hwnd, 2 ) = '-H' THEN CALL DrDialog 'Owner', 'error'
   RETURN
