open Phx_abstract
type t = <
    (*constructor(endPoint: string, opts?: Object);*)
    (*defined as function*)

    (*protocol(): string;*)
    protocol : string [@bs.get];
    (*endPointURL(): string;*)
    endPointURL : string [@bs.get];

    (*disconnect(callback?: Function, code?: string, reason?: any): void;*)
    (*defined as function since bs doesn't allow method to be curried*)
    (*connect(params?: any): void;*)
    (*defined as function since bs doesn't allow method to be curried*)

    (*log(kind: string, msg: string, data: any): void;*)
    log : string -> string -> any -> void [@bs.meth];

    (*onOpen(callback: Function): void;*)
    onOpen : function_ -> void [@bs.meth];
    (*onClose(callback: Function): void;*)
    onClose : function_ -> void [@bs.meth];
    (*onError(callback: Function): void;*)
    onError : function_ -> void [@bs.meth];
    (*onMessage(callback: Function): void;*)
    onMessage : function_ -> void [@bs.meth];

    (*onConnOpen(): void;*)
    onConnOpen : void [@bs.get];
    (*onConnClose(event: any): void;*)
    onConnClose : any -> void [@bs.meth];
    (*onConnError(error: any): void;*)
    onConnError : any -> void [@bs.meth];

    (*triggerChanError(): void;*)
    triggerChanError : void [@bs.get];

    (*connectionState(): string;*)
    connectionState : string [@bs.get];

    (*isConnected(): boolean;*)
    isConnected : bool [@bs.get];


    (*remove(channel: Channel): void;*)
    remove : Phx_channel.t -> void [@bs.meth];
    (*channel(topic: string, chanParams?: Object): Channel;*)
    (*defined as function since bs doesn't allow method to be curried*)

    (*push(data: any): void;*)
    push : any -> void [@bs.meth];

    (*makeRef(): string;*)
    makeRef : string [@bs.get];
    (*sendHeartbeat(): void;*)
    sendHeartbeat : void [@bs.get];
    (*flushSendBuffer(): void;*)
    flushSendBuffer : void [@bs.get];

    (*onConnMessage(rawMessage: any): void;*)
    onConnMessage : any -> void [@bs.meth];
> Js.t

(*constructor(endPoint: string, opts?: Object);*)
external init : string -> ?opts:('opts Js.t) -> unit -> t =  "Socket" [@@bs.new] [@@bs.module "phoenix"]
let init ?opts:(opts: ('opts Js.t) option) path =
  init path ?opts ()

(* Chris McCord: "The Channel's consturctor is private. You should only create channel instances off the socket's channel/2 function." *)
(*constructor(topic: string, params?: Object, socket?: Socket);*)
external initChannel : string -> ?params:('params Js.t) -> ?socket:t-> unit -> Phx_channel.t =  "Channel" [@@bs.new] [@@bs.module "phoenix"]
let initChannel ?params ?socket topic=
  initChannel topic ?params ?socket ()

(*channel(topic: string, chanParams?: Object): Channel;*)
external channel : t -> string -> ?chanParams:('chanParams Js.t) -> unit -> Phx_channel.t  = "channel" [@@bs.send]
let channel topic ?chanParams socket = channel socket topic ?chanParams ()

(*disconnect(callback?: Function, code?: string, reason?: any): void;*)
external disconnect : t -> ?callback:function_ -> ?code:string -> ?reason:('reason Js.t) -> unit -> void = "disconnect"[@@bs.send]
let disconnect ?callback:(callback: function_ option) ?code:(code: string option) ?reason:(reason: ('reason Js.t) option) socket = let _ =
  disconnect ?callback ?code ?reason socket () in socket

(*connect(params?: any): void;*)
external connect : t -> ?params:('params Js.t) -> unit -> void = "connect" [@@bs.send]
let connect ?params:(params: ('params Js.t) option) socket = let _ = connect ?params socket () in socket