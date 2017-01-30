import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)
import WebSocket

import Messages exposing (Msg(..))
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)



init : (Model, Cmd Msg)
init =
    (Model "" [], Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://localhost:8080" NewMessage


main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }