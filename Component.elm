module Component exposing (..) -- where

import Html exposing (..)
import Html.Events exposing (..)
import WebSocket exposing (..)


type alias Model =
  { msgs : List String
  , error : String}

init : (Model, Cmd Msg)
init =
  (Model [] "", WebSocket.send url "listen" )

-- UPDATE

type Msg
  = Send
  | Receive String


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Send ->
      ( model, WebSocket.send url "listen" )
    Receive msg ->
      ( { model | msgs = msg :: model.msgs }, Cmd.none )


url : String
url = "ws://localhost:5001"

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = listen url Receive

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick (Send) ] [ text "Start" ]
    , viewMsgs model.msgs |> div []
    ]

viewMsgs : List String -> List (Html Msg)
viewMsgs msgs =
  List.map viewMsg msgs

viewMsg : String -> Html Msg
viewMsg msg =
  div [] [ text msg ]
