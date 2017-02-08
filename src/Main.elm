module Main exposing (..)

import Html exposing (..)

import Models exposing (init)
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions)


main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }