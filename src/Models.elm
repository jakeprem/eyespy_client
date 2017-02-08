module Models exposing (..)

import Messages exposing (Msg(..))

-- MODEL
type alias Model =
    { colonists : List Colonist
    }

type alias ColonistId =
    String

type alias Colonist =
    { id : ColonistId
    , name : String
    , currentJob : String
    }

init : (Model, Cmd Msg)
init =
    (Model [], Cmd.none)