� �� 0�   d   Controls�   �   �   �   �   �   �   �   �   � 
  s 	  t   f   h   i   g   w   u   y   }   |   �   n   �   r   e   k   l   �   {   m   �   �   Colors�   ,  Fonts. points/
 font0  1  2  - text3  ��� 0�  DropFontIIF EventData.3 <> 'Font' THEN RETURN 0
CALL Font EventData.1
RETURN 1
SetFont�points  = points.Text()
font    = font.Text()
curFont = points'.'font || style
CALL text.Font curFont
CALL text.Drag 'Font='curFont	DropColor�IF EventData.3 <> 'Color' THEN RETURN 0
c = EventData.6 % 65536
r = EventData.6 - 65536 * c
IF r = 1 THEN attr = '+'; ELSE attr = '-'
CALL Color attr, EventData.1
RETURN 1
DropContUCALL EventData
IF \DropColor() THEN 
   CALL Item EventData.7, 'Value', EventData.1DropListwCALL EventData
IF \DropColor() & \DropFont() THEN DO
   item = Add( EventData.1 )
   CALL Select item, 'Top'
   ENDDropTextMCALL EventData
IF \DropColor() & \DropFont() THEN 
   CALL Text EventData.1DragInit�CALL Drag 'Control'
     IF arg(1) = ''  THEN CALL Drop 'Control,Color,Font'
ELSE IF arg(1) = '+' THEN CALL Drop 'Control,Color'
ELSE IF arg(1) = '-' THEN CALL Drop 'Control'�� �d 0_  _  �  ��          I ��  H < J� d ��6      %   : � m F 2 � ;��      (   W  �Q m 8 2 � ����         X  �� � P  � ����      &   Y  �� � P 
 � ����          Z �� � P  � ����      '   [0 �� m P  � ��\         d  �� n  1 � ����     e  l04 �� j e 8 � ����         m � , A : � ����         n �I * A < � ����      
  o �� 5 _ % s ����        s �� * _ 
 t ����        y  � � B  f ����        ~ � q B 
 h ����        � � d B 
 i ����    	 �	 � � ~ B  g ����    
 �
 �  �o    w ����    	 �
 �� �	  (   u ����     �, � � �?  (   y ����        ���  ^  } ����      
!� ��  ^  | ����       04 � j � 8 � ����       !04 �� j e 8 n ����     "  )04 � ( � A � ����     * 104 �� ( e A r ����     8  ?04 �� ] P D e ����        @  �� F F  k ����         F  �� 0 F  l ����     G  N04 �  � & � ����     O  V04 ��  e % { ����         W  ��  F  m ����     X  ^  ��  F  � ����DragDrop: Try dragging and dropping any control onto any other control...             ����      ����           CANVAS    MLE Entry Push Check Radio BAGBUTTON BagButton ICONBUTTON BITMAP:#29 BILLBOARD BITMAP:#48 TURTLE b15c7y50z50{<(ur)(rd)(dl)(lu)>}1=1x25z25c2=1 Text MARQUEE Marquee CANVAS  CANVAS  CANVAS  CANVAS Canvas CANVAS  Group  CANVAS  CANVAS   PAINT  ���d 0�  �d Init�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL Colors.Open
CALL Colors.Show
CALL Fonts.Open
CALL Fonts.Show
CALL Show
�� DropCALL DropTextInit.CALL Drag 'Control=Paint'
CALL Drop 'Control'�m DropCALL DropTextInit2CALL Drag 'Control=Rectangle'
CALL Drop 'Control'�l DropCALL DropTextInit.CALL Drag 'Control=Frame'
CALL Drop 'Control'�k DropCALL DropTextInitCALL DragInit�r DropCALL DropTextInitCALL DragInit '-'�| Drop'CALL Hide 'N'
CALL DropText
CALL ShowInitCALL DragInit '-'�} DropCALL DropTextInitCALL DragInit�y DropCALL DropTextInitCALL DragInit '-'�u DropCALL DropTextInitCALL DragInit '-'�w DropCALL DropTextInitCALL DragInit '-'�g DropCALL DropTextInitCALL DragInit '-'�i DropCALL DropTextInitCALL DragInit�h DropCALL DropTextInitCALL DragInit�f DropCALL DropTextInitCALL DragInit�t DropCALL DropTextInitCALL DragInit�s DropCALL DropTextInitCALL DragInit '+'�� DropCALL DropTextInit=DO i = 1 TO 10
   CALL Add 'Combo box' i
END
CALL DragInit�� DropCALL DropListInit<DO i = 1 TO 10
   CALL Add 'List box' i
END
CALL DragInit�� Init#CALL Range 0, 15
CALL DragInit '-'�� Drop�CALL EventData
c = EventData.7 % 65536
r = EventData.7 - 65536 * c
PARSE VALUE EventData.2 WITH ctl'='class
IF (class = 'ICONBUTTON') | (class = 'BILLBOARD') THEN 
   EventData.1 = '='EventData.1
ELSE IF DataType( EventData.1, 'W' ) THEN
   EventData.1 = '#'EventData.1
CALL Item r, c, EventData.1Init>DO i = 1 TO 4
   CALL Item 1, i, '#'i
END
CALL DragInit '+'�� Init#CALL Range 0, 15
CALL DragInit '-'�� InitCALL DragInit '-'�� Init#CALL Range 0, 15
CALL DragInit '-'�� DropCALL DropTextInitCALL DragInit '+'�� DropCALL DropContInit�DO i = 1 TO 5
   item = Add( 'Container' i, 'BITMAP:#'i )
   CALL Drag item, 'Control'
   CALL Drop item, 'Control'
END
CALL Drop 0, 'Color'
�� �� 0s   s   �  ��          J �  N  �   � ��f       '   j 0 �    �   � ��k Drag and drop color palette         ���� 0u   �� InitkDO r = 1 TO 2
   DO c = 1 TO 8
      CALL Item r, c, '#'||(8 * r + c - 9)
   END
END
CALL Drag 'Color'�� �,0w  w  �  ��          � �  �  � 0 ,��           � " "  .����          �%  U + /����    
     �|    0����    
 ( 3   ��    1����    
 ? J   ��    2����        V�  �  -]��         v  �  �  3����Font palette     ICONBUTTON BITMAP:#153 ICONBUTTON BITMAP:#154 ICONBUTTON BITMAP:#155 Sample          10.Helvetica  ���,0X  �,Initstyle = ''
�-InitCALL Drag 'Font=10.Helvetica'�2Clickstyle = ' Italic'
CALL SetFont�1Clickstyle = ' Bold'
CALL SetFont�0Clickstyle = ''
CALL SetFont�/EnterCALL SetFontInitSCALL Add 'Helvetica'
CALL Add 'Times New Roman'
CALL Add 'Courier'
CALL Select 1�.DoneCALL SetFontInit CALL Range 6, 48
CALL Select 10�