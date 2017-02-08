module View exposing (..)

import Html.Attributes exposing(..)
import Html.Events exposing(..)

import Html exposing (..)
import Messages exposing (Msg(..))
import Models exposing (Model, Colonist)


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