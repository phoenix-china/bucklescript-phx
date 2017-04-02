open Phx_abstract
module Channel = Phx_channel
type meta = <
    online_at : int [@bs.get];
    phx_ref : string [@bs.get];
> Js.t

type state = < metas : meta array > Js.Dict.t
type diff = < joins : state; leaves : state > Js.t

type onJoinOrLeave = (?key:string -> ?currentPresence:state -> ?newPresence:state -> void)
external syncState : state -> state -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "Presence.syncState" [@@bs.val]
let syncState ?onJoin:(onJoinOrLeave: onJoinOrLeave option) ?onLeave:(onJoinOrLeave: onJoinOrLeave option) currentState newState = syncState currentState newState ()
external syncDiff : state -> diff -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "Presence.syncDiff" [@@bs.val]
let syncDiff ?onJoin:(onJoinOrLeave: onJoinOrLeave option) ?onLeave:(onJoinOrLeave: onJoinOrLeave option) currentState diff = syncDiff currentState diff ()

let empty = Js.Dict.empty ()
let a = syncState empty empty

