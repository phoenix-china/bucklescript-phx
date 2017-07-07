open Phx_abstract
module Channel = Phx_channel
type meta = Js_json.t

type state = < metas : meta array > Js.Dict.t
type diff = < joins : state ; leaves : state > Js.t
type key = string

type onJoinOrLeave = (?key:string -> ?currentPresence:state -> ?newPresence:state -> unit -> void)

(*syncState(
      currentState: any,
      newState: any,
      onJoin?: (key?: string, currentPresence?: any, newPresence?: any) => void,
      onLeave?: (key?: string, currentPresence?: any, newPresence?: any) => void
    ): any;*)
external syncState : state -> state -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "syncState" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let syncState ?onJoin ?onLeave currentState newState =
  syncState currentState newState ?onJoin ?onLeave ()


(*syncDiff(
      currentState: any,
      newState: any,
      onJoin?: (key?: string, currentPresence?: any, newPresence?: any) => void,
      onLeave?: (key?: string, currentPresence?: any, newPresence?: any) => void
    ): any;*)
external syncDiff : state -> diff -> ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> unit -> state = "syncDiff" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let syncDiff ?onJoin ?onLeave currentState diff =
  syncDiff currentState diff ?onJoin ?onLeave ()

(*This function doesn't map well*)
type pres = Js.Json.t
type chooser = key -> pres -> pres
(*list(presences: any, chooser?: Function): any;*)
external list : any -> ?chooser:chooser -> unit -> any = "list" [@@bs.scope "Presence"] [@@bs.module "phoenix"]
let list ?chooser presences =
  list presences ?chooser ()

external onState : Channel.t -> string -> (state -> void) -> unit -> void = "on" [@@bs.send]
let onState f channel = let _ = onState channel "presence_state" f () in channel
external onDiff : Channel.t -> string -> (diff -> void) -> unit -> void = "on" [@@bs.send]
let onDiff f channel = let _ = onDiff channel "presence_diff" f () in channel


