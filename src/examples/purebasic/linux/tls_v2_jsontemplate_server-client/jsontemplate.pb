; ============================================================
;  PureBasic TLSv2 Client Template
;  Works with tls_wrapper_v2.c (blocking client API)
;  No .l used — only .i, .q, .s
; ============================================================

EnableExplicit

XIncludeFile "tls_wrapper_client_v2.pbi"

#MAX_JSON = 65536


; ------------------------------------------------------------
; Helper: Receive JSON (blocking)
; ------------------------------------------------------------
Procedure.s ReceiveJSON(sock.i)
  Protected *ptr = AllocateMemory(#MAX_JSON)
  Protected n.i, msg.s

  If *ptr = 0
    ProcedureReturn ""
  EndIf

  n = tlsv2_client_recv_json(sock, *ptr, #MAX_JSON)
  If n <= 0
    FreeMemory(*ptr)
    ProcedureReturn ""
  EndIf

  msg = PeekS(*ptr, -1, #PB_UTF8)
  FreeMemory(*ptr)

  ProcedureReturn msg
EndProcedure


; ------------------------------------------------------------
; Send TEXT message
; ------------------------------------------------------------
Procedure SendText(sock.i, text.s)
  Protected json.s = "{" +
                     #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "text" + #DQUOTE$ + "," +
                     #DQUOTE$ + "Data" + #DQUOTE$ + ":" + #DQUOTE$ + text + #DQUOTE$ +
                     "}"

  Protected *buf = AllocateMemory(#MAX_JSON)
  PokeS(*buf, json, -1, #PB_UTF8)

  PrintN(">>> Sending TEXT:")
  PrintN(json)

  tlsv2_client_send_json(sock, *buf, StringByteLength(json, #PB_UTF8))
  FreeMemory(*buf)
EndProcedure


; ------------------------------------------------------------
; Send PING command
; ------------------------------------------------------------
Procedure SendPing(sock.i)
  Protected json.s = "{" +
                     #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "command" + #DQUOTE$ + "," +
                     #DQUOTE$ + "cmd"  + #DQUOTE$ + ":" + #DQUOTE$ + "PING" + #DQUOTE$ +
                     "}"

  Protected *buf = AllocateMemory(#MAX_JSON)
  PokeS(*buf, json, -1, #PB_UTF8)

  PrintN(">>> Sending PING")
  PrintN(json)

  tlsv2_client_send_json(sock, *buf, StringByteLength(json, #PB_UTF8))
  FreeMemory(*buf)
EndProcedure


; ------------------------------------------------------------
; Dispatch server reply (same style as your server)
; ------------------------------------------------------------
Procedure HandleServerReply(msg.s)
  PrintN("----------------------------------------")
  PrintN("Received JSON from server:")
  PrintN(msg)

  If FindString(msg, #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "text" + #DQUOTE$, 1)
   PrintN("-> TEXT reply")

  ElseIf FindString(msg, #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "command" + #DQUOTE$, 1)
    PrintN("-> COMMAND reply")

    If FindString(msg, #DQUOTE$ + "cmd" + #DQUOTE$ + ":" + #DQUOTE$ + "PONG" + #DQUOTE$, 1)
      PrintN("-> Received PONG from server")
    EndIf

  Else
    PrintN("-> UNKNOWN reply")
  EndIf
EndProcedure


; ------------------------------------------------------------
; Main
; ------------------------------------------------------------
Debug "Initializing TLSv2 client..."

If tlsv2_client_init() <> 0
  PrintN("ERROR: tlsv2_client_init() failed.")
  End
EndIf

PrintN("Connecting to server...")

Define sock.i = tlsv2_client_connect("127.0.0.1", 8001)
If sock <= 0
  PrintN("ERROR: tlsv2_client_connect() failed: " + Str(sock))
  End
EndIf

Debug "Connected."


; ------------------------------------------------------------
; 1) Send TEXT
; ------------------------------------------------------------
SendText(sock, "Hello from PB client!")
HandleServerReply(ReceiveJSON(sock))


; ------------------------------------------------------------
; 2) Send PING
; ------------------------------------------------------------
SendPing(sock)
HandleServerReply(ReceiveJSON(sock))


; ------------------------------------------------------------
; Close
; ------------------------------------------------------------
tlsv2_client_close_fd(sock)
PrintN("Connection closed.")
; IDE Options = PureBasic 6.30 (Linux - x64)
; CursorPosition = 140
; Folding = -
; EnableXP
; DPIAware
; Executable = client.sh