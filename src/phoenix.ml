module Abstract = Phx_abstract
module Channel = Phx_channel
module Socket = Phx_socket
module Push = Phx_push
module Presence = Phx_presence
open Abstract
(*Init functions*)
external initSocket : string -> ?opts:Js.Json.t -> unit -> Socket.t = "Socket" [@@bs.new]
let initSocket ?opts:(opts: Js.Json.t option) path = initSocket path ()
external initChannel : Socket.t -> string -> ?chanParams:Js.Json.t -> unit -> Channel.t  = "channel" [@@bs.send]
let initChannel topic socket = initChannel socket topic ()
(*Channel functions*)
external joinChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "join" [@@bs.send]
let joinChannel ?timeout:(timeout: float option) channel = joinChannel channel ()
external leaveChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "leave" [@@bs.send]
external push : Channel.t -> string -> object_ -> ?timeout:float -> unit -> Push.t = "push" [@@bs.send]
let putOn event (f:(?response:any -> void)) channel = let _ = channel##on event f in channel
(*Socket functions*)
external disconnectSocket : Socket.t -> ?callback:function_ -> ?code:string -> ?reason:any -> unit -> void = "disconnect" [@@bs.send]
external connectSocket : Socket.t -> ?params:any -> unit -> void = "connect" [@@bs.send]
let connectSocket ?params:(params: any option) socket = let _ = connectSocket socket () in socket
external removeChannel : Socket.t -> Channel.t -> void = "remove" [@@bs.send]
external createChannel : Socket.t -> string -> ?chanParams:Js.Json.t -> unit -> Channel.t = "channel" [@@bs.send]
let putOnClose (f:function_) socket = let _ = socket##onClose f in socket
(*Push Functions*)
let putReceive event handleReiceive push= let _ = push##receive event handleReiceive in push