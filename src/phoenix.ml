module Abstract = Phx_abstract
module Channel = Phx_channel
module Socket = Phx_socket
module Push = Phx_push
module Presence = Phx_presence
open Abstract
(*Init functions*)
external initSocket : string -> ?opts:Js.Json.t -> unit -> Socket.t = "Socket" [@@bs.new]
external initChannel : Socket.t -> string -> ?chanParams:Js.Json.t -> unit -> Channel.t  = "channel" [@@bs.send]
(*Channel functions*)
external joinChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "join" [@@bs.send]
external leaveChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "leave" [@@bs.send]
external push : ?timeout:float -> Channel.t -> string -> Js.Json.t -> Push.t = "push" [@@bs.send]
(*Socket functions*)
external disconnectSocket : ?callback:function_ -> ?code:string -> ?reason:any -> Socket.t -> void = "disconnect" [@@bs.send]
external connectSocket : Socket.t -> ?params:any -> unit -> void = "connect" [@@bs.send]
external removeChannel : Socket.t -> Channel.t -> void = "remove" [@@bs.send]
external createChannel : ?chanParams:Js.Json.t -> Socket.t -> string -> Channel.t = "channel" [@@bs.send]