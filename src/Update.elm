module Update exposing (..)

import Messages exposing(Msg(..))
import Models exposing (Model, Colonist)

import Debug exposing (log)
import Json.Decode as Decode exposing (decodeString, field, map3)
import Exts.List exposing (mergeBy)


-- UPDATE

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
