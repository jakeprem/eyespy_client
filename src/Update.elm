module Update exposing (..)

import Messages exposing(Msg(..))
import Models exposing (Model)
import WebSocket


update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} =
    case msg of
        Input newInput ->
            (Model newInput messages, Cmd.none)

        Send ->
            (Model "" messages, WebSocket.send "ws://localhost:8080" input)

        NewMessage str ->
            (Model input (str :: messages), Cmd.none)