� �� 0o   d   errore  msgf   2   revise3  	containerg  addh  delete�   Save�   �   �   ,  log- message� �d 0}   }   �  ��          h �  � d � % d ��u          y @�  �  e ����        z   �g  ) 
 f ����REVise Error     Ok ���d 0   �f ClickEXIT�� �2 0�   �   �  ��          �   � T � � 2 ���       %   �     � | 3 � ��     �  � @0 �  I  g ����     �  � @0 �L  I  h ����REVise: DrRexx Cut N' Paste #            ����      ����CANVAS Add CANVAS Delete ���2 0�   �2 ExitSIGNAL DoExitSizeSIGNAL DoSizeInitaPARSE SOURCE . . myPath
CALL directory left( myPath, lastpos( '\', myPath ) - 1 )
SIGNAL DoArgs�h DropSIGNAL DoDropDelete�g DropSIGNAL DoDropAdd�� �� 0�   �   �  ��          � �  � � �  � ���         � @�  � 
 � ����        �   �  M  � ����        �   �S  M  � ����REVise:   File has been modified... Save changes Discard changes ���� 0n   �� Init&CALL Text 'REVise:' resFile
CALL Show�� Click'@ERASE' workFile
EXIT�� ClickCALL SaveFile
EXIT�� �,0V   V   �  ��          J �  � o � 7 ,��Q          U  �   � 7 -����REVise     ��� 0�U  /* Cut 'n Paste from one .RES file to another using Drag 'n Drop */
/* Written by: David C. Morrill                                  */
/* Date: 01/22/94                                                */
/* (c) Copyright IBM Corporation 1994                            */

DoArgs:
   CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
   CALL SysLoadFuncs
   CRLF = '0D0A'X

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
      END
   logging     = 0
   column      = 1
   dialogs     = 0
   dialogNames = ''
   globals     = ''
   globalProcs = ''
   externals   = ''
   unknown     = ''
   modified    = 0
   dialogMasterItem    = ''
   globalsMasterItem   = ''
   externalsMasterItem = ''
   DO FOREVER
      IF column > length( resData ) THEN LEAVE
      IF substr( resData, column, 1 ) <> 'FF'X THEN DO
         CALL Error resFile 'is not a valid .RES file'
         SIGNAL RETURN
         END
      type   = C2D( reverse( substr( resData, column + 1, 2 ) ) )
      id     = C2D( reverse( substr( resData, column + 4, 2 ) ) )
      len    = C2D( reverse( substr( resData, column + 8, 4 ) ) )
      data   = substr( resData, column, len + 12 )
      column = column + len + 12
      CALL DoResource type, id, data
   END
   column = lastpos( '.', resFile )
   IF column = 0 THEN workFile = resFile'.'
   ELSE workFile = left( resFile, column )
   workFile = SysTempFileName( workFile'???' )
   IF (workFile = '') |,
      (CharOut( workFile, resData ) <> 0) |,
      (Stream( workFile, 'C', 'CLOSE' ) <> 'READY:') THEN DO
      CALL Error 'Could not create temporary file'
      SIGNAL RETURN
      END
   dropFile = translate( workFile, ';', ':' )
   column   = lastpos( '\', resFile )
   IF column = 0 THEN column = pos( ':', resFile )
   masterItem = container.Add( substr( resFile, column + 1 ), 'DRBITMAP:#6' )
   CALL container.Drag masterItem, 'REViseRES='workFile
   IF dialogs > 0 THEN CALL InitDialogs
   DO d = 1 TO dialogs
      id = dialog.d
      IF names.id = '' THEN name = 'D'id
      ELSE DO
         curlen = C2D( substr( names.id, 17, 1 ) )
         IF curlen = 0 THEN name = 'D'id
         ELSE DO
            name = substr( names.id, 18, curlen )
            dialogNames = dialogNames name
            END
         END
      dialogItem.id = container.Add( name, 'DRBITMAP:#1',,
                                     'LAST', dialogMasterItem )
      CALL container.Drag dialogItem.id,,
           'REViseDialog,REViseDialog>'dropFile'='workFile'('id')'
   END
   dialogNames = dialogNames' '
   IF globals <> '' THEN DO
      CALL InitGlobals
      CALL DoProcs
      globalProcs = globalProcs' '
      END
   IF externals <> '' THEN CALL InitExternals
   CALL Add.Drop 'REViseRES,REViseDialog,REViseGlobal,REViseExternal'
   CALL Delete.Drop 'REViseRES>'dropFile',REViseDialog>'dropFile ||,
                    ',REViseGlobal>'dropFile',REViseExternal>'dropFile
   CALL container.View 'Hierarchy'
   CALL container.Show
   CALL Text 'REVise:' resFile
   PARSE VALUE Position() WITH . . dx dy
   PARSE VALUE container.Position() WITH cx cy cdx cdy
   PARSE VALUE add.Position() WITH ax ay adx ady
   CALL Show
   SIGNAL RETURN

DoResource:
   SELECT
     WHEN arg(1) = 3 THEN DO /* Menu */
       id         = arg(2)
       menuRes.id = arg(3)
       END
     WHEN arg(1) = 4 THEN DO /* Dialog */
       id = arg(2)
       CALL DialogAdd id
       dialogRes.id = arg(3)
       END
     WHEN arg(1) = 56320 THEN DO /* Dialog/control names */
       CALL DialogNames arg(3)
       END
     WHEN arg(1) = 56321 THEN DO /* Global procedures code */
       globals = arg(3)
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
     WHEN arg(1) = 56326 THEN DO /* Dialog hint text */
       id      = arg(2)
       hint.id = arg(3)
       END
     OTHERWISE unknown = unknown || arg(3)
   END
   RETURN

DialogAdd:
   temp = arg(1)
   IF symbol( 'dialogRes.temp' ) <> 'VAR' THEN DO
      dialogs        = dialogs + 1
      dialog.dialogs = temp
      dialogRes.temp = ''
      menuRes.temp   = ''
      event.temp     = ''
      class.temp     = ''
      hint.temp      = ''
      menu.temp      = ''
      names.temp     = ''
      END
   RETURN

DialogNames:
   i     = 13
   start = 0
   data  = arg(1)
   DO WHILE i <= length( data )
      IF substr( data, i + 2, 2 ) = '0000'X THEN DO
         IF start <> 0 THEN DO
            temp     = i - start
            names.id = substr( data, 1, 8 ) || reverse( D2C( temp, 4 ) ) ||,
                       substr( data, start, temp )
            END
         id = C2D( reverse( substr( data, i, 2 ) ) )
         CALL DialogAdd id
         start = i
         END
      i = i + C2D( substr( data, i + 4, 1 ) ) + 5
   END
   temp     = i - start
   names.id = substr( data, 1, 8 ) || reverse( D2C( temp, 4 ) ) ||,
              substr( data, start, temp )
   RETURN

DoProcs:
   i = 13
   DO WHILE i < length( globals )
      len  = C2D( substr( globals, i, 1 ) )
      name = substr( globals, i + 1, len )
      i    = i + len + 1
      len  = C2D( substr( globals, i, 1 ) )
      IF len > 127 THEN DO
         i   = i + 1
         len = (len - 128) + 128 * C2D( substr( globals, i, 1 ) )
         IF len > 16317 THEN DO
            i   = i + 2
            len = (len - 16318) + 16318*C2D( reverse( substr(globals, i-1, 2)))
            END
         END
      i = i + len + 1
      globalItem.name = container.Add( name, 'DRBITMAP:#36',,
                                       'LAST', globalsMasterItem )
      CALL container.Drag globalItem.name,,
           'REViseGlobal,REViseGlobal>'dropFile'='workFile'('name')'
      globalProcs = globalProcs name
   END
   RETURN

InitDialogs:
   IF dialogMasterItem = '' THEN DO
      dialogMasterItem = container.Add( 'Dialogs', 'DRBITMAP:#29',,
                                        'LAST', masterItem )
      CALL container.Drag dialogMasterItem,,
           'REViseDialog,REViseDialog>'dropFile'='workFile
      END
   RETURN

InitGlobals:
   IF globalsMasterItem = '' THEN DO
      globalsMasterItem = container.Add( 'Global procedures', 'DRBITMAP:#37',,
                                         'LAST', masterItem )
      CALL container.Drag globalsMasterItem,,
           'REViseGlobal,REViseGlobal>'dropFile'='workFile
      END
   RETURN

InitExternals:
   IF externalsMasterItems = '' THEN DO
      externalsMasterItem = container.Add( 'External procedures',,
                                           'DRBITMAP:#36',, 'LAST', masterItem )
      CALL container.Drag externalsMasterItem,,
           'REViseExternal,REViseExternals>'dropFile'='workFile
      END
   RETURN

DoDropDelete:
   CALL EventData
   PARSE VALUE EventData.1 WITH dropResFile'('dropName')'
   PARSE VALUE EventData.3 WITH type'>'
   SELECT
      WHEN type = 'REViseDialog' THEN DO
        IF dropName <> '' THEN CALL DeleteDialog dropName
        ELSE DO WHILE dialogs > 0
                CALL DeleteDialog dialog.1
             END
        END
      WHEN type = 'REViseGlobal' THEN DO
        IF dropName <> '' THEN CALL DeleteProc dropName
        ELSE DO WHILE globalProcs <> ''
                CALL DeleteProc word( globalProcs, 1 )
             END
        END
      WHEN type = 'REViseExternal' THEN DO
        CALL container.Delete externalsMasterItem
        externalsMasterItem = ''
        externals           = ''
        END
   END
   CALL UpdateFile
   DROP dropResFile dropName
   SIGNAL RETURN

DeleteDialog:
   id = arg(1)
   DROP dialogRes.id menuRes.id menu.id event.id class.id hint.id names.id
   DO j = 1 TO dialogs
      IF id = dialog.j THEN LEAVE
   END
   DO WHILE j < dialogs
      j2 = j + 1
      dialog.j = dialog.j2
      j = j2
   END
   CALL container.Delete dialogItem.id
   DROP dialogItem.id
   dialogs = dialogs - 1
   IF dialogs = 0 THEN DO
      CALL container.Delete dialogMasterItem
      dialogmasterItem = ''
      END
   RETURN

DeleteProc:
   proc = arg(1)
   i    = 13
   CALL container.Delete globalItem.proc
   globalItem.proc = ''
   DO WHILE i < length( globals )
      len  = C2D( substr( globals, i, 1 ) )
      name = substr( globals, i + 1, len )
      i2   = i + len + 1
      len  = C2D( substr( globals, i2, 1 ) )
      IF len > 127 THEN DO
         i2  = i2+ 1
         len = (len - 128) + 128 * C2D( substr( globals, i2, 1 ) )
         IF len > 16317 THEN DO
            i2  = i2 + 2
            len = (len-16318) + 16318*C2D( reverse( substr( globals, i2-1, 2)))
            END
         END
      i2 = i2 + len + 1
      IF proc = name THEN DO
         temp = substr( globals, 13, i - 13 ) || substr( globals, i2 )
         IF length( temp ) <= 1 THEN DO
            CALL container.Delete globalsMasterItem
            globalsMasterItem = ''
            globals           = ''
            globalProcs       = ''
            END
         ELSE DO
            globals = left( globals, 8 ) || reverse( D2C( length(temp), 4 )) ||,
                      temp
            col = pos( ' 'proc' ', globalProcs )
            globalProcs = left( globalProcs, col ) ||,
                          substr( globalProcs, col + length( proc ) + 1 )
            END
         RETURN
         END
      i = i2
   END
   RETURN

DoDropAdd:
   CALL EventData
   PARSE VALUE EventData.1 WITH dropResFile'('dropName')'
   dropResData = CharIn( dropResFile, 1, Chars( dropResFile ) )
   CALL Stream dropResFile, 'C', 'CLOSE'
   IF dropResData = '' THEN DO
      CALL Log 'Could not read' dropResFile
      CALL Beep 1760, 50
      SIGNAL DropAbort
      END
   column        = 1
   dropDialogs   = 0
   dropGlobals   = ''
   dropExternals = ''
   dropUnknown   = ''
   DO FOREVER
      IF column > length( dropResData ) THEN LEAVE
      IF substr( dropResData, column, 1 ) <> 'FF'X THEN DO
         CALL Log dropResFile 'is not a valid .RES file'
         CALL Beep 1760, 50
         SIGNAL DropAbort
         END
      type   = C2D( reverse( substr( dropResData, column + 1, 2 ) ) )
      id     = C2D( reverse( substr( dropResData, column + 4, 2 ) ) )
      len    = C2D( reverse( substr( dropResData, column + 8, 4 ) ) )
      data   = substr( dropResData, column, len + 12 )
      column = column + len + 12
      CALL DoDropResource type, id, data
   END
   SELECT
      WHEN EventData.3 = 'REViseRES' THEN DO
        DO d = 1 TO dropDialogs
           CALL UpdateDialog dropDialog.d
        END
        IF dropGlobals   <> '' THEN CALL UpdateProcs ''
        IF dropExternals <> '' THEN CALL UpdateExternals
        unknown = unknown || dropUnknown
        END
      WHEN EventData.3 = 'REViseDialog' THEN DO
        IF dropName <> '' THEN CALL UpdateDialog dropName
        ELSE DO d = 1 TO dropDialogs
                CALL UpdateDialog dropDialog.d
             END
        END
      WHEN EventData.3 = 'REViseGlobal'   THEN CALL UpdateProcs dropName
      WHEN EventData.3 = 'REViseExternal' THEN CALL UpdateExternals
   END
   CALL UpdateFile
DropAbort:
   DROP dropDialog. dropEvent. dropClass. dropHint. dropMenu. dropNames.
   DROP dropDialogRes. dropMenuRes.
   DROP dropResFile dropResData dropGlobals dropExternals dropUnknown
   SIGNAL RETURN

DoDropResource:
   SELECT
     WHEN arg(1) = 3 THEN DO /* Menu */
       id             = arg(2)
       dropMenuRes.id = arg(3)
       END
     WHEN arg(1) = 4 THEN DO /* Dialog */
       id = arg(2)
       CALL DropDialogAdd id
       dropDialogRes.id = arg(3)
       END
     WHEN arg(1) = 56320 THEN DO /* Dialog/control names */
       CALL DropDialogNames arg(3)
       END
     WHEN arg(1) = 56321 THEN DO /* Global procedures code */
       dropGlobals = arg(3)
       END
     WHEN arg(1) = 56322 THEN DO /* External code */
       dropExternals = arg(3)
       END
     WHEN arg(1) = 56323 THEN DO /* Dialog menu code */
       id          = arg(2)
       dropMenu.id = arg(3)
       END
     WHEN arg(1) = 56324 THEN DO /* Dialog event code */
       id           = arg(2)
       dropEvent.id = arg(3)
       END
     WHEN arg(1) = 56325 THEN DO /* Dialog class code */
       id           = arg(2)
       dropClass.id = arg(3)
       END
     WHEN arg(1) = 56326 THEN DO /* Dialog hint text */
       id          = arg(2)
       dropHint.id = arg(3)
       END
     OTHERWISE dropUnknown = dropUnknown || arg(3)
   END
   RETURN

DropDialogAdd:
   temp = arg(1)
   IF symbol( 'dropDialogRes.temp' ) <> 'VAR' THEN DO
      dropDialogs            = dropDialogs + 1
      dropDialog.dropDialogs = temp
      dropDialogRes.temp     = ''
      dropMenuRes.temp       = ''
      dropEvent.temp         = ''
      dropClass.temp         = ''
      dropHint.temp          = ''
      dropMenu.temp          = ''
      dropNames.temp         = ''
      END
   RETURN

DropDialogNames:
   i     = 13
   start = 0
   data  = arg(1)
   DO WHILE i <= length( data )
      IF substr( data, i + 2, 2 ) = '0000'X THEN DO
         IF start <> 0 THEN DO
            temp         = i - start
            dropNames.id = substr( data, 1, 8 ) || reverse( D2C( temp, 4 ) ) ||,
                           substr( data, start, temp )
            END
         id = C2D( reverse( substr( data, i, 2 ) ) )
         CALL DropDialogAdd id
         start = i
         END
      i = i + C2D( substr( data, i + 4, 1 ) ) + 5
   END
   temp         = i - start
   dropNames.id = substr( data, 1, 8 ) || reverse( D2C( temp, 4 ) ) ||,
                  substr( data, start, temp )
   RETURN

ChangeId:
   IF arg(1) = '' THEN RETURN ''
   RETURN left( arg(1), 4 ) || reverse(D2C( arg(2), 2 )) || substr( arg(1), 7 )

UpdateDialog:
   id     = arg(1)
   newId  = id
   curlen = 0
   IF dropNames.newId = '' THEN name = 'D'newId
   ELSE DO
      curlen = C2D( substr( dropNames.newId, 17, 1 ) )
      IF curlen = 0 THEN name = 'D'newId
      ELSE DO
         name = substr( dropNames.newId, 18, curlen )
         IF pos( ' 'name' ', dialogNames ) <> 0 THEN DO
            DO temp = 2 TO 10000
               IF pos( ' 'name'_'temp' ', dialogNames ) = 0 THEN LEAVE
            END
            CALL Log "Dialog: Changed '"name"' to '"name"_"temp"'"
            name = name'_'temp
            dropNames.newId = left( dropNames.newId, 8 ) ||,
                reverse( D2C(length(dropNames.newId)-12+length(name)-curlen,4)) ||,
                substr( dropNames.newId, 13, 4 ) ||,
                D2C( length( name ), 1 ) || name ||,
                substr( dropNames.newId, 18 + curlen )
            END
         dialogNames = dialogNames || name' '
         END
      END
   IF symbol( 'dialogRes.id' ) = 'VAR' THEN DO
      IF dropNames.id <> '' THEN DO
         temp = 13
         DO WHILE temp <= length( dropNames.id )
            temp2 = C2D( reverse( substr( dropNames.id, temp, 2 ) ) )
            IF newId <= temp2 THEN newId = temp2 + 1
            temp = temp + C2D( substr( dropNames.id, temp + 4, 1 ) ) + 5
         END
         END
      DO FOREVER
         DO temp = 1 TO dialogs
            IF newId = dialog.temp THEN LEAVE
         END
         IF temp > dialogs THEN LEAVE
         newId = newId + 1
      END
      dropDialogRes.id = ChangeId( dropDialogRes.id, newId )
      dropDialogRes.id = left( dropDialogRes.id, 50 ) ||,
                         reverse( D2C( newId, 2 ) )   ||,
                         substr( dropDialogRes.id, 53 )
      dropMenuRes.id   = ChangeId( dropMenuRes.id, newId )
      dropMenu.id      = ChangeId( dropMenu.id,    newId )
      dropEvent.id     = ChangeId( dropEvent.id,   newId )
      dropClass.id     = ChangeId( dropClass.id,   newId )
      dropHint.id      = ChangeId( dropHint.id,    newId )
      IF dropNames.id <> '' THEN
         dropNames.id = left( dropNames.id, 12 )   ||,
                        reverse( D2C( newId, 2 ) ) ||,
                        substr( dropNames.id, 15 )
      IF curlen = 0 THEN name = 'D'newId
      END
   dialogs         = dialogs + 1
   dialog.dialogs  = newId
   dialogRes.newId = dropDialogRes.id
   menuRes.newId   = dropMenuRes.id
   menu.newId      = dropMenu.id
   event.newId     = dropEvent.id
   class.newId     = dropClass.id
   hint.newId      = dropHint.id
   names.newId     = dropNames.id
   CALL InitDialogs
   dialogItem.newId = container.Add( name, 'DRBITMAP:#1',,
                                     'LAST', dialogMasterItem )
   CALL container.Drag dialogItem.newId,,
        'REViseDialog,REViseDialog>'dropFile'='workFile'('newId')'
   IF id <> newId THEN
      CALL Log "Dialog: Changed ID from '"id"' to '"newId"' for '"name"'"
   RETURN

UpdateProcs:
   matchName = arg(1)
   i         = 13
   DO WHILE i < length( dropGlobals )
      len  = C2D( substr( dropGlobals, i, 1 ) )
      name = substr( dropGlobals, i + 1, len )
      i    = i + len + 1
      i2   = i
      len2 = C2D( substr( dropGlobals, i2, 1 ) )
      IF len2 > 127 THEN DO
         i2   = i2 + 1
         len2 = (len2 - 128) + 128 * C2D( substr( dropGlobals, i2, 1 ) )
         IF len2 > 16317 THEN DO
            i2   = i2 + 2
            len2 = (len2 - 16318) +,
                   16318 * C2D( reverse( substr( dropGlobals, i2 - 1, 2 ) ) )
            END
         END
      i2 = i2 + len2 + 1
      IF (matchName = '') | (matchName = name) THEN DO
         body = substr( dropGlobals, i, i2 - i )
         IF pos( ' 'name' ', globalProcs ) <> 0 THEN DO
            DO j = 2 TO 10000
               IF pos( ' 'name'_'j' ', globalProcs ) = 0 THEN LEAVE
            END
            CALL Log "Global: Changed '"name"' to '"name"_"j"'"
            name = name'_'j
            END
         CALL InitGlobals
         globalItem.name = container.Add( name, 'DRBITMAP:#36',,
                                          'LAST', globalsMasterItem )
         CALL container.Drag globalItem.name,,
              'REViseGlobal,REViseGlobal>'dropFile'='workFile'('name')'
         globalProcs = globalProcs || name ''
         IF globals = '' THEN temp = ''
         ELSE temp = substr( globals, 13, length( globals ) - 13 )
         globals = substr( dropGlobals, 1, 8 ) ||,
                           reverse( D2C( length( temp ) + length( name ) +,
                                         length( body ) + 2, 4 )) ||,
                           D2C( length( name ), 1 ) || name || body || temp ||,
                           right( dropGlobals, 1 )
         END
      i = i2
   END
   RETURN

UpdateExternals:
   IF externals = '' THEN DO
      CALL InitExternals
      temp = ''
      END
   ELSE temp = substr( externals, 13 ) || CRLF
   externals = substr( dropExternals, 1, 8 ) ||,
               reverse(D2C( length(temp) + length(dropExternals) - 12, 4 )) ||,
               temp || substr( dropExternalS, 13 )
   RETURN

UpdateFile:
   names = ''
   dlgs  = ''
   DO d = 1 TO dialogs
      id = dialog.d
      IF names.id <> '' THEN names = names || substr( names.id, 13 )
      dlgs = dlgs || dialogRes.id || menuRes.id || menu.id ||,
                     event.id     || class.id   || hint.id
   END
   IF names <> '' THEN
      names = substr( names.id, 1, 8 ) || reverse( D2C( length( names ), 4)) ||,
              names
   '@ERASE' workFile
   CALL CharOut workFile, names || dlgs || globals || externals || unknown
   CALL Stream workFile, 'C', 'CLOSE'
   modified = 1
   RETURN

SaveFile:
   CALL SysGetEA resFile,  '.TYPE', 'TEMP'
   CALL SysPutEA workFile, '.TYPE', temp
   '@COPY' workFile resFile
   '@ERASE' workFile
   RETURN

DoExit:
   IF modified THEN DO
      CALL Save.Open , 'REVise:' resFile
      CALL Save.Focus
      END
   ELSE '@ERASE' workFile
   SIGNAL RETURN

DoSize:
   PARSE VALUE Position() WITH . . ndx ndy
   tdx = ndx - dx
   tdy = ndy - dy
   CALL add.Hide 'N'
   CALL delete.Hide 'N'
   CALL container.Hide 'N'
   CALL add.Position ax, ay, adx + (tdx % 2), ady
   CALL delete.Position ax + adx + (tdx % 2), ay, adx + (tdx % 2), ady
   CALL container.Position cx, cy, cdx + tdx, cdy + tdy
   CALL add.Show
   CALL delete.Show
   CALL container.Show
   SIGNAL RETURN

Log:
   IF \logging THEN DO
      logging = 1
      CALL log.Open
      CALL log.Text 'REVise:' resFile
      CALL log.Show
      END
   CALL log.message.Select log.message.Add( arg(1) ), 'TOP'
   RETURN

Error:
   CALL error.Open , 'REVise Error'
   CALL error.msg.Text arg(1)
   IF DrsAide THEN CALL DrDialog 'Owner', 'error'
   CALL error.Show
   RETURN
