� �� 0r   d   Introf   g   h   i   e   �   Demo�   �   �   �   �   �   �   �   � 
  �   � 	  �   �   �   � �d 0    �  ��          �    �� X � | d ���        K � @� _ �  f ����       � /@ � 0 � * g ����       2 �@ �  �  h ����        �  �;  4  i ����       @4 �    � { e ����DrRexx Events Sample Program    This program demonstrates the events that a DrRexx application can process. Each user intertace event causes a message displaying the name of the event and the control generating it to be displayed in the DrRexx run-time window. Click the button below to proceed with the demo... Continue CANVAS  ���d 0�   �i Click�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL Intro.Close
CALL Demo.Open , ""�� �� 0Z  Z  �  ��          �  �r J � l � ���        �  �  M X � ����    	 �	   �
 + A  � ����       
   �
 S A  � ����       	  �
 G A 
 � ����        " �
 ; A 
 � ����    
 /
 :  �
    � ����         E �X  > S � ����         F  ��   S � ����        G �� # S C � ����        M �� I R  � ����      
  S ��  S 3 � ����      &   W  �  M 	 � ����         X  �X  ?  � ����          Y ��  S  � ����DrRexx Events Sample Program    Buttons BAGBUTTON BagButton Pushbutton Check box Radio button ICONBUTTON BITMAP:#28   Combo Entry MLE    ���� 0�   �� Any"SAY Event() "occurred for" Class()�� InitCALL Range 1, 15�� Init!DO i = 1 TO 15
  CALL Add i
END�� Init!DO i = 1 TO 15
  CALL Add i
END�