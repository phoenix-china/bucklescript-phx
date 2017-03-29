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
let leaveChannel ?timeout:(timeout: float option) channel = leaveChannel channel ()

external push : Channel.t -> string -> payloadObject -> ?timeout:float -> unit -> Push.t = "push" [@@bs.send]
let push event object_ ?timeout:(timeout: float option) channel = push channel event object_ ()

let putOn event (f:(?response:any -> void)) channel = let _ = channel##on event f in channel

(*Socket functions*)

external disconnectSocket : Socket.t -> ?callback:function_ -> ?code:string -> ?reason:any -> unit -> void = "disconnect"[@@bs.send]
let disconnectSocket ?callback:(callback: function_ option) ?code:(code: string option) ?reason:(reason: any option) socket = let _ = disconnectSocket socket () in socket

external connectSocket : Socket.t -> ?params:any -> unit -> void = "connect" [@@bs.send]
let connectSocket ?params:(params: any option) socket = let _ = connectSocket socket () in socket

external removeChannel : Socket.t -> Channel.t -> void = "remove" [@@bs.send]
let removeChannel channel socket = removeChannel socket channel

let putOnClose (f:function_) socket = let _ = socket##onClose f in socket

(*Push Functions*)

let putReceive event handleReiceive push= let _ = push##receive event handleReiceive in push

