port module Main exposing (..)

import Html exposing (text)
import Browser
import Html exposing (div)
import Html exposing (h1)
import Html exposing (input)
import Html.Attributes exposing (type_)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value)
import Html exposing (button)
import Html.Events exposing (onClick)
import Json.Decode as D


main : Html.Html msg
main =
    Browser.element {
        init = init,
        update = update,
        view = view,
        subscriptions = subscriptions
    }

-- Ports
port sendMessage : String -> Cmd msg
port messageReceiver: (String -> msg) -> Sub msg

-- Model
type alias Model =
    { draft : String
    , messages  : List String
    }

init : () -> ( Model, Cmd Msg)
init flags = 
    (
        {draft = "", messages = []}
        , Cmd.none
    ) 

-- Update
type Msg
    = DraftChanged String
    | Send
    | Receive String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DraftChanged draft ->
      ( { model | draft = draft }
      , Cmd.none
      )

    Send ->
      ( { model | draft = "" }
      , sendMessage model.draft
      )

    Receive message ->
      ( { model | messages = model.messages ++ [message] }
      , Cmd.none
      )


subscriptions : Model -> Sub Msg
subscriptions model =
    messageReceiver Receive

-- View
view : Model -> Html Msg
view model =
    div []
    [ h1 [] [text "Echo"]
    , ul []
        (List.map(\msg -> li [] [text msg]) model.messages)
    , input
        [ type_ "text"
        , placeholder "Draft"
        , onInput DraftChanged
        , on "keydown" (ifIsEnter Send)
        , value model.draft
        ]
        []
    , button [onClick Send] [text "Send"]
    ]

-- detect Enter
ifIsEnter : msg -> D.Decoder msg
ifIsEnter msg = 
    D.field "key" D.String
    |> D.andThen (\key -> if key == "Enter" then D.succeed msg else D.fail "some other key")