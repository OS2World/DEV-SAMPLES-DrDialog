� �� 0�   d   Softball�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   p   �   l   i   m   o   j   h   f   k   n   g   e  
background��� 0�  ImportRoster�DO i = 102 TO 111
   CALL IsDefaultFor dlg, 'C'i
   CALL Text ''
   CALL Drag ''
   CALL Hint  ''
END
CALL GetPlayers ClipBoard()
RETURN
InitRoster�IF player.0 > 16 THEN player.0 = 16
DO i = 1 TO player.0
   CALL IsDefaultFor dlg, 'C' || (200+i)
   CALL Drag 'Player'
   CALL Drop 'Player'
   col = pos( ':', player.i )
   IF col = 0 THEN DO
      CALL Text player.i
      CALL Hint 'Drag player to position using mouse button 2'
      END
   ELSE DO
      CALL Text left( player.i, col - 1 )
      CALL Hint substr( player.i, col + 1 )
      END
END
DO i = i TO 16
   CALL IsDefaultFor dlg, 'C' || (200+i)
   CALL Drag ''
   CALL Drop 'Player'
   CALL Text ''
   CALL Hint ''
END
RETURN
GetPlayers�DROP player.
roster = arg(1)
i      = 0
IF roster <> '' THEN DO
   start = 1
   DO FOREVER
      col = pos( '0D0A'X, roster, start )
      IF col = 0 THEN LEAVE
      i = i + 1
      player.i = substr( roster, start, col - start )
      start = col + 2
   END
   END
player.0 = i
CALL InitRoster
RETURNDefaultRoster�PARSE SOURCE . . resFile
col = lastPos( '\', resFile )
IF col = 0 THEN col = lastPos( ':', resFile )
rosterFile = left( resFile, col )'SOFTBALL.RST'
CALL background.Text '|'left( resFile, col )'SOFTBALL.MET|'
roster = CharIn( rosterFile, 1, Chars( rosterFile ) )
CALL stream rosterFile, 'C', 'CLOSE'
CALL GetPlayers roster
RETURN�� �d 0�  �  �  ��          ��  ��  $d ���     �  � 4 � � 7 
 � ����     �  � 4 � � 7 
 � ����     �  � 4 � � 7 
 � ����     �  � 4 � � 7 
 � ����     �  � 4 �I � 7 
 � ����     �  � 4 �I � 7 
 � ����     �  � 4 �I � 7 
 � ����     �  � 4 �I � 7 
 � ����     �  � 4 �� � 7 
 � ����     �  � 4 �� � 7 
 � ����     �    4 �� � 7 
 � ����        4 �� � 7 
 � ����     	   4 �� � 7 
 � ����        4 �� � 7 
 � ����         4 �� � 7 
 � ����     !  ( 4 �� � 7 
 � ����     ) 0 4 � � � E p ����     7  >  � � � 
 � ����     ?  F 4 � � 7 
 l ����     G  N 4 �( N 7 
 i ����     O  V 4 �a � 7 
 m ����     W  ^ 4 �` � 7 
 o ����     _  f 4 �1 n 7 
 j ����     g  n 4 �� n 7 
 h ����     o  v 4 �d N 7 
 f ����     w  ~ 4 �d  7 
 k ����       � 4 �� � 7 
 n ����     �  � 4 �� N 7 
 g ����     �! � � �   e ����Fielding Positions   CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS Roster CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  CANVAS  TURTLE |f:\drdialog\drrexx\softball.met| � �d 0E   E   �      Import .   �      ~Import roster from clipboard ���d 0     CALL ImportRoster���d 0�   �d Initadlg = 'Softball'
DO i = 102 TO 111
   CALL DropFor dlg, 'C'i, 'Player'
END
CALL DefaultRoster�� InitCALL IsDefault 'C'����d 0�  � Drop�CALL EventData
src = 'C'||EventData.6
dst = 'C'||EventData.7
player      = TextFor( dlg, src )
playerHint = HintFor( dlg, src )
position    = TextFor( dlg, dst )
positionHint = HintFor( dlg, dst )
CALL IsDefaultFor dlg, src
IF position = '' THEN DO
   CALL Text ''
   CALL Drag ''
   CALL Hint ''
   END
ELSE DO
   CALL Text position
   CALL Hint positionHint
   END
CALL IsdefaultFor dlg, dst
CALL Text player
CALL Drag 'Player'
CALL Hint playerHint����d 0�  'd Help assign players to field positions e Playing field
g First basen Right fieldk Catcherf Pitcherh Second base
j Short stopo Utility fieldm Center field
i Third base
l Left field9� Helpful hints about using this program are displayed herep The roster of available players� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench� Empty seat on the bench�