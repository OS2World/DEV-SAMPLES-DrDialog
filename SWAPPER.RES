� �� 0J   d    f   g   h   j   k  filel  sizem  freeo  percentp   e   ��� 09  BigNum�PARSE ARG number
result = right( number,3)
number = left(number, length(number)-3)
DO WHILE length(number) > 0
  result = right(number, 3)","result
  IF length(number) < 3 THEN LEAVE
  number = left(number, length(number) - 3) 
END
return resultShowSwapperSize�CALL SysFileTree swapper, file
swapSize = word( file.1, 3 )
CALL size.Text( BigNum( swapSize ) )
info = SysDriveInfo( left( swapper, 2 ) )
freeSpace = word( info, 2 )
CALL free.Text( BigNum( freeSpace ) )
CALL percent.Text( Format( (swapSize/(swapSize + freeSpace)*100), 4, 0 )"%" )�� �d 0�  �  �  ��    
      X   �� � � ? d ��l        p� 2  
 f ����        v � '  
 g ����        | �   
 h ����        � �   
 j ����         � �% 2 ` 
 k ����         � �% ' ` 
 l ����         � �%  ` 
 m ����         � �%  ` 
 o ����        � �-  (  p ����     �  �@4 �    � ? e ����SWAPPER.DAT Monitor    Path: Size: Free: Used:     Update CANVAS  ���d 0�  �d TimerCALL ShowSwapperSizeInit�/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

CALL RxFuncAdd 'SysLoadFuncs','RexxUtil','SysLoadFuncs'
CALL SysLoadFuncs
IF SysFileSearch( "SWAPPATH=", "C:\CONFIG.SYS", path ) \= 0 THEN
  SAY "Could not find swap path"
ELSE DO
  PARSE VAR path.1 . "=" swapper .
  CALL file.Text( swapper )
  swapper = swapper"\SWAPPER.DAT"
  CALL ShowSwapperSize
  CALL Timer 60000
END�p ClickCALL ShowSwapperSize�