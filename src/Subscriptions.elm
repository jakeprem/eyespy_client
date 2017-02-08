module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import WebSocket

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://localhost:8080" NewMessage