# BuckleScript Phoenix
BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client.
This is still a work in progress for now.
Feel free to create PRs.

- [X] Connect socket
- [X] Join channel
- [ ] Push
- [ ] Presence
- [ ] Support both functional style and OO style API (where OCaml/BuckleScript shines)
- [ ] Support [https://github.com/OvermindDL1/bucklescript-tea](BuckleScript-tea) (The Elm Architecture on BuckleScript)

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
let channel = let socket = initSocket "/socket" () in
    let _ = connectSocket socket () in
    initChannel socket "user:lobby" ()
let channelJoinedPush = joinChannel channel ()
let handleReiceive event any =
    match event with
    | "ok" -> Js.log any
    | _ -> Js.log "Failed to join channel"
let _ = channelJoinedPush##receive "ok"  (handleReiceive "ok")
let _ = channelJoinedPush##receive "error"  (handleReiceive "error")
let _ = Js.log {js|Phoenix Channel testing|js}
```
