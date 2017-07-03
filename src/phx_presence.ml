open Phx_abstract
module Channel = Phx_channel
type meta = Js_json.t

type state = < metas : meta array > Js.Dict.t
type diff = < joins : state; leaves : state > Js.t

type onJoinOrLeave = (?key:string -> ?currentPresence:state -> ?newPresence:state -> unit -> void)

external syncState : state -> state -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "syncState" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let syncState ?onJoin:(on_join: onJoinOrLeave option) ?onLeave:(on_leave: onJoinOrLeave option) currentState newState =
  syncState currentState newState ?onJoin:on_join ?onLeave:on_leave ()


external syncDiff : state -> diff -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "syncDiff" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let syncDiff ?onJoin:(on_join: onJoinOrLeave option) ?onLeave:(on_leave: onJoinOrLeave option) currentState diff =
  syncDiff currentState diff ?onJoin:on_join ?onLeave:on_leave ()


let empty = Js.Dict.empty ()
let a = syncState empty empty

