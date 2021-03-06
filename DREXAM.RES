� �� 0K   d   drg   h  TEo   p  rmk   l  LRi  Installj  Cancelm  Info� �d 0�  �  �  ��    	      :  �� < x d ��I        M� a ` 
 g ����        e �r a � 
 h ��z        � � L d 
 o ����        � �r L � 
 p ���        � � 6 ` 
 k ����        � �r 6 � 
 l ����        �  �A  :  i ����        �  ��  :  j ����         �A �   m ����DrExam Install    Installation Directory: C:\DrDialog\Examples  2     Where is DrExam.Ram? C:\DrDialog\DrExam.Ram  2     Loadram2 File Specs: C:\OS2\Apps\Loadram2.exe Install Cancel  ���d 0�  �d Init�Timelmt = 10
call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs
Call Dr.Install.Disable
parse source a b c
/* Dr_Drive = Start up drive */
/* Dr_Path = Start up path */
Dr_Drive = FileSpec( 'D', c )
Dr_Path = FileSpec( 'P', c )

/* DrDialog must first be installed.  Is it? */

rc  = SysCreateObject( "WPFolder", "DrDialog", "<WP_DESKTOP>", "OBJECTID=<DRDIALOG>;", "F" )
if( rc = 1 || Start_drive = "" ) then do  /* DrDialog NOT installed */
  Call Info.Text "You must First install DrDialog!"
  Call SysSleep Timelmt
  exit;
end

Call te.text Dr_Drive || '\DrDialog\Examples'
Call rm.text Dr_Drive || '\DrDialog\DrExam.Ram'

/* The Dr is installed.  Can I find Loadram2 quick? */
Loadram = SysSearchPath( "PATH", "Loadram2.exe" );
if( Loadram = "" ) then 
  Loadram = SysSearchPath( "DPATH", "Loadram2.exe" );
if( Loadram = "" ) then
  Call Info.Text "Please Enter Correct Drive:\Path\Loadram2.exe"
else
  Call LR.Text Loadram
Call Install.Enable
Call Install.Focus
�j Clickexit;�i Click�Install_Drive = Filespec( 'D', dr.te.text() )
Install_Path = Filespec( 'P', dr.te.text() )
Final_Path = Filespec( 'N', dr.te.text() )
Install_Path = Install_Path || Final_Path
DrExamRam = dr.rm.text()
loadram = dr.lr.text()
Make_Path = Space( Install_Drive || Install_Path, 0 )
If ( LastPos( '\', Make_Path ) = Length( Make_Path ) ) then
  Make_Path = Substr( Make_Path, ( Length( Make_Path ) - 1 ) )

/* Okay, let's see if Loadram2 is actually where it should be */

if( stream( loadram, 'c', 'query exists' ) = "" ) then do
  Call info.text "Can't find Loadram2 - Let's try this."
  loadram = FilePrompt( "Loadram2.exe", "Find this file!" )
  if ( loadram = "" ) then do
    Call info.text "Please install Loadram2"
    Call SysSleep Timelmt
    exit;
  end;
end;
if( pos( "LOADRAM2", Translate( loadram ) ) = 0 ) then do
    Call info.text "Please install Loadram2"
    Call SysSleep Timelmt
    exit;
  end;

Call dr.lr.text loadram



/* Okay, let's see if DrExam.Ram is actually where it should be */

if( stream( DrExamRam, 'c', 'query exists' ) = "" ) then do
  Call info.text "Can't find DrExam.ram.  Put it in" DrExamRam"."
  Call SysSleep Timelmt
  exit
end;

/* So let's see if the exam install path exists */
DrExam = 0;
call SysFileTree Install_Drive, 'File', 'SD' 
do i = 1 to file.0
  if( pos( Translate( Make_Path ), Translate( file.i ) ) > 0 ) then do
    DrExam = 1;
    leave;
  end
end

/* No it Doesn't - Create it */
if ( DrExam = 0 ) then do
  Call SysMkDir Make_Path
end
  

/* Let's unpack the files */

Call info.text "Unpacking DrExam.Ram."
'@'loadram DrExamRam Make_Path

/* Now, create a folder - DrExam - and populate with RES files */

Call info.text "Creating Example Folder."
msg = "create new EXAMPLES folder"
rc  = SysCreateObject( "WPFolder", "Examples", "<DRDIALOG>", "OBJECTID=<EXAMPLES>;", "U" )
If \rc Then Call FAILED

/*Res Files*/
Call info.text "Creating *.RES Objects."
call SysFileTree Install_Drive || Install_Path || '\*.RES', 'File', 'FO'
do i = 1 to file.0
  msg = "create" filespec( 'Name', file.i ) "program object"
  rc  = SysCreateObject( "WPShadow", filespec( 'Name', file.i ), "<EXAMPLES>", "SHADOWID="Install_Drive || Install_Path || "\" || filespec( 'Name', file.i ) || ";", "R" )
  If \rc Then Call FAILED
end

/*Rex Files*/
Call info.text "Creating *.REX Objects."
call SysFileTree Install_Drive || Install_Path || '\*.REX', 'File', 'FO'
do i = 1 to file.0
  msg = "create" filespec( 'Name', file.i ) "program object"
  rc  = SysCreateObject( "WPShadow", filespec( 'Name', file.i ), "<EXAMPLES>", "SHADOWID="Install_Drive || Install_Path || "\" || filespec( 'Name', file.i ) || ";", "R" )
  If \rc Then Call FAILED
end

Call info.text "DrExam is over - No Charge!"
Call SysSleep 3
exit;

FAILED:
Call info.text "Failed trying to" msg
Call SysSleep Timelmt
RETURN

ABORT:
Call info.text "Failed trying to" msg
Call SysSleep Timelmt
EXIT 100
�