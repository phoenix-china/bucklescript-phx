open Phx_abstract
type t = <
    (*constructor(topic: string, params?: Object, socket?: Socket);*)
    (*defined as function in Phx_socket duo to circle dependency*)

    (*rejoinUntilConnected(): void;*)
    rejoinUntilConnected : void [@bs.get];

    (*join(timeout?: number): Push;*)
    (*defined as function since bs doesn't allow method to be curried*)
    (*leave(timeout?: number): Push;*)
    (*defined as function since bs doesn't allow method to be curried*)

    (*onClose(callback: Function): void;*)
    onClose : function_ -> void [@bs.meth];
    (*onError(callback: (reason?: any) => void): void;*)
    onError : (any -> void) -> void [@bs.meth];
    (*onMessage(event: string, payload: any, ref: any): any;*)
    onMessage : string -> any -> any -> any [@bs.meth];

    (*on(event: string, callback: (response?: any) => void): void;*)
    on : string -> (any -> void) -> void [@bs.meth];
    (*off(event: string): void;*)
    off : string -> void [@bs.meth];

    (*canPush(): boolean;*)
    canPush : bool [@bs.get];

    (*push(event: string, payload: Object, timeout?: number): Push;*)
    (*defined as function since bs doesn't allow method to be curried*)
> Js.t

(*join(timeout?: number): Push;*)
external join : t -> ?timeout:float -> unit -> Phx_push.t = "join" [@@bs.send]
let join ?timeout:(timeout: float option) channel =
  join channel ?timeout ()

(*leave(timeout?: number): Push;*)
external leave : t -> ?timeout:float -> unit -> Phx_push.t = "leave" [@@bs.send]
let leave ?timeout:(timeout: float option) channel =
  leave channel ?timeout ()

(*constructor(channel: Channel, event: string, payload: any, timeout: number);*)
external initPush : t -> string -> 'payload Js.t -> float -> Phx_push.t = "Push" [@@bs.new] [@@bs.module "phoenix"]
let initPush event payload timeout channel=
  initPush channel event payload timeout

(*push(event: string, payload: Object, timeout?: number): Push;*)
external push : t -> string -> 'payload Js.t -> ?timeout:float -> unit -> Phx_push.t = "push" [@@bs.send]
let push event payload ?timeout channel = push channel event payload ?timeout ()


