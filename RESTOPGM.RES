� �� 0   d    f  msge   ��� 0�   Init�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
CALL SysLoadFuncs�� �d 0      �  ��          h �  � x � # d ��w          { @�  �  f ����        |  �Y  ( 
 e ����REStoPgm Error     OK ���d 0S  �d Init�PARSE ARG resFile
IF translate( right( resFile, 4 ) ) \= ".RES" THEN CALL msg.Text "Drag and drop a DrRexx .RES file onto my icon"
ELSE DO
  col  = lastpos( "\", resFile )
  name = substr( resFile, col + 1, length( resFile ) - 4 - col )
  exe  = word( DrRexxVersion(), 3 )
  col  = lastpos( "\", exe )
  path = left( exe, col - 1 )
  rc   = SysCreateObject( "WPProgram", name, "<WP_DESKTOP>", "PROGTYPE=PM;EXENAME="exe";STARTUPDIR="path";PARAMETERS="resFile "%*", "R"  )
  IF \rc THEN CALL msg.Text "Could not create program object"
  ELSE EXIT
END
CALL Show�e ClickEXIT�