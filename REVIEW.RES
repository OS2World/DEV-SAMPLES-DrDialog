� �� 08   d   errore  msgf   2   review3  	container4 	 mle� �d 0}   }   �  ��          h �  � j � % d ��u          y @�  �  e ����        z   �g  ) 
 f ����REView Error     Ok ���d 0r   �f Clickg/* (c) Copyright International Business Machines Corporation 1993 */
/* All rights reserved */

EXIT�� �2 0�   �   �  ��          h   �  � 2 ���       %   �  �  � � 3 � ��      
   �  ��  � � 4 ����REVIEW: DrRexx .REs VIEWer #             ����      ���� � �2 0,   ,   �      ~Edit    �      ~Copy ���2 0     CALL Clipboard mle.Text()���2 0  �2 Size�PARSE VALUE Position() WITH . . ncx ncy
dx = ncx - (fcx - ccx - mcx)
PARSE VALUE container.Position() WITH tx ty . tcy
cx = (40 * dx) % 100
CALL container.Position tx, ty, cx, tcy + ncy - fcy
PARSE VALUE mle.Position() WITH . ty . tcy
CALL mle.Position tx + cx, ty, dx - cx, tcy + ncy - fcy
fcy = ncyInit�PARSE VALUE Position() WITH . . fcx fcy
PARSE VALUE container.Position() WITH . . ccx .
PARSE VALUE mle.Position() WITH . . mcx .
PARSE SOURCE . . myPath
CALL directory left( myPath, lastpos( '\', myPath ) - 1 )
CALL mle.Drop 'REViewCode,REViewEvent,REViewClass,REViewMenu'
SIGNAL DoArgs�4 Drop?CALL EventData
CALL Text container.Item( EventData.6, 'DATA' )�3 Enter\CALL EventData
IF EventData.1 <> 0 THEN 
   CALL mle.Text Item( EventData.1, 'DATA' )' '
����2 0q   �	 Drop?CALL EventData
CALL Text container.Item( EventData.7, 'DATA' )Init"CALL Drop 'REViewCode,REViewEvent'����2 0|   2 REView ToolE4 REXX code associated with a particular entry in the hierarchical view"3 Hierarchical view of the .RES file���� 0`.  /* View a .RES file as a CONTAINER hierarchy view */
/* Written by: David C. Morrill                   */
/* Date: 11/21/93                                 */

DoArgs:
   CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
   CALL SysLoadFuncs

   PARSE ARG hwnd iniFile rest
   DrsAide = (left( hwnd, 2 ) = '-H')
   IF DrsAide THEN DO
      CALL DrDialog 'Init', hwnd
      CALL DrDialog 'Owner', 'review'
      resData = DrDialog( 'GetRes' )
      resFile = DrDialog( 'FileName' )
      IF resFile = '' THEN resFile = '???'
      END
   ELSE DO
      PARSE ARG resFile
      IF lastpos( '.', resFile ) = 0 THEN resFile = resFile'.RES'
      IF (SysFileTree( resFile, 'resFiles', 'FO' ) <> 0) |,
         (resFiles.0 <> 1) THEN DO
         CALL Error 'Please specify a DrRexx .RES file'
         SIGNAL RETURN
         END
      resFile = resFiles.1
      resData = CharIn( resFile, 1, Chars( resFile ) )
      CALL Stream resFile, 'C', 'CLOSE'
      IF resData = '' THEN DO
         CALL Error 'Could not read' resFile
         SIGNAL RETURN
         END
      END
   column    = 1
   dialogs   = 0
   globals   = ''
   externals = ''
   DO FOREVER
      IF column > length( resData ) THEN LEAVE
      IF substr( resData, column, 1 ) <> 'FF'X THEN DO
         CALL Error resFile 'is not a valid .RES file'
         SIGNAL RETURN
         END
      type   = C2D( reverse( substr( resData, column + 1, 2 ) ) )
      id     = C2D( reverse( substr( resData, column + 4, 2 ) ) )
      len    = C2D( reverse( substr( resData, column + 8, 4 ) ) )
      data   = substr( resData, column + 12, len )
      column = column + len + 12
      CALL DoResource type, id, data
   END
   DO d = 1 TO dialogs
      id = dialog.d
      CALL GetText dialogRes.id
      dialogItem = container.Add( 'dialog', 'DRBITMAP:#29' )
      CALL GetNames names.id, dialogItem
      IF class.id <> '' THEN CALL DoClass class.id
      IF event.id <> '' THEN CALL DoEvent event.id
      CALL DoClassCode names.id
      IF menu.id <> '' THEN DO
         menuCode = menu.id
         CALL DoMenu menuRes.id,,
                     container.Add( 'Menu', 'DRBITMAP:#30', 'LAST', dialogItem )
         END
   END
   IF globals <> '' THEN DO
      CALL DoProcs globals, container.Add( 'Global procedures', 'DRBITMAP:#37' )
      END
   IF externals <> '' THEN DO
      item = container.Add( 'External procedures', 'DRBITMAP:#36',,, externals )
      CALL container.Drag item, 'REViewCode'
      END
   CALL container.View 'Hierarchy'
   CALL Show
   SIGNAL RETURN

DoResource:
   SELECT
     WHEN arg(1) = 3 THEN DO /* Menu */
       id         = arg(2)
       menuRes.id = arg(3)
       END
     WHEN arg(1) = 4 THEN DO /* Dialog */
       id           = arg(2)
       dialogRes.id = arg(3)
       END
     WHEN arg(1) = 56320 THEN DO /* Dialog/control names */
       CALL DialogNames arg(3)
       END
     WHEN arg(1) = 56321 THEN DO /* Global procedures code */
       globals = left( arg(3), length( arg(3) ) - 1 )
       END
     WHEN arg(1) = 56322 THEN DO /* External code */
       externals = arg(3)
       END
     WHEN arg(1) = 56323 THEN DO /* Dialog menu code */
       id      = arg(2)
       menu.id = arg(3)
       END
     WHEN arg(1) = 56324 THEN DO /* Dialog event code */
       id       = arg(2)
       event.id = arg(3)
       END
     WHEN arg(1) = 56325 THEN DO /* Dialog class code */
       id       = arg(2)
       class.id = arg(3)
       END
     OTHERWISE /* Do nothing - unknown resource type */
   END
   RETURN

DialogNames:
   i     = 1
   start = 0
   data  = arg(1)
   DO WHILE i <= length( data )
      IF substr( data, i + 2, 2 ) = '0000'X THEN DO
         IF start <> 0 THEN DO
            names.id = substr( data, start, i - start )
            END
         id             = C2D( reverse( substr( data, i, 2 ) ) )
         dialogs        = dialogs + 1
         dialog.dialogs = id
         event.id       = ''
         class.id       = ''
         menu.id        = ''
         start          = i
         END
      i = i + C2D( substr( data, i + 4, 1 ) ) + 5
   END
   names.id = substr( data, start, i - start )
   RETURN

GetText:
   DROP record. last. evt. cls. text.
   data = arg(1)
   n    = C2D( reverse( substr( data, 17, 2 ) ) ) + 1
   DO i = 15 TO 14 + 30 * n BY 30
      curId = C2D( reverse( substr( data, i + 24, 2 ) ) )
      len   = C2D( reverse( substr( data, i + 8, 2 ) ) )
      IF len = 0 THEN text.curId = ''
      ELSE DO
         offset     = C2D( reverse( substr( data, i + 10, 2 ) ) ) + 1
         text.curId = '0D0A'x || "'"substr( data, offset, len )"'"
         END
   END
   RETURN

GetNames:
   i      = 1
   data   = arg(1)
   parent = arg(2)
   DO WHILE i <= length( data )
      curId   = C2D( reverse( substr( data, i, 2 ) ) )
      curType = C2D( reverse( substr( data, i + 2, 2 ) ) )
      curLen  = C2D( substr( data, i + 4, 1 ) )
      bitmap  = curType + 1
      IF curLen = 0 THEN DO
         IF curType = 0 THEN prefix = 'D'; ELSE prefix = 'C'
         name = prefix || curId
         END
      ELSE name = substr( data, i + 5, curLen )
      IF curType = 0 THEN CALL container.Item parent,, name
      IF symbol( 'LAST.BITMAP' ) = 'VAR' THEN
         record.curId = container.Add( name || text.curId, 'DRBITMAP:#'bitmap,,
                                       'NEXT', last.bitmap )
      ELSE
         record.curId = container.Add( name || text.curId, 'DRBITMAP:#'bitmap,,
                                       'LAST', parent )
      CALL container.Drag record.curId, 'REViewControl'
      last.bitmap = record.curId
      evt.curId   = ''
      i           = i + curLen + 5
   END
   RETURN

DoEvent:
   data = arg(1)
   i    = 1
   DO FOREVER
      curLen = C2D( substr( data, i, 1 ) )
      IF curLen = 255 THEN LEAVE
      IF curLen = 128 THEN DO
         curId  = C2D( reverse( substr( data, i + 1, 2 ) ) )
         i      = i + 3
         curLen = C2D( substr( data, i, 1 ) )
         END
      curEvent = substr( data, i + 1, curLen )
      i        = i + curLen + 1
      curLen   = C2D( substr( data, i, 1 ) )
      IF curLen > 127 THEN DO
         i      = i + 1
         curLen = (curLen - 128) + 128 * C2D( substr( data, i, 1 ) )
         END
      item = container.Add( curEvent, 'DRBITMAP:#34', 'LAST', record.curId,,
                            substr( data, i + 1, curLen ) )
      CALL container.Drag item, 'REViewEvent'
      i         = i + curLen + 1
      evt.curId = evt.curId curEvent
   END
   RETURN

DoClass:
   data = arg(1)
   i    = 1
   DO FOREVER
      curLen = C2D( substr( data, i, 1 ) )
      IF curLen = 255 THEN LEAVE
      IF curLen = 128 THEN DO
         curType = C2D( reverse( substr( data, i + 1, 2 ) ) )
         i       = i + 3
         curLen  = C2D( substr( data, i, 1 ) )
         cls.curType = ''
         END
      curEvent = substr( data, i + 1, curLen )
      i        = i + curLen + 1
      curLen   = C2D( substr( data, i, 1 ) )
      IF curLen > 127 THEN DO
         i      = i + 1
         curLen = (curLen - 128) + 128 * C2D( substr( data, i, 1 ) )
         END
      cls.curType          = cls.curType curEvent
      cls.curType.curEvent = substr( data, i + 1, curLen )
      i                    = i + curLen + 1
   END
   RETURN

DoClassCode:
   i    = 1
   data = arg(1)
   DO WHILE i <= length( data )
      curId   = C2D( reverse( substr( data, i, 2 ) ) )
      curType = C2D( reverse( substr( data, i + 2, 2 ) ) )
      curLen  = C2D( substr( data, i + 4, 1 ) )
      i       = i + curLen + 5
      IF symbol( 'CLS.CURTYPE' ) = 'VAR' THEN DO
         events = cls.curType' '
         list   = evt.curId;
         DO j = 1 TO words( list )
            curEvent = word( list, j )
            col      = pos( ' 'curEvent' ', events )
            IF col <> 0 THEN
               events = left( events, col - 1 ),
                        substr( events, col + length( curEvent ) + 2 )
         END
         DO j = 1 TO words( events )
            curEvent = word( events, j )
            item = container.Add( curEvent, 'DRBITMAP:#35', 'LAST', record.curId,,
                                  cls.curType.curEvent )
            CALL container.Drag item, 'REViewClass'
         END
         END
   END
   RETURN

DoProcs:
   procs  = arg(1)
   parent = arg(2)
   i      = 1
   DO WHILE i <= length( procs )
      len  = C2D( substr( procs, i, 1 ) )
      name = substr( procs, i + 1, len )
      i    = i + len + 1
      len  = C2D( substr( procs, i, 1 ) )
      IF len > 127 THEN DO
         i   = i + 1
         len = (len - 128) + 128 * C2D( substr( procs, i, 1 ) )
         END
      item = container.Add( name, 'DRBITMAP:#36', 'LAST', parent,,
                            substr( procs, i + 1, len ) )
      CALL container.Drag item, 'REViewCode'
      i = i + len + 1
   END
   RETURN

DoMenu: PROCEDURE EXPOSE menuCode
   MIS_TEXT      = '0100'x
   MIS_SEPARATOR = '0400'x
   MIS_SUBMENU   = '1000'x
   MIS_STATIC    = '0001'x
   MIA_CHECKED   = '0020'x
   MIA_DISABLED  = '0040'x
   data   = arg(1)
   parent = arg(2)
   n      = C2D( reverse( substr( data, 9, 2 ) ) )
   col    = 11
   nextId = -1
   IF length( menuCode ) >= 2 THEN
      nextId = C2D( reverse( substr( menuCode, 1, 2 ) ) )
   DO i = 1 TO n
      style    = substr( data, col, 2 )
      attr     = substr( data, col + 2, 2 )
      curId    = C2D( reverse( substr( data, col + 4, 2 ) ) )
      col      = col + 6
      attrText = ''
      label    = ''
      code     = ''
      IF curId = nextId THEN DO
         len   = C2D( substr( menuCode, 3, 1 ) )
         label = substr( menuCode, 4, len )
         col2  = 4 + len
         len   = C2D( substr( menuCode, col2, 1 ) )
         IF len > 127 THEN DO
            col2 = col2 + 1
            len = (len - 128) + 128 * C2D( substr( menuCode, col2, 1 ) )
            END
         code     = substr( menuCode, col2 + 1, len )
         menuCode = substr( menuCode, col2 + 1 + len )
         nextId   = -1
         IF length( menuCode ) >= 2 THEN
            nextId = C2D( reverse( substr( menuCode, 1, 2 ) ) )
         END
      IF BITAND( attr, MIA_CHECKED  ) <> '0000'x THEN attrText = ' (Checked'
      IF BITAND( attr, MIA_DISABLED ) <> '0000'x THEN DO
         IF attrText = '' THEN attrText = ' ('; ELSE attrText = attrText' '
         attrText = attrText || 'Disabled'
         END
      IF attrtext <> '' THEN attrText = attrText')'
      IF BITAND( style, MIS_TEXT ) <> '0000'x THEN DO
         col2 = pos( '00'x, data, col )
         text = substr( data, col, col2 - col )
         col  = col2 + 1
         END
      ELSE text = ''
      IF BITAND( style, MIS_SEPARATOR ) <> '0000'x THEN
         item = container.Add( label || attrText, 'DRBITMAP:#33', 'LAST', parent )
      ELSE DO
         IF BITAND( style, MIS_SUBMENU ) <> '0000'x THEN bitmap = 30
         ELSE IF code <> '' THEN                         bitmap = 31
         ELSE                                            bitmap = 32
         item = container.Add( label || attrText || '0D0A'x || "'"text"'",,
                               'DRBITMAP:#'bitmap, 'LAST', parent, code )
         IF code <> '' THEN CALL container.Drag item, 'REViewMenu'
         IF BITAND( style, MIS_SUBMENU ) <> '0000'x THEN DO
            CALL DoMenu substr( data, col ), item
            col = col + C2D( reverse( substr( data, col, 2 ) ) )
            END
         END
   END
   RETURN

Error:
   CALL error.Open , 'Review Error'
   CALL error.msg.Text arg(1)
   IF DrsAide THEN CALL DrDialog 'Owner', 'error'
   CALL error.Show
   RETURN
