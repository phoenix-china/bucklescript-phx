module Abstract = Phx_abstract
module Channel = Phx_channel
module Socket = Phx_socket
module Push = Phx_push
module Presence = Phx_presence
open Abstract
(*Init functions*)

external initSocket : string -> ?opts:('opts Js.t) -> unit -> Socket.t =  "Socket" [@@bs.new] [@@bs.module "phoenix"]
let initSocket ?opts:(opts: ('opts Js.t) option) path =
  initSocket path ?opts:opts ()

external initChannel : Socket.t -> string -> ?chanParams:('chanParams Js.t) -> unit -> Channel.t  = "channel" [@@bs.send]
let initChannel topic ?chanParams:(chanParams: ('chanParams Js.t) option) socket = initChannel socket topic ?chanParams:chanParams ()

(*Channel functions*)

external joinChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "join" [@@bs.send]
let joinChannel ?timeout:(timeout: float option) channel =
  joinChannel channel ?timeout:timeout ()

external leaveChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "leave" [@@bs.send]
let leaveChannel ?timeout:(timeout: float option) channel =
  leaveChannel channel ?timeout:timeout ()


external push : Channel.t -> string -> payloadObject -> ?timeout:float -> unit -> Push.t = "push" [@@bs.send]
let push event object_ ?timeout:(timeout: float option) channel =
   push channel event object_ ?timeout:timeout ()

let putOn event (f:(any -> void )) channel = let _ = channel##on event f in channel

(*Socket functions*)

external disconnectSocket : Socket.t -> ?callback:function_ -> ?code:string -> ?reason:('reason Js.t) -> unit -> void = "disconnect"[@@bs.send]
let disconnectSocket ?callback:(callback: function_ option) ?code:(code: string option) ?reason:(reason: ('reason Js.t) option) socket = let _ =
  disconnectSocket ?callback:callback ?code:code ?reason:reason socket () in socket

external connectSocket : Socket.t -> ?params:('params Js.t) -> unit -> void = "connect" [@@bs.send]
let connectSocket ?params:(params: ('params Js.t) option) socket = let _ = connectSocket ?params:params socket () in socket

external removeChannel : Socket.t -> Channel.t -> void = "remove" [@@bs.send]
let removeChannel channel socket = removeChannel socket channel

let putOnClose (f:function_) socket = let _ = socket##onClose f in socket

(*Push Functions*)

let putReceive event handleReiceive push= let _ = push##receive event handleReiceive in push

(*Presence Functions*)
external putOnSyncState : Channel.t -> string -> (Presence.state -> void) -> unit -> void = "on" [@@bs.send]
let putOnSyncState f channel = let _ = putOnSyncState channel "presence_state" f () in channel
external putOnsyncDiff : Channel.t -> string -> (Presence.diff -> void) -> unit -> void = "on" [@@bs.send]
let putOnsyncDiff f channel = let _ = putOnsyncDiff channel "presence_diff" f () in channel
