type state =
 | LOADING
 | ERROR
 | LOADED(string)

type action =
 | FETCHCHANNEL
 | WEBSOCKET(string)
 | FAILEDTOFETCH

type webSocket = {
  id: string
}

module Decode = {
   let ws = (webSocket) => Json.Decode.{
     id: webSocket |> field("id", string)
     }
    };

    let reducer = (action, _state) =>
      switch(action) {
      | FETCHCHANNEL => ReasonReact.UpdateWithSideEffects(
      LOADING,
      (
      self =>
      Js.Promise.(

      Fetch.fetchWithInit(
              "/",
               Fetch.RequestInit.make(
                ~method_=Post,
                ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
                ()
              )
            )
      |> then_(Fetch.Response.json)
      |> then_(json => json
        |> Decode.ws
        |> (webSocket => self.send(WEBSOCKET(webSocket.id)))
        |> resolve)
      |> catch(_err => Js.Promise.resolve(self.send(FAILEDTOFETCH)))
      |> ignore
      )
      ),
      )
      | FETCHEDWS(id) => ReasonReact.Update(LOADED(id))
      | FAILEDTOFETCH => ReasonReact.Update(ERROR)

     };

let component = ReasonReact.reducerComponent("App");

let make = _children => {
  ...component,
  initialState: () => LOADING,
  reducer,
  didMount: self => {
  self.send(FETCHCHANNEL),
  render: (self) =>
  switch(self.state){
  | ERROR => <div> ( ReasonReact.string("An Error Occured !!") ) </div>
  | LOADING => <div className=Styles.app>
               <div> ( ReasonReact.string("Loading... ") ) </div>
               </div>
  | LOADED(id) => <div className=Styles.app>
                         <div> ( ReasonReact.string("Loaded") ) </div>
                      </div>
  }
};