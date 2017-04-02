# BuckleScript Phoenix
#### BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client.
#### This is still a work in progress for now.
#### Feel free to create PRs.

- [X] Connect socket
- [X] Join channel
- [X] Push event
- [X] Handle event
- [X] Presence
- [ ] Support The Elm Architecture on BuckleScript ([https://github.com/OvermindDL1/bucklescript-tea](BuckleScript-tea))

To install
```bash
npm install -save bucklescript-phx
```

Please update your `bsconfig.json` to make `bsb` aware of this dependency
```
"bs-dependencies": [
    "bucklescript-phx"
  ]
```

Please add this to you `assets/js/app.js`
```javascript
import {Socket, Channel, Presence} from "phoenix"
global.Socket = Socket
global.Channel = Channel
global.Presence = Presence
```

To join a channel:
```ocaml
open Phoenix

let handleReiceive event any =
  match event with
  | "ok" -> Js.log "Joined"
  | "error" -> Js.log "Failed to join channel"
  | otherEvent -> let _ = Js.log otherEvent in Js.log any

let handleEvent event response =
  let _ = Js.log response in
  ()

let handleSyncState response =
  (*let _ = Js.log response in*)
  (*let _ = Js.log (Array.iter (fun key -> Js.log (Js_dict.unsafeGet response key)) (Js_dict.keys response) ) in*)
  let presences  =  Presence.syncState (Js.Dict.empty ()) response in
  ()

let handleSyncDiff diff =
  let presences  =  Presence.syncDiff (Js.Dict.empty ()) diff in
  let _ = Js.log presences in
  ()

let _ =
  let socket = initSocket "/socket"
               |> connectSocket
               |> putOnClose (fun () -> Js.log "Socket closed") in
  let channel = socket
                |> initChannel "user:lobby" in
  let _ = channel
          |> putOn "from_server" (handleEvent "from:server")
          |> putOnSyncState handleSyncState
          |> putOnsyncDiff handleSyncDiff
          |> joinChannel
          |> putReceive "ok" (handleReiceive "ok")
          |> putReceive "error" (handleReiceive "error") in
  push "new:message" [%bs.obj { user = "It's a user"} ] channel
```
