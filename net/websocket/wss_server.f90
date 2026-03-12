program wss_server
  use iso_c_binding
  use websocket
  use tls_module
  implicit none

  integer(c_int) :: server, client, rc, n
  character(kind=c_char, len=4096) :: req
  logical :: ok
  character(len=:), allocatable :: msg

  ! Initialize TLS server (no return value)
  call tls_init_server_f()

  ! Listen on port 4433
  server = tls_listen_f(4433_c_int)
  if (server < 0) then
     print *, "Failed to listen on port 4433"
     stop
  end if

  print *, "WSS server listening on port 4433..."

  do
     client = tls_accept_f(server)
     if (client < 0) then
        print *, "Accept failed"
        cycle
     end if

     print *, "Client connected."

     n = tls_recv_f(client, req, len(req))
     if (n <= 0) then
        print *, "Client closed before handshake."
        call tls_close_f(client)
        cycle
     end if

     ok = ws_handle_upgrade(client, req(1:n))
     if (.not. ok) then
        print *, "Not a WebSocket upgrade, closing."
        call tls_close_f(client)
        cycle
     end if

     print *, "WebSocket handshake completed."

     do
        ok = ws_recv_text(client, msg)
        if (.not. ok) then
           print *, "Client closed or error."
           exit
        end if

        print *, "Received: ", trim(msg)
        call ws_send_text(client, "echo: "//trim(msg))
     end do

     call tls_close_f(client)
     print *, "Client disconnected."
  end do

end program wss_server
