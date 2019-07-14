# BuckleScript Phoenix
[![NPM](https://nodei.co/npm/bucklescript-phx.png?compact=true)](https://nodei.co/npm/bucklescript-phx/)

[![Build Status](https://travis-ci.org/phoenix-china/bucklescript-phx.svg?branch=master)](https://travis-ci.org/phoenix-china/bucklescript-phx)
#### BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client.
#### This is usable now.
#### Feel free to create PRs.

- [X] Connect socket
- [X] Join channel
- [X] Push event
- [X] Handle event
- [X] Presence
- [ ] Support The Elm Architecture on BuckleScript ([https://github.com/OvermindDL1/bucklescript-tea](BuckleScript-tea))
- [ ] Fallback support for polling.

#### To install
```bash
npm install -save bucklescript-phx
```

#### Please update your `bsconfig.json` to make `bsb` aware of this dependency
```
"bs-dependencies": [
    "bucklescript-phx"
  ]
```
#### Notice:

1. Please add official Phoenix client as your dependency to make sure BuckleScript is able to require Phoenix's js.

2. Meta of Presence and payload of incoming event are decalred as `Js_json.t` which means you need to decode it with your prefered decoder (in TEA it is very convenient with `Json.Decoder.decodeValue`).

3. The bindings are based on [https://github.com/DefinitelyTyped/DefinitelyTyped](DefinitelyTyped). There might be some error on mapping the types. Please help correct them if you find anything wrong. Thank you!

#### Here are the examples:

To join a channel:
```ocaml
open Phx

let handleReiceive event any =
  match event with
  | "ok" -> Js.log ("handleReiceive:" ^ event, "Joined")
  | "error" -> Js.log ("handleReiceive:" ^ event, "Failed to join channel")
  | _ -> Js.log ("handleReiceive:" ^ event, any)

let handleEvent event response =
  let _ = Js.log ("handleEvent:" ^ event, response) in
  ()


let handleSyncState response =
  let _ = Js.log ("handleSyncState", response) in
  (*let _ = Js.log (Array.iter (fun key -> Js.log (Js_dict.unsafeGet response key)) (Js_dict.keys response) ) in*)
  let _presences  =  Presence.syncState (Js.Dict.empty ()) response in
  ()

let handleSyncDiff diff =
  let _ = Js.log ("handleSyncDiff:diff", diff) in
  let presences  =  Presence.syncDiff (Js.Dict.empty ()) diff in
  let _ = Js.log ("handleSyncDiff:presences", presences) in
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
  push "new:message" [%bs.obj { user = "Hello, Elixir! This is a greeting from BuckleScript!"} ] channel
  ```
  
  #### Reasonml:

To join a channel:
```reason
open Phx
  
  let handleReiceive = (event, any) =>
  switch event {
  | "ok" => Js.log(("handleReiceive:" ++ event, "Joined"))
  | "error" => Js.log(("handleReiceive:" ++ event, "Failed to join channel"))
  | _ => Js.log(("handleReiceive:" ++ event, any))
  };

let handleEvent = (event, response) => {
  let _ = Js.log(("handleEvent:" ++ event, response));
  ();
};

let handleSyncState = (response) => {
  let _ = Js.log(("handleSyncState", response));
  /*let _ = Js.log (Array.iter (fun key -> Js.log (Js_dict.unsafeGet response key)) (Js_dict.keys response) ) in*/
  let _presences = Presence.syncState(Js.Dict.empty(), response);
  ();
};

let handleSyncDiff = (diff) => {
  let _ = Js.log(("handleSyncDiff:diff", diff));
  let presences = Presence.syncDiff(Js.Dict.empty(), diff);
  let _ = Js.log(("handleSyncDiff:presences", presences));
  ();
};

{
  let socket = initSocket("/socket") |> connectSocket |> putOnClose(() => Js.log("Socket closed"));
  let channel = socket |> initChannel("user:lobby");
  let _ =
    channel
    |> putOn("from_server", handleEvent("from:server"))
    |> putOnSyncState(handleSyncState)
    |> putOnsyncDiff(handleSyncDiff)
    |> joinChannel
    |> putReceive("ok", handleReiceive("ok"))
    |> putReceive("error", handleReiceive("error"));
  push("new:message", {"user": "Hello, Elixir! This is a greeting from BuckleScript!"}, channel);
};
  
```
