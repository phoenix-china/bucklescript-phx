open Phx_abstract
type t = <
    rejoinUntilConnected : void [@bs.get];
    onClose : function_ -> void [@bs.meth];
    onError : (any -> void) -> void [@bs.meth];
    onMessage : string -> any -> any -> any [@bs.meth];
    on : string -> (any -> void) -> void [@bs.meth];
    off : string -> void [@bs.meth];
    canPush : bool [@bs.get];
> Js.t

