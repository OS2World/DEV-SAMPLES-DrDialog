� �� 0    d   maine  facf   g  every��� 0�   	Factorial�fac = 1
n   = 1
DO FOREVER
   NUMERIC DIGITS length( fac || n )
   fac = n * fac
   CALL Notify 'main', n, fac
   n = n + 1
END�� �d 0�   �   �  ��         	 �   �� h � Z d ���          � @�  � N e ����        �  �  @ 
 f ����          �  �G     g ����Factorial #    Update every:  ���d 0�  �d Size�PARSE VALUE Position() WITH . . dx dy
PARSE VALUE Frame() WITH left bottom right top
PARSE VALUE fac.Position() WITH . y . .
CALL fac.Position left, y, dx - left - right, dy - y - topNotify�CALL EventData
CALL Text EventData.1'! ('length( EventData.2 ) 'digits)'
IF (EventData.1 // every.Text()) = 0 THEN
   CALL fac.Text EventData.2InitCALL Start 'Factorial'�g InitCALL Range 1,100�