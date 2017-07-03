open Phx_abstract
module Channel = Phx_channel
type meta = Js_json.t

type state = < metas : meta array > Js.Dict.t
type diff = < joins : state; leaves : state > Js.t

type onJoinOrLeave = (?key:string -> ?currentPresence:state -> ?newPresence:state -> unit -> void)

external syncState : state -> state -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "syncState" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let syncState ?onJoin:(onJoin: onJoinOrLeave option) ?onLeave:(onLeave: onJoinOrLeave option) currentState newState =
  syncState currentState newState ?onJoin ?onLeave ()


external syncDiff : state -> diff -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "syncDiff" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let syncDiff ?onJoin:(onJoin: onJoinOrLeave option) ?onLeave:(onLeave: onJoinOrLeave option) currentState diff =
  syncDiff currentState diff ?onJoin ?onLeave ()


let empty = Js.Dict.empty ()
let a = syncState empty empty

