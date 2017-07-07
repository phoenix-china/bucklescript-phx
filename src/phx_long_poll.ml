open Phx_abstract
type t = <
(*constructor(endPoint: string);*)
(*defined as function*)

(*normalizeEndpoint(endPoint: string): string;*)
normalizeEndpoint : string -> string [@bs.meth];
(*endpointURL(): string;*)
endpointURL : string [@bs.get];

(*closeAndRetry(): void;*)
closeAndRetry : void [@bs.get];
(*ontimeout(): void;*)
ontimeout : void [@bs.get];

(*poll(): void;*)
poll : void [@bs.get];

(*send(body: any): void;*)
(*defined as function*)
(*close(code?: any, reason?: any): void;*)
(*defined as function*)
> Js.t

(*constructor(endPoint: string);*)
external init : string -> t = "LongPoll" [@@bs.new] [@@bs.module "phoenix"]

(*send(body: any): void;*)
external send : t -> ('body Js.t) -> void = "" [@@bs.send]
(*close(code?: any, reason?: any): void;*)
external close : t -> ?code:('code Js.t) -> ?reason:('reason Js.t) -> void = "" [@@bs.send]