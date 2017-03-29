open Phx_abstract
type state
type meta
type joinsAndleaves = < joins : string; leaves : string > Js.t
type onJoinOrLeave = (?key:string -> ?currentPresence:state -> ?newPresence:state -> void)

external syncState : state -> state -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "Presence.syncState" [@@bs.val]
let syncState ?onJoin:(onJoinOrLeave: onJoinOrLeave option) ?onLeave:(onJoinOrLeave: onJoinOrLeave option) currentState newState = syncState currentState newState ()
external syncDiff : state -> state -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "Presence.syncDiff" [@@bs.val]
let syncDiff ?onJoin:(onJoinOrLeave: onJoinOrLeave option) ?onLeave:(onJoinOrLeave: onJoinOrLeave option) currentState newState = syncDiff currentState newState ()

(*let empty = Js.Obj.empty ()*)
(*let a = syncState empty empty*)