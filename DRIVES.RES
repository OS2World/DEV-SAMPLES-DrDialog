� �� 0N   d    e  drivesm  treeg   j  totalh   k  usedi   l  freef  drive��� 0e  Analyze�PROCEDURE
file = arg(1)
item = tree.Add( file, 'BITMAP:#68', 'Last', arg(2) )
CALL SysFileTree file'\*.*', 'FILES', 'F'
local    = 0
subTotal = 0
DO i = 1 TO files.0
   local = local + word( files.i, 3 )
END
CALL SysFileTree file'\*.*', 'FILES', 'DO'
DO i = 1 TO files.0
   subTotal = subTotal + Analyze( files.i, item ) 
END
IF files.0 = 0 THEN trailer = ''
ELSE trailer = ' ('||Format( subTotal ) 'bytes)'
CALL tree.Item item, 'Value', file '=' Format( local ) 'bytes'||trailer
RETURN local + subTotalFormat�PARSE ARG n
result = ''
DO WHILE length( n ) > 3
   result = ','||right( n, 3 )||result
   n = left( n, length( n ) - 3 )
END
RETURN n||resultInit�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
CALL SysLoadFuncs�� �d 0�  �  �  ��    	     $ :  �� $ 9� d ��_      %   c � � 6" e d��      %   � �   6� m ���        �� �  
 g ����         � �  � J 
 j ���        � �i �  
 h ����         � �� � I 
 k ���        � �� �  
 i ����         � �� � I 
 l ���     � �05 � � 6 f ����DrRexx Drive Analysis Sample Program             ����      ����          ����      ����Total:              Used:              Free:              CANVAS Drive: ? ���d 04  �e Enter�CALL EventData
drive = Item( EventData.1 )
PARSE VALUE SysDriveInfo( drive ) WITH . free total label
CALL drive.Text 'Drive:' left( drive, 1 ) '  -'label
CALL total.Text Format( total ) 'bytes'
CALL used.Text Format( total - free ) 'bytes'
CALL free.Text Format( free ) 'bytes'
CALL tree.Hide 'N'
CALL tree.Delete
CALL Analyze drive, 0
CALL tree.View 'Hierarchy'
CALL tree.ShowInit�CALL Hide "N"
drives = SysDriveMap( "C" )
DO i = 1 TO words( drives )
   CALL Add word( drives, i ), 'BITMAP:#100'
END
CALL View 'FlowedName'
CALL Show�