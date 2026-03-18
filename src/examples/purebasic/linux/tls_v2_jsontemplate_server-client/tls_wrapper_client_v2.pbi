; ============================================================
; tls_v2.pbi - PureBasic FFI wrapper for libtls_v2
; ============================================================

EnableExplicit

CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  #TLSV2_Lib = "libtls_v2.dll"
CompilerElseIf #PB_Compiler_OS = #PB_OS_Linux
  #TLSV2_Lib = "libtls_v2.so"
CompilerElseIf #PB_Compiler_OS = #PB_OS_MacOS
  #TLSV2_Lib = "libtls_v2.dylib"
CompilerEndIf

; ------------------------------------------------------------
; C struct: tlsv2_server_config_t
; ------------------------------------------------------------
Structure tlsv2_server_config_t
  port.i
  cert_file.i              ; const char*
  key_file.i               ; const char*
  on_client_connected.i    ; (*)(int)
  on_client_disconnected.i ; (*)(int)
  on_json_received.i       ; (*)(int, const char*, size_t)
EndStructure

; ------------------------------------------------------------
; Import C functions from libtls_v2
; ------------------------------------------------------------
ImportC #TLSV2_Lib

  ; --- Server API ---
  tlsv2_server_run(*cfg.tlsv2_server_config_t)
  tlsv2_send_json(client_id.i, *json, len.i)

  ; --- Client API ---
  tlsv2_client_init()
  tlsv2_client_connect(host.p-ascii, port.i)
  tlsv2_client_close_fd(sock.i)
  tlsv2_client_send_json(sock.i, *json, len.i)
  tlsv2_client_recv_json(sock.i, *buf, maxlen.i)

EndImport
; IDE Options = PureBasic 6.30 (Linux - x64)
; ExecutableFormat = Console
; CursorPosition = 42
; Folding = -
; EnableXP
; DPIAware