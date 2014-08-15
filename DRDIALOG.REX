!DIALOG ---------------------------------------
Init:      The dialog is being initialized
           after being opened
Exit:      The dialog has been closed
Timer:     A time interval set by the 'Timer'
           function has expired
Move:      The dialog has moved
Size:      The dialog has changed size
Key:       The user has pressed a keyboard key
Notify:    Another program is reporting an event
GetFocus:  The dialog has been given the
           input focus
LoseFocus: The dialog has lost the input
           focus
Any:       An event NOT handled by a control
           specific or class handler has
           occurred
?DIALOG ---------------------------------------
rc       = ~Open(
   [alias]
   [, registeredName]
   ["Modal" | "Nonmodal"] )
result   = ~Frame()
rc       = ~Close()
rc       = ~Timer( [interval] )
oldOwner = ~Owner( [newOwner] )
oldTitle = ~Text( [newTitle] )
oldStyle = ~Style( [newStyle] )
oldFont  = ~Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~ID()
result   = ~Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldState = ~Visible( [newState] )
oldState = ~Enabled( [newState] )
CALL ~Hide ["Update" | "Noupdate"]
CALL ~Show
CALL ~Top
CALL ~Bottom
CALL ~Enable
CALL ~Disable
CALL ~Focus
CALL ~IsDefault ["Object" | "Say"]
CALL ~Controls [stem]
CALL ~Classes [stem]
!PUSHBUTTON -----------------------------------
Click: The user has clicked the pushbutton
Init:  The pushbutton is being initialized
       when the dialog is opened
Drop:  An item has been dropped on the
       pushbutton
?PUSHBUTTON -----------------------------------
oldState = ~$Select( [newState] )
oldLabel = ~$Text( [newLabel] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!CHECKBOX -------------------------------------
Click: The user has clicked the check box
Init:  The check box is being initialized
       when the dialog is opened
Drop:  An item has been dropped on the
       check box
?CHECKBOX -------------------------------------
oldState = ~$Select( [newState] )
oldLabel = ~$Text( [newLabel] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!RADIOBUTTON ----------------------------------
Click: The user has clicked the radio button
Init:  The radio button is being initialized
       when the dialog is opened
Drop:  An item has been dropped on the
       radio button
?RADIOBUTTON ----------------------------------
oldState = ~$Select( [newState] )
oldLabel = ~$Text( [newLabel] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!TEXTBOX --------------------------------------
Init: The text control is being initialized
      when the dialog is opened
Drop: An item has been dropped on the
      text control
?TEXTBOX --------------------------------------
oldText  = ~$Text( [newText] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!LISTBOX --------------------------------------
Enter:     The user has pressed 'Enter' or
           double-clicked on a list box entry
Select:    The user has selected a list box
           entry
Init:      The list box control is being
           initialized when the dialog is
           opened
Scroll:    The list box control has scrolled
           horizontally
GetFocus:  The list box control has been given
           the input focus
LoseFocus: The list box control has lost the
           input focus
Drop:      An item has been dropped on the
           list box control
?LISTBOX --------------------------------------
result = ~$Add(
   item
   [, "Ascending" | "Descending" | "Last" | n]
   [, data] )
rc     = ~$Delete( [index] )
result = ~$Item(
   [index [, "Value" | "Data" ] ] )
oldIndex = ~$Select(
   [newIndex
   [, "Select" | "Unselect" | "Next" | "Top" ] ] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!ENTRYFIELD -----------------------------------
Changed:   The edit control contents have
           changed
Init:      The edit control is being
           initialized when the dialog is
           opened
Scroll:    The edit control has scrolled
           horizontally
GetFocus:  The edit control has been given the
           input focus
LoseFocus: The edit control has lost the input
           focus
Drop:      An item has been dropped on the
           edit control
Overflow:  The edit control has overflowed
?ENTRYFIELD -----------------------------------
result = ~$Select(
   [left [, length] ] )
   [left length] )
result   = ~$Range( length )
oldText  = ~$Text( [newText] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!COMBOBOX -------------------------------------
Enter:       The user has pressed 'Enter' or
             double-clicked on a combo box
             entry
Select:      The user has selected a combo box
             entry
Init:        The combo box control is being
             initialized when the dialog is
             opened
Changed:     The entry field component contents
             have been changed
ScrollEntry: The entry field component has
             scrolled horizontally
ScrollList:  The list box component has been
             scrolled
ShowList:    The list box component has been
             displayed (i.e. has 'dropped down')
Drop:        An item has been dropped on the
             combo box control
?COMBOBOX -------------------------------------
result = ~$Add(
   item
   [, "Ascending" | "Descending" | "Last" | n]
   [, data] )
rc     = ~$Delete( [index] )
result = ~$Item(
   [index [, "Value" | "Data" ] ] )
oldIndex = ~$Select(
   [newIndex
   [, "Select" | "Unselect" | "Next" | "Top" ] ] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!GROUPBOX -------------------------------------
Init: The group box is being initialized
      when the dialog is opened
Drop: An item has been dropped on the
      group box
?GROUPBOX -------------------------------------
oldLabel = ~$Text( [newLabel] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!BITMAP ---------------------------------------
Init: The bitmap control is being initialized
      when the dialog is opened
Drop: An item has been dropped on the bitmap
      control
?BITMAP ---------------------------------------
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!RECTANGLE ------------------------------------
Init: The rectangle control is being
      initialized when the dialog is opened
Drop: An item has been dropped on the
      rectangle control
?RECTANGLE ------------------------------------
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!FRAME ----------------------------------------
Init: The frame control is being initialized
      when the dialog is opened
Drop: An item has been dropped on the
      frame control
?FRAME ----------------------------------------
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!NOTEBOOK -------------------------------------
Select: A notebook page has been selected
Size:   The notebook control has been resized
Delete: A notebook page has been deleted
Init:   The notebook control is being
        initialized when the dialog is opened
Help:   The notebook control has been requested
        to display help
Drop:   An item has been dropped on the
        notebook control
?NOTEBOOK -------------------------------------
result = ~$Add(
   [page]
   [, "First" | "Last" | "Next" | "Previous"]
   [, dialog] [, tab] [, status] [, data] )
rc      = ~$Delete( [page] )
oldPage = ~$Select( [newPage] )
result  = ~$Item(
   [page ]
   [, "Tab" | "Status" | "Data"]
   [, value] ] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!SLIDER ---------------------------------------
Changed:   The slider arm has been released
Changing:  The slider arm position has changed
GetFocus:  The slider control has been given
           the input focus
LoseFocus: The slider control has lost the
           input focus
Init:      The slider control is being
           initialized when the dialog is
           opened
Drop:      An item has been dropped on the
           slider control
?SLIDER ---------------------------------------
result   = ~$Range( ticks1 [, spacing1]
   [ticks2 [, spacing2]] )
oldValue = ~$Item(
   [tick]
   [, "Value" | "Size"]
   [, newValue] )
oldTick  = ~$Select( [newTick] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!VSCROLLBAR -----------------------------------
Changed:  The user has released the scroll bar
          slider
Changing: The user has moved the scroll bar
          slider
LineUp:   The user has clicked on the scroll
          bar up arrow
LineDown: The user has clicked on the scroll
          bar down arrow
PageUp:   The user has clicked on the area
          above the scroll bar slider
PageDown: The user has clicked on the area
          below the scroll bar slider
Done:     The user has finished scrolling (but
          not using the scroll bar slider)
Init:     The scroll bar control is being
          initialized when the dialog is opened
Drop:     An item has been dropped on the
          scroll bar
?VSCROLLBAR -----------------------------------
result   = ~$Range(
   first, last [, visible] )
oldPos   = ~$Select( [newPos] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!HSCROLLBAR -----------------------------------
Changed:   The user has released the scroll bar
           slider
Changing:  The user has moved the scroll bar
           slider
LineLeft:  The user has clicked on the scroll
           bar left arrow
LineRight: The user has clicked on the scroll
           bar right arrow
PageLeft:  The user has clicked on the area to
           the left of the scroll bar slider
PageRight: The user has clicked on the area to
           the right of the scroll bar slider
Done:      The user has finished scrolling (but
           not using the scroll bar slider)
Init:      The scroll bar control is being
           initialized when the dialog is
           opened
Drop:      An item has been dropped on the
           scroll bar
?HSCROLLBAR -----------------------------------
result   = ~$Range(
   first, last [, visible] )
oldPos   = ~$Select( [newPos] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!CANVAS ---------------------------------------
Init: The canvas control is being initialized
      when the dialog is opened
Drop: An item has been dropped on the canvas
      control
?CANVAS ---------------------------------------
oldLabel = ~$Text( [newLabel] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!PAINT ----------------------------------------
Init: The paint control is being initialized
      when the dialog is opened
Drop: An item has been dropped on the paint
      control
?PAINT ----------------------------------------
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!ICONBUTTON -----------------------------------
Click: The user has clicked the bitmap button
Init:  The bitmap button is being initialized
       when the dialog is opened
Drop:  An item has been dropped on the
       bitmap button
?ICONBUTTON -----------------------------------
oldIcon  = ~$Text( [newIcon] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!BAGBUTTON ------------------------------------
Click: The user has clicked the bagbutton
Init:  The bagbutton is being initialized
       when the dialog is opened
Drop:  An item has been dropped on the
       bagbutton
?BAGBUTTON ------------------------------------
oldState = ~$Select( [newState] )
oldLabel = ~$Text( [newLabel] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!MARQUEE --------------------------------------
Init: The marquee control is being initialized
      when the dialog is opened
Drop: An item has been dropped on the marquee
      control
?MARQUEE --------------------------------------
oldText  = ~$Text( [newText] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!TURTLE ---------------------------------------
Init:          The turtle control is being
               initialized when the dialog is
               opened
MouseMove:     The mouse has moved over the
               turtle control
Button1Down:   The user has pressed button 1 over
               the turtle control
Button1Up:     The user has released button 1
Button1DblClk: The user has double-clicked
               button 1 over the turtle control
Button2Down:   The user has pressed button 2 over
               the turtle control
Button2Up:     The user has released button 2
Button2DblClk: The user has double-clicked
               button 2 over the turtle control
Drop:          An item has been dropped on the
               turtle control
?TURTLE ---------------------------------------
oldText  = ~$Text( [newText] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!BILLBOARD ------------------------------------
Init: The billboard control is being
      initialized when the dialog is opened
Drop: An item has been dropped on the
      billboard control
?BILLBOARD ------------------------------------
oldIcon  = ~$Text( [newIcon] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!MLE ------------------------------------------
Changed:   The edit control contents have
           changed
Init:      The edit control is being
           initialized when the dialog is
           opened
GetFocus:  The edit control has been given the
           input focus
LoseFocus: The edit control has lost the input
           focus
Drop:      An item has been dropped on the
           edit control
?MLE ------------------------------------------
oldText  = ~$Text( [newText] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!CONTAINER ------------------------------------
Changed:   A container control item's
           contents have changed
Enter:     The user has pressed 'Enter' or
           double-clicked on a container
           item
Select:    A container item has been selected
ShowMenu:  The user has requested a context-
           sensitive menu (by clicking the
           right mouse button)
Init:      The container control is being
           initialized when the dialog is
           opened
Scroll:    The container control has scrolled
GetFocus:  The container control has been
           given the input focus
LoseFocus: The container control has lost
           the input focus
Drop:      An item has been dropped on the
           container control
?CONTAINER ------------------------------------
item = ~$Add( label [, bitmap]
   [, "First" | "Last" | "Next"] [, item]
   [, data] )
rc = ~$Delete( [item] )
result = ~$Item( [item
   [, "Value" | "Bitmap" | "Data" | column ]
   [, value]] )
result = ~$Select( [item
   [, "[+/-]Select" | "[+/-]Mark" |
      "Cursor"      | "Next"] ] )
oldView  = ~$View(
   ["Bitmap"  | "Name"   | "Flowedname" |
    "Text"    | "Column" | "Detail"     |
    "Outline" | "Hierarchy"]
   [, ["<|>_;"]title]
   [, cxBitmap, cyBitmap]
   [, expandBitmap, collapseBitmap] )
CALL ~$SetStem( [stem]
   [, "[+/-]Select" | "[+/-]Mark" |
      "Format" | 0 | item ] )
CALL ~$GetStem( [stem]
   [, "Select" | "Mark" | "Cursor" | 0 |
      item ] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag(
   item [, newDragData] )
oldDropData = ~$Drop(
   item [, newDropData] )
oldState = ~$Visible( [newState] )
oldState = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!VALUESET -------------------------------------
Enter:     The user has pressed 'Enter' or
           double-clicked on a value set item
Select:    The user has selected a value set
           item
Init:      The value set control is being
           initialized when the dialog is
           opened
GetFocus:  The value set control has been given
           the input focus
LoseFocus: The value set control has lost the
           input focus
Drop:      An item has been dropped on the
           value set control
?VALUESET -------------------------------------
result   = ~$Range( rows, columns )
oldValue = ~$Item(
   [row, column]
   [, newValue] )
rowCol   = ~$Select( [row, column] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!SPINBUTTON -----------------------------------
Changing:  The spin field contents have changed
LineUp:    The up arrow has been pressed or
           clicked
LineDown:  The down arrow has been pressed or
           clicked
GetFocus:  The spin button control has been
           given the input focus
LoseFocus: The spin button control has lost the
           input focus
Done:      The user has released the select
           button or one of the arrow buttons
Init:      The spin button control is being
           initialized when the dialog is
           opened
Drop:      An item has been dropped on the
           spin button control
?SPINBUTTON -----------------------------------
result = ~$Range(
   low, high )
   stem )
oldPos   = ~$Select( [newPos] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!USER -----------------------------------------
Init: The user defined control is being
      initialized when the dialog is opened
Drop: An item has been dropped on the
      user defined control
?USER -----------------------------------------
oldText  = ~$Text( [newText] )
oldStyle = ~$Style( [newStyle] )
oldFont  = ~$Font( [newFont] )
oldColor = ~Color(
   [attribute [, newColor]] )
id       = ~$ID()
result   = ~$Position(
   [x [y [dx [dy] ] ] ] )
   [x [, y [, dx [, dy] ] ] ] )
oldDragData = ~$Drag( [newDragData] )
oldDropData = ~$Drop( [newDropData] )
oldState    = ~$Visible( [newState] )
oldState    = ~$Enabled( [newState] )
CALL ~$Hide ["Update" | "Noupdate"]
CALL ~$Show
CALL ~Top
CALL ~Bottom
CALL ~$Enable
CALL ~$Disable
CALL ~$Focus
CALL ~$IsDefault ["Object" | "Say"]
CALL ~$Controls [stem]
CALL ~$Classes [stem]
!END
