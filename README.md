# Testing

1. run `npm install`
2. run `node server.js`
3. run `elm reactor`
4. open http://localhost:8000
5. open `Main.elm` app in reactor
6. open Browser Console
7. Click `Start` Button
8. Notice response

```
Main.update msg: : Component Send
Main.elm:3794 Main.update msg: : Component (Receive "Message one")
Main.elm:3794 Main.update msg: : Receive "Message two"
Main.elm:3794 Main.update msg: : Receive "Message three"
Main.elm:3794 Main.update msg: : Receive "Message four"
```
I'm logging in

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "Main.update msg: " msg of
    Component compMsg ->
      let
        ( compModel, cmd ) = Comp.update compMsg model.comp
      in
        ( { model | comp = compModel}, Cmd.map Component cmd )
```

The subscription is initiated in the child `Component.elm` so all logged messages
should be in the form `Main.update msg: : Component (Receive "Message one")` as the first
receive message is, however all subsequent receive messages lose their Component context
