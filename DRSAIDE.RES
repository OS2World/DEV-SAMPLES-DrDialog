� �� 0�   d   DrsAidee   f   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x   �   msg�  text�   ,  dup- msg2.  /  �  appList� apps� resFile� bmpFile�  �  �  �  �  � err��� 0�  ToolName�PROCEDURE
res = left( arg(1), pos( '(', arg(1) ) - 1 )
col = lastpos( '\', res )
IF col = 0  THEN col = lastpos( ':', res )
res = substr( res, col + 1 )
col = lastpos( '.', res )
IF col <> 0 THEN res = left( res, col - 1 )
RETURN res
Message7CALL msg.Open
CALL msg.text.Text arg(1)
CALL msg.ShowInit�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
CALL SysLoadFuncs
PARSE ARG arg
tArg = translate( arg, '01'X, ' ' )
PARSE SOURCE . . myName
iniFile = SysIni( 'SYSTEM', 'DRDIALOG', 'INIPATH' )
IF iniFile <> 'ERROR:' THEN DO
   col = pos( '00'x, iniFile )
   IF col <> 0 THEN iniFile = left( iniFile, col - 1 )
   IF right( iniFile, 1 ) <> '\' THEN iniFile = iniFile'\'
   iniFile = iniFile'DrsAide.INI'
   END
ELSE DO
   col     = lastpos( '.', myName )
   iniFile = left( myName, col )'INI'
   END
apps = SysIni( iniFile, 'DrsAide', 'Apps' )
IF apps = 'ERROR:' THEN DO
   apps   = ''
   myPath = left( myName, lastpos( '\', myName ) )
   list   = 'RexxUse RexxLib Array REView REStoRXX'
   DO i = 1 TO words( list )
      app  = word( list, i )
      apps = apps myPath || app'.RES('myPath || app'.BMP)'
   END
   CALL SysIni iniFile, 'DrsAide', 'Apps', apps
   END
IF left( arg, 2 ) = '-H' THEN DO
   CALL DrDialog 'Init', arg
   IF words( apps ) > 0 THEN CALL DrsAide.Open
   ELSE DO
      CALL Message 'No DrsAide applications have been specified yet'
      CALL DrDialog 'Owner', 'msg', 'DrsAide'
      END
   END
ELSE IF arg = '' THEN CALL appList.Open
ELSE DO
    IF pos( ' 'tArg'(', apps ) = 0 THEN DO
       col       = lastpos( '.', arg )
       bmpFile = left( arg, col )'BMP'
       CALL SysFileTree bmpFile, 'FILES', 'FO'
       IF files.0 = 0 THEN DO
          'START' left( myName, lastpos( '\', myName ) )'DRREXX "'arg'" -I' iniFile
          EXIT
          END
       ELSE DO
           CALL SysIni iniFile, 'DrsAide', 'Apps', apps tArg'('translate( bmpFile, '01'X, ' ' )') '
           CALL Message arg 'added to DrsAide'
           END
       END
   ELSE CALL dup.Open
   END�� �d 04  4  �  ��          ��  � |   d ���    
 �	 �  �     e ����    
 �	 �   �     f ����    
 �	 �   �     g ����    
 �	 �   �     h ����    
 �	 �   �     i ����    
 �	    �     j ����    
 	    �     k ����    
 #	 .   �     l ����    
 8	 C   �     m ����    
 M	 X   �     n ����    
 b	 m   �     o ����    
 w	 �   �     p ����    
 �	 �   �     q ����    
 �	 �   �     r ����    
 �	 �   �     s ����    
 �	 �   �     t ����    
 �	 �   �     u ����    
 �	     �     v ����    
 
	    �     w ����    
 	 *   �     x ����DrsAide   ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ICONBUTTON BITMAP:#1 ���d 08  �d Exit�PARSE VALUE Position() WITH newx newy . .
IF (newx <> x) | (newy <> y) THEN CALL SysIni iniFile, 'DrsAide', 'Pos', newx newy dx dy
IF startingApps <> apps THEN CALL SysIni iniFile, 'DrsAide', 'Apps', appsInit�CALL DrDialog 'Owner', 'DrsAide', 'DrsAide'
PARSE VALUE Frame() WITH left bottom right top 
startingApps = apps
DO i = 1 TO words( apps )
    app     = translate( word( apps, i ),  ' ', '01'X )
    col     = pos( '(', app ) + 1
    bmpFile = substr( app, col, pos( ')', app, col ) - col )
    CALL IsDefaultFor 'DrsAide', 'C' || (100 + i)
    CALL Text bmpFile
    CALL Position left + 40 * (i-1), bottom
    CALL Drag 'DrsAideButton'
    CALL Drop 'DrsAideButton'
    CALL Hint 'Click to invoke the' ToolName( app ) 'tool'
END
DO i = words( apps ) + 1 TO 20
   CALL HideFor 'DrsAide', 'C' || (100 + i)
END
CALL IsDefaultFor 'DrsAide'
PARSE VALUE SysIni( iniFile, 'DrsAide', 'Pos' ) WITH x y . .
IF x = 'ERROR:' THEN PARSE VALUE Position() WITH x y . .
CALL Position x, y, 40 * words( apps ) + left + right, 40 + bottom + top
CALL Show����d 0   � Click�id       = substr( Control(), 2 ) - 100
app     = translate( word( apps, id ), ' ', '01'X )
col      = pos( '(', app )
resFile = left( app, col - 1 )
IF DrDialog( 'Focus', resFile ) = 0 THEN
   'START' left( myName, lastpos( '\', myName ) )'DRREXX "'resFile'"' arg iniFile
Drop�CALL EventData
PARSE VALUE EventData.2 WITH dlg'.'ctl'='type
IF ctl <> Control() THEN DO
   fromCtl = substr( ctl, 3 )
   toCtl   = substr( Control(), 3 )
   fromApp = word( apps, fromCtl )
   toApp   = word( apps, toCtl )
   temp    = subword( apps, 1, fromCtl - 1 ) subword( apps, fromCtl + 1 )
   apps    = subword( temp, 1, toCtl - 1 ) fromApp subword( temp, toCtl )
   IF fromCtl > toCtl THEN DO
      temp    = fromCtl
      fromCtl = toCtl
      toCtl   = temp	
      END
   DO i = fromCtl TO toCtl
      app = word( apps, i )
      col = pos( '(', app ) + 1
      CALL IsDefaultFor dlg, 'C'||(100+i)
      CALL Text substr( app, col, pos( ')', app, col ) - col )
      CALL Hint 'Click to invoke the' ToolName( app ) 'tool'
   END����d 0   d DrsAide tool�� �� 0x   x   �  ��          h �  � � � & � ��p          t @�  �  � ����        u   �S  (  � ����DrsAide    OK ���� 0   �� ClickEXIT�� �,0�   �   �  ��          � �  � � � * ,���          � @�  �  -����        �   �%  (  .����        �   �l  (  /����DrsAide     Delete Cancel ���,0  �,Init2CALL msg2.Text arg 'is already defined'
CALL Show�/ClickEXIT�.Click�col   = pos( ' 'arg'(', apps )
col2  = pos( ')', apps, col + length( arg ) + 2 )
apps = left( apps, col - 1 ) || substr( apps, col2 + 1 )
CALL SysIni iniFile, 'DrsAide', 'Apps', apps
EXIT�� ��0�  �  �  ��    	      :  l 7 (� ���B      %   F � 9 &x �G��         c �   �  ���d         l ��   �  ���m        u �I  .  �����        y �z  .  �����        � ��  .  �����     �
 �05 �  �  �����     �
 �05 ��  �  �����     �  �0 �  " �����DrsAide #            ����      ����              Add Delete Save CANVAS .RES file: CANVAS .BMP file: CANVAS  ����0d  ��Click�apps = ''
DO i = 1 TO words( appItems )
   item = word( appItems, i )
   apps = apps translate( apps.Item( item, 2 ), '01'X, ' ' )'('translate( apps.Item( item, 3 ), '01'X, ' ' )')'
END
CALL SysIni iniFile, 'DrsAide', 'Apps', apps��Click�item = apps.Select()
IF item = topOfList THEN DO
   CALL Beep 440, 50
   SIGNAL RETURN
   END
CALL apps.Delete item
DO i = 1 TO words( appItems )
   IF item = word( appItems, i ) THEN DO
      appItems = subword( appItems, 1, i - 1 ) subword( appItems, i + 1 )
      IF i = 1 THEN item = topOfList
      ELSE item = word( appItems, i - 1 )
      CALL apps.Select item
      LEAVE
      END 
END
CALL err.Text ''��Click�data.2 = resFile.Text()
IF data.2 = '' THEN DO
   CALL err.Text "Enter .RES file name first, then click 'Add'"
   SIGNAL RETURN
   END
data.1 = bmpFile.Text()
CALL SysFileTree data.2, 'FILES', 'FO'
IF files.0 = 0 THEN CALL err.Text "Could not find '"data.2"'"
ELSE DO
  DO i = 1 TO words( appItems )
     app = apps.Item( word( appItems, i ), 2 )
     IF translate( data.2 ) = translate( app ) THEN DO
        CALL err.Text "'"data.2"' is already installed"
        SIGNAL RETURN
        END
  END
  IF data.1 = '' THEN DO
     data.1 = left( data.2, lastpos( '.', data.2 ) )'BMP'
     CALL bmpFile.Text data.1
     END
  data.3  = data.1
  item    = apps.Select()
  newItem = apps.Add( 'Item', 'BITMAP:#1', 'Next', item )
  CALL apps.SetStem 'DATA', newItem
  CALL apps.Select newItem
  CALL err.Text ''
  IF item = topOfList THEN appItems = newItem appItems
  ELSE DO
     DO i = 1 TO words( appItems )
        IF item = word( appItems, i ) THEN LEAVE
     END
     appItems = subword( appItems, 1, i ) newItem subword( appItems, i + 1 )
     END
  END��Changed�CALL EventData
IF EventData.1 = topOfList THEN CALL Item EventData.1, 3, '-' 
ELSE CALL Item EventData.1, 1, Item( EventData.1, 3 ) Enter�CALL EventData
IF EventData.1 <> 0 THEN DO
   CALL resFile.Text Item( EventData.1, 2 )
   CALL bmpFile.Text Item( EventData.1, 3 )
   ENDInit�format.0 = 3
format.1 = '=X_!'
format.2 = 'X<_!'
format.3 = '<_!'
CALL SetStem 'FORMAT', 'Format'
title.0 = 3
title.1 = 'Icon'
title.2 = '.RES file'
title.3 = '.BMP file'
CALL SetStem 'TITLE', 0
data.0    = 3
data.1    = ''
data.2    = '---Top of List---'
data.3    = '---'
topOfList = Add( 'item', 'BITMAP:#1' )
CALL SetStem 'DATA', topOfList
appItems = ''
DO i = 1 TO words( apps )
   app    = translate( word( apps, i ), ' ', '01'X )
   col    = pos( '(', app )
   col2   = pos( ')', app, col + 1 )
   data.1 = translate( substr( app, col + 1, col2 - col - 1 ), ' ', '01'X )
   data.2 = left( app, col - 1 )
   data.3 = data.1
   item   = Add( 'item', 'BITMAP:#1' )
   CALL SetStem 'DATA', item
   appItems = appItems item
END
CALL View 'Detail', '_;Installed DrsAide Applications'
CALL appList.Show�