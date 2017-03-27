module Abstract = Phx_abstract
module Channel = Phx_channel
module Socket = Phx_socket
module Push = Phx_push
module Presence = Phx_presence
open Abstract
(*Constructor functions*)
external initChannel : ?params:Js.Json.t -> ?socket:Socket.t -> Channel.t -> string -> Socket.t = "Channel" [@@bs.send]
external initSocket : ?opts:Js.Json.t -> Socket.t -> string -> Socket.t = "Socket" [@@bs.new]
external initPush : Push.t -> Channel.t -> string -> string -> float -> Push.t = "Push" [@@bs.new]
(*Channel functions*)
external joinChannel : ?timeout:float -> Channel.t -> Push.t = "join" [@@bs.send]
external leaveChannel : ?timeout:float -> Channel.t -> Push.t = "leave" [@@bs.send]
external push : ?timeout:float -> Channel.t -> string -> Js.Json.t -> Push.t = "push" [@@bs.send]
(*Socket functions*)
external disconnectSocket : ?callback:function_ -> ?code:string -> ?reason:any -> Socket.t -> void = "disconnect" [@@bs.send]
external connectSocket : ?params:any -> Socket.t -> void = "connect" [@@bs.send]
external removeChannel : Socket.t -> Channel.t -> void = "remove" [@@bs.send]
external createChannel : ?chanParams:Js.Json.t -> Socket.t -> string -> Channel.t = "channel" [@@bs.send]