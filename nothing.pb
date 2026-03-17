;nothing but needed to show pb language to the project

If OpenWindow(0, 200, 200, 300, 200, "Hello Window")
  Repeat
    Event = WaitWindowEvent()
  Until Event = #PB_Event_CloseWindow
EndIf
