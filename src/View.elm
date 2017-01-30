module View exposing (..)

import Html.Attributes exposing(..)
import Html.Events exposing(..)

import Html exposing (..)
import Messages exposing (Msg(..))
import Models exposing (Model)


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.messages)
    , input [onInput Input] []
    , button [onClick Send] [text "Send"]
    ]


viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]