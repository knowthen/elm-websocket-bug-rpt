-- module Main exposing (..) --where

import Html exposing (..)
import Html.App as App

import Component as Comp

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { comp : Comp.Model }


init : (Model, Cmd Msg)
init =
  let
    (compModel, compCmd) = Comp.init
  in
    ( Model compModel
    , Cmd.batch
        [ Cmd.map Component compCmd ])

-- UPDATE

type Msg
  = Component Comp.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "Main.update msg: " msg of
    Component compMsg ->
      let
        ( compModel, cmd ) = Comp.update compMsg model.comp
      in
        ( { model | comp = compModel}, Cmd.map Component cmd )




-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map Component (Comp.subscriptions model.comp) ]

-- VIEW

view : Model -> Html Msg
view model =
  div [] [
    h1 [] [ text "Test" ]
  , App.map Component (Comp.view model.comp)
  ]
