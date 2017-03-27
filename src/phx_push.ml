open Phx_abstract
type t = <
  resend : float -> void [@bs.meth];
  send : void [@bs.get];
  receive : string -> (string -> void) -> t [@bs.meth];
> Js.t

