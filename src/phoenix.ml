module Abstract = Phx_abstract
module Channel = Phx_channel
module Socket = Phx_socket
module Push = Phx_push
module Presence = Phx_presence
open Abstract
(*Constructor functions*)
external initSocket : string -> ?opts:Js.Json.t -> unit -> Socket.t = "Socket" [@@bs.new]
external initChannel : string -> ?params:Js.Json.t -> ?socket:Socket.t -> unit -> Channel.t  = "Channel" [@@bs.new]
(*Channel functions*)
external joinChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "join" [@@bs.send]
external leaveChannel : Channel.t -> ?timeout:float -> unit -> Push.t = "leave" [@@bs.send]
external push : ?timeout:float -> Channel.t -> string -> Js.Json.t -> Push.t = "push" [@@bs.send]
(*Socket functions*)
external disconnectSocket : ?callback:function_ -> ?code:string -> ?reason:any -> Socket.t -> void = "disconnect" [@@bs.send]
external connectSocket : Socket.t -> ?params:any -> unit -> void = "connect" [@@bs.send]
external removeChannel : Socket.t -> Channel.t -> void = "remove" [@@bs.send]
external createChannel : ?chanParams:Js.Json.t -> Socket.t -> string -> Channel.t = "channel" [@@bs.send]