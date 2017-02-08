import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)
import WebSocket

import Debug exposing (log)
import Json.Decode as Decode exposing (decodeString, field, map3)
import Exts.List exposing (mergeBy)

main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

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


-- UPDATE

type Msg
    = NewMessage String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NewMessage str ->
            let
                updatedColonists =
                    mergeColonists str model.colonists
            in
                ( { model | colonists = updatedColonists }, Cmd.none)

mergeColonists : String -> List Colonist -> List Colonist
mergeColonists rawJson colonists =
    Exts.List.mergeBy .id colonists (stringToColonists rawJson) 

stringToColonists : String -> List Colonist
stringToColonists rawJson =
    case decodeString collectionDecoder rawJson of
        Err msg ->
            Debug.log msg
            []

        Ok colonists ->
            colonists

--DECODERS
collectionDecoder : Decode.Decoder (List Colonist)
collectionDecoder =
    (field "colonists" (Decode.list colonistDecoder))


colonistDecoder : Decode.Decoder Colonist
colonistDecoder =
    Decode.map3 Colonist
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "job" Decode.string)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://localhost:8080" NewMessage

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] [(viewColonists model.colonists)]
    ]


viewColonists : List Colonist -> Html Msg
viewColonists colonists =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Name"]
                    , th [] [ text "Job" ]
                    ]
                ]
            , tbody [] (List.map colonistRow colonists)
            ]
        ]

colonistRow : Colonist -> Html Msg
colonistRow colonist =
    tr []
        [ td [] [ text colonist.name ]
        , td [] [ text colonist.currentJob ]
        ]