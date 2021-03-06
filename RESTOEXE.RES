� �� 0   d    f  msge   ��� 0�   Init�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
CALL SysLoadFuncs�� �d 0      �  ��          h �  � v � " d ��w          { @�  �  f ����        |  �Z  ( 
 e ����REStoEXE Error     OK ���d 0.   �d InitSIGNAL ConvertREStoEXE�e ClickEXIT���� 0�  /*----------------------------------------------------------------------------*/
/*                                                                            */
/* Convert a DrRexx .RES file into an executable .EXE file                    */
/*                                                                            */
/* Written by: David C. Morrill                                               */
/*                                                                            */
/*----------------------------------------------------------------------------*/

ConvertREStoEXE:
   PARSE ARG resFile
   IF lastpos( ".", resFile ) = 0 THEN resFile = resFile".RES"
   IF (SysFileTree( resFile, "resFiles", "FO" ) <> 0) | (resFiles.0 <> 1) THEN
      CALL msg.Text "Please specify a DrRexx .RES file"
   ELSE DO
     resFile = resFiles.1
     error   = Convert( resFile )
     IF error = "" THEN DO
        col = lastpos( "\", resFile )
        IF col = 0 THEN col = lastPos( ":", resFile )
        path = left( resFile, col )
        name = substr( resFile, col + 1, length( resFile ) - 4 - col )
        rc   = SysCreateObject( "WPProgram", name, "<WP_DESKTOP>", "PROGTYPE=PM;EXENAME="path||name".EXE;STARTUPDIR="path";PARAMETERS=%*", "R" )
        IF \rc THEN CALL msg.Text "Could not create program object"
        ELSE EXIT
       END
     ELSE CALL msg.Text error
   END
   CALL Show
   SIGNAL RETURN

Convert: PROCEDURE
   resName = arg(1)
   col     = lastpos( ".", resName )
   exeName = left( resName, col )"EXE"
   icoName = left( resName, col )"ICO"
   delName = ""

   /* Create a temporary .RES file: */
   resFile = SysTempFileName( ".\RES?????.RES" );

   /* Try to find DrRexx.EXE: */
   PARSE SOURCE os2 kind cmdName
   col       = lastpos( "RESTOEXE.", translate( cmdName ) )
   cmdPath   = left( cmdName, col - 1 )
   DrRexxEXE = SysSearchPath( "PATH", "DRREXX.EXE" )
   IF DrRexxEXE = "" THEN DrRexxEXE = cmdPath"DrRexx.EXE"

   /* Try to find DrRexx.DAT: */
   DrRexxDAT = SysSearchPath( "PATH", "DRREXX.DAT" )
   IF DrRexxDAT = "" THEN DrRexxDAT = SysSearchPath( "DPATH", "DRREXX.DAT" )
   IF DrRexxDAT = "" THEN DrRexxDAT = cmdPath"DrRexx.DAT"
   DrRexxRes    = CharIn( DrRexxDAT, 1, Chars( DrRexxDAT ) )
   IF DrRexxRes = "" THEN DO
      msg = "Could not find DrRexx.DAT"
      SIGNAL Error
     END

   /* Copy DrRexx.EXE to the desired file name: */
   "@COPY" DrRexxEXE exeName "1>NUL 2>NUL"
   IF rc <> 0 THEN DO
      msg = "Error copying DrRexx.EXE to:" exeName
      SIGNAL Error
     END

   delname = exeName
   res     = CharIn( resName, 1, Chars( resName ) )
   IF res = "" THEN DO
      msg = Error "Could not read:" resName
      SIGNAL Error
     END

   len = reverse( d2c( length( res ), 4 ) )
   IF CharOut( resFile, "FF0900FF01003010"X||len||res||DrRexxRes ) <> 0 THEN DO
      msg = Error "Error creating temporary file"
      SIGNAL Error
     END
   CALL CharOut resFile

   /* Add the resource to the EXE: */
   "@RC" resFile exeName "1>NUL 2>NUL"
   IF rc <> 0 THEN DO
      msg = Error "Error adding resources to:" exeName
      SIGNAL Error
     END
   "@DEL" resFile "1>NUL 2>NUL"

   /* Try to add the icon (.ICO) to the .EXE: */
   CALL SysSetIcon exeName, icoFile

   /* Indicate the operation was a success: */
   RETURN ""

/* Process an error condition: */
Error:
   IF delname <> "" THEN "@DEL" delName "1>NUL 2>NUL"
   "@DEL" resFile "1>NUL 2>NUL"
   RETURN msg
