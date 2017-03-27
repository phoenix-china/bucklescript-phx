open Phx_abstract
type onJoinOrLeave = (?key:string -> ?currentPresence:any -> ?newPresence:any -> void)
external syncState : ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> any -> any -> any = "syncState" [@@bs.module "Presence"]
external syncDiff : ?onJoin:onJoinOrLeave -> ?onLeave:onJoinOrLeave -> any -> any -> any = "syncState" [@@bs.module "Presence"]
external list : ?chooser:function_ -> any -> any = "list" [@@bs.module "Presence"]