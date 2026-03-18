; ============================================================
;  PureBasic TLSv2 Server Template
;  Works with tls_wrapper_v2.c (callbacks + JSON framing)
;  No .l used — only .i, .q, .s
; ============================================================

EnableExplicit

XIncludeFile "tls_wrapper_v2.pbi" 

#MAX_JSON = 65536


; ------------------------------------------------------------
; Callback: Client connected
; ------------------------------------------------------------
ProcedureC OnClientConnected(clientID.i)
  Debug ">>> Client connected: " + Str(clientID)
EndProcedure

; ------------------------------------------------------------
; Callback: Client disconnected
; ------------------------------------------------------------
ProcedureC OnClientDisconnected(clientID.i)
  Debug "<<< Client disconnected: " + Str(clientID)
EndProcedure

; ------------------------------------------------------------
; Callback: JSON received
; ------------------------------------------------------------
ProcedureC OnJSONReceived(clientID.i, *json, jsonLen.i)
  Protected msg.s

  msg = PeekS(*json, jsonLen, #PB_UTF8)

  Debug "----------------------------------------"
  Debug "Received JSON from client " + Str(clientID)
  Debug msg

  ; --- Dispatch based on "type" ---
If FindString(msg, #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "text" + #DQUOTE$, 1)
  Debug "-> TEXT message"

  ; Echo back
  Protected replyText.s = "{" + 
                          #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "text" + #DQUOTE$ + "," +
                          #DQUOTE$ + "Data" + #DQUOTE$ + ":" + #DQUOTE$ + "PB server received your text" + #DQUOTE$ +
                          "}"

  tlsv2_send_json(clientID, replyText, StringByteLength(replyText, #PB_UTF8))


ElseIf FindString(msg, #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "command" + #DQUOTE$, 1)
  Debug "-> COMMAND message"

  If FindString(msg, #DQUOTE$ + "cmd" + #DQUOTE$ + ":" + #DQUOTE$ + "PING" + #DQUOTE$, 1)

    Protected pong.s = "{" +
                       #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "command" + #DQUOTE$ + "," +
                       #DQUOTE$ + "cmd"  + #DQUOTE$ + ":" + #DQUOTE$ + "PONG" + #DQUOTE$ +
                       "}"

    tlsv2_send_json(clientID, pong, StringByteLength(pong, #PB_UTF8))
  EndIf


ElseIf FindString(msg, #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "table" + #DQUOTE$, 1)
  Debug "-> TABLE request"

  ; Example: return fake SQLite table
  Protected reply.s = "{" +
                      #DQUOTE$ + "type" + #DQUOTE$ + ":" + #DQUOTE$ + "table" + #DQUOTE$ + "," +
                      #DQUOTE$ + "cmd"  + #DQUOTE$ + ":" + #DQUOTE$ + "SELECT_ALL_RESULT" + #DQUOTE$ + "," +
                      #DQUOTE$ + "data" + #DQUOTE$ + ":{" +
                        #DQUOTE$ + "table"   + #DQUOTE$ + ":" + #DQUOTE$ + "users" + #DQUOTE$ + "," +
                        #DQUOTE$ + "columns" + #DQUOTE$ + ":[" +
                          #DQUOTE$ + "id"   + #DQUOTE$ + "," +
                          #DQUOTE$ + "name" + #DQUOTE$ +
                        "]," +
                        #DQUOTE$ + "rows" + #DQUOTE$ + ":[" +
                          "[1," + #DQUOTE$ + "Alice" + #DQUOTE$ + "]," +
                          "[2," + #DQUOTE$ + "Bob"   + #DQUOTE$ + "]" +
                        "]" +
                      "}" +
                    "}"

  tlsv2_send_json(clientID, reply, StringByteLength(reply, #PB_UTF8))


Else
  Debug "-> UNKNOWN message"
EndIf

EndProcedure


; ------------------------------------------------------------
; Main
; ------------------------------------------------------------
Define cfg.tlsv2_server_config_t

cfg\port = 8001
cfg\cert_file = @"server.pem"
cfg\key_file  = @"server.key"

cfg\on_client_connected    = @OnClientConnected()
cfg\on_client_disconnected = @OnClientDisconnected()
cfg\on_json_received       = @OnJSONReceived()

Debug "Starting TLSv2 server on port " + Str(cfg\port)

; Blocking loop inside C
tlsv2_server_run(cfg)

Debug "Server stopped."
; IDE Options = PureBasic 6.30 (Linux - x64)
; CursorPosition = 114
; FirstLine = 46
; Folding = -
; EnableXP
; DPIAware
; Executable = jsontemplateserver.sh