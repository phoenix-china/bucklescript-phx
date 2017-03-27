# BuckleScript Phoenix
BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client.
This is still a work in progress for now.
Feel free to create PRs.

- [X] Connect socket
- [X] Join channel
- [] Push
- [] support both functional style and OO style API (where OCaml/BuckleScript shines)
- [] support [https://github.com/OvermindDL1/bucklescript-tea](BuckleScript-tea) (The Elm Architecture on BuckleScript)

To install
```bash
npm install -save bucklescript-phx
```

Please update your `bsconfig.json` to make `bsb` aware of this dependency
```
"bs-dependencies": [
    "bucklescript-tea"
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
    let _socket = connectSocket socket () in
    initChannel ~socket:socket "user:lobby" ()
let channelJoined = joinChannel channel ()
```
