module websocket_handshake
  use iso_c_binding
  implicit none
contains

  function compute_accept_key(key) result(out)
    character(len=*), intent(in) :: key
    character(len=:), allocatable :: out
    character(len=*), parameter :: guid = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
    character(len=:), allocatable :: sha1bin, b64
    ! You will plug in your SHA1 + Base64 wrappers here

    sha1bin = sha1_hash(key // guid)
    b64 = base64_encode(sha1bin)
    out = b64
  end function

  subroutine websocket_send_handshake(client, key)
    integer, intent(in) :: client
    character(len=*), intent(in) :: key
    character(len=:), allocatable :: accept, response

    accept = compute_accept_key(trim(key))

    response = &
      "HTTP/1.1 101 Switching Protocols" // char(13)//char(10) // &
      "Upgrade: websocket" // char(13)//char(10) // &
      "Connection: Upgrade" // char(13)//char(10) // &
      "Sec-WebSocket-Accept: " // trim(accept) // char(13)//char(10)//char(13)//char(10)

    call tls_send_f(client, response)
  end subroutine

end module
