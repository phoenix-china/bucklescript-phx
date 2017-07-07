open Phx_abstract
type t = <
  (*constructor(channel: Channel, event: string, payload: any, timeout: number);*)
  (*defined as function in Phx_channel duo to circle dependency*)

  (*resend(timeout: number): void;*)
  resend : float -> void [@bs.meth];
  (*send(): void;*)
  send : void [@bs.get];

  (*receive(status: string, callback: (response?: any) => void): Push;*)
  receive : string -> (any -> void) -> t [@bs.meth];
> Js.t

