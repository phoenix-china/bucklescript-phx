# BuckleScript Phoenix
#### BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client.
#### This is still a work in progress for now.

The basic ideas about underneath binding are: if it doesn't have label argument(usually optional), declare it in module type. Otherwise declare it with `bs.send` or `bs.new`. At the end of the day, both of them will be wrapped with function support pipeing which receive `Socket`, `Channel` or `Push` as the last argument. (Not the first argument because currying direction of OCaml is the oppoiste of Elixir's)
Feel free to create PRs.

- [X] Connect socket
- [X] Join channel
- [X] Push event
- [X] Handle event
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

let handleReiceive event any =
  match event with
  | "ok" -> let _ = Js.log any in Js.log "Joined"
  | "error" -> Js.log "Failed to join channel"
  | otherEvent -> let _ = Js.log otherEvent in Js.log any

let handleEvent event ?response:any = let _ = Js.log any in ()

let _ =
  let socket = initSocket "/socket"
               |> connectSocket
               |> putOnClose (fun () -> Js.log "Socket closed") in
  let channel = socket
                |> initChannel "user:lobby" in
  let _ = channel
          |> putOn "from:server" (handleEvent "from:server")
          |> joinChannel
          |> putReceive "ok" (handleReiceive "ok")
          |> putReceive "error" (handleReiceive "error") in
  push "new:message" [%bs.obj { user = "It's a user"} ] channel

let _ = Js.log {js|Phoenix Channel testing|js}
```
