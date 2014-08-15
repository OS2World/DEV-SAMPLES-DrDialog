/*----------------------------------------------------------------------------*/
/*                                                                            */
/* Create a resource .DLL file                                                */
/*                                                                            */
/* Written by: David C. Morrill                                               */
/*                                                                            */
/* Usage: BMPTODLL dllName [file1 ... filen]                                  */
/* (e.g.: BMPTODLL myBmps my*.BMP your*.BMP                                   */
/*                                                                            */
/* (c) Copyright IBM Corporation 1993                                         */
/*                                                                            */
/*----------------------------------------------------------------------------*/

CALL RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
Call SysLoadFuncs

/* Parse the arguments: */
PARSE ARG dllName file rest
IF (dllName = "") | (dllName = "?") THEN SIGNAL usage
IF pos( ".", dllName ) = 0 THEN dllName = dllName".DLL"
IF file = "" THEN file = "*.BMP"

/* Create a temporary .RC file: */
rcFile = SysTempFileName( ".\BMP?????.RC" );

/* Expand each 'file' into matching file names and add them to the .RC file: */
i = 0;
DO WHILE file \= ""
   IF (SysFileTree( file, "files", "FO" ) \= 0) | (files.0 = 0) THEN DO
      SAY "Could not find:" file
      EXIT 100
     END
   DO j = 1 TO files.0
      i = i + 1
      ext = translate( substr( file, pos( ".", files.j ) + 1 ) )
           IF ext = "ICO" THEN type = "ICON"
      ELSE IF ext = "PTR" THEN type = "POINTER"
      ELSE                     type = "BITMAP"
      IF LineOut( rcFile, type i files.j ) \= 0 THEN DO
         SAY ""
         SAY "Error occurred creating temporary file"
         CALL LineOut rcFile
         "@DEL" rcFile "1>NUL 2>NUL"
         EXIT 100
        END
      CALL CharOut , "."
   END
   PARSE VAR rest file rest
END
SAY ""

/* Close the .RC file: */
CALL LineOut rcFile

/* Get the root portion of the DLL file name: */
root = translate( dllName )
col  = pos( ":", root )
IF col \= 0 THEN root = substr( root, col + 1 )
DO FOREVER
   col = pos( "\", root )
   IF col = 0 THEN LEAVE
   root = substr( root, col + 1 )
END
col = pos( ".", root )
IF col \= 0 THEN root = left( root, col - 1 )
IF length( root ) > 8 THEN root = left( root, 6 )

/* Try to find the 'dummy' DLL: */
dllSource = SysSearchPath( "PATH", "BMPTODLL.DAT" )
IF dllSource = "" THEN dllSource = SysSearchPath( "DPATH", "BMPTODLL.DAT" )
IF dllSource = "" THEN DO
   SAY "Could not find BMPTODLL.DAT"
   "@DEL" rcFile "1>NUL 2>NUL"
   EXIT 100
  END

/* Copy the dummy DLL to the desired DLL and change its internal name: */
dll = CharIn( dllSource, 1, Chars( dllSource ) )
dll = left( dll, 388 ) || d2c( length( root ), 1 ) || root || copies( '00'x, 8 - length( root ) ) || substr( dll, 398 )
"@DEL" dllName "1>NUL 2>NUL"
IF CharOut( dllName, dll ) \= 0 THEN DO
   SAY "Error creating" dllName
   "@DEL" rcFile "1>NUL 2>NUL"
   EXIT 100
  END
CALL CharOut dllName

/* Compile the resources and add them to the DLL: */
"@RC" rcFile dllName "1>NUL 2>NUL"
ok = rc
"@DEL" rcFile "1>NUL 2>NUL"
col = pos( ".", rcFile, 2 )
IF col \= 0 THEN rcFile = left( rcFile, col - 1 )
"@DEL" rcFile".RES 1>NUL 2>NUL"
IF ok \= 0 THEN DO
   SAY "Could not create" dllName
   "@DEL" dllName "1>NUL 2>NUL"
   EXIT 100
  END

/* Indicate the operation was a success: */
SAY
SAY "Successfully created" dllName
EXIT

/* Show usage: */
usage:
   SAY "Usage: BMPTODLL  dllName[.DLL]  [file1 ... filen]"
   SAY "where: dllName      = name of .DLL to create"
   SAY "       file1..filen = names of .BMP/.ICO/.PTR files to include"
   SAY "                      (may contain wildcards: ? or *)"
   SAY "                      (defaults to *.BMP)"
   SAY "For example: BMPTODLL myBmps my*.BMP your*.BMP"
   SAY ""
   SAY "Notes: BMPTODLL.DAT must be in PATH or DPATH"
   SAY "       RC (Resource Compiler) must be in PATH"
   EXIT 100
