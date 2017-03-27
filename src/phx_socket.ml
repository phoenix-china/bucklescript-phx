open Phx_abstract
type t = <
    protocol : string [@bs.get];
    endPointURL : string [@bs.get];
    log : string -> string -> any -> void [@bs.meth];
    onOpen : function_ -> void [@bs.meth];
    onClose : function_ -> void [@bs.meth];
    onError : function_ -> void [@bs.meth];
    onMessage : function_ -> void [@bs.meth];
    onConnOpen : void [@bs.get];
    onConnClose : any -> void [@bs.meth];
    onConnError : any -> void [@bs.meth];
    triggerChanError : void [@bs.get];
    connectionState : string [@bs.get];
    isConnected : bool [@bs.get];
    push : any -> void [@bs.meth];
    makeRef : string [@bs.get];
    sendHeartbeat : void [@bs.get];
    flushSendBuffer : void [@bs.get];
    onConnMessage : any -> void [@bs.meth];
> Js.t
