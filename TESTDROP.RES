� �� 0
   d    e   � �d 0�   �   �  ��           J �  �� d � Q d ��k          o  �  � P e p ��Drop any object on the list box:     "         10.System Monospaced      ���d 0d  �e Drop�CALL EventData
PARSE VALUE EventData.8 WITH x1 y1 x2 y2
item = Add( '---------- Drop event --------------------' )
CALL Add 'Data:      ' EventData.1
CALL Add 'Container: ' EventData.2
CALL Add 'Type:      ' EventData.3
CALL Add 'Format:    ' EventData.4
CALL Add 'Operation: ' EventData.5
CALL Add 'Source ID: ' EventData.6
CALL Add 'Target ID: ' EventData.7
CALL Add 'Dropped at: (' || x1 || ',' || y1 || ') (' || x2 || ',' || y2 || ')'
CALL Select item, 'Top'Initz/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL Drop "ANY:ANY=ANY"�