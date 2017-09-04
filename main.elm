{- This file re-implements the Elm Counter example (1 counter) with elm-mdl
   buttons. Use this as a starting point for using elm-mdl components in your own
   app.
-}


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Options as Options
import Material.Scheme
import Material.Textfield as Textfield
import Material.Typography as Typo


-- MODEL


type alias Model =
    { content : String
    , mdl :
        Material.Model

    -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { content = ""
    , mdl =
        Material.model

    -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE


type Msg
    = Change String
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newContent ->
            ( { model | content = newContent }
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model


replace : String -> String -> String -> String
replace from to str =
    String.split from str
        |> String.join to



-- VIEW


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    viewTextfieldBoxes model
        |> Material.Scheme.top


viewTextfieldBoxes : Model -> Html Msg
viewTextfieldBoxes model =
    div
        [ style
            [ ( "margin", "auto" )
            , ( "width", "50%" )
            , ( "padding", "2em" )
            ]
        ]
        [ Options.styled p
            [ Typo.display3
            , Typo.center
            , Options.css "color" "#60B5CC"
            , Options.css "margin-top" "10%"
            ]
            [ text "CLAP 👏 EMOJI 👏 GENERATOR" ]
        , Options.styled p
            [ Typo.subhead
            , Typo.center
            ]
            [ text "Don't 👏 stop 👏 emphasizing 👏 your 👏 point 👏 by 👏 putting 👏 clap 👏 emojis 👏 after 👏 every 👏 word" ]
        , Options.styled p
            [ Typo.caption
            , Typo.center
            , Options.css "margin-top" "2%"
            ]
            [ text "Inspired by "
            , a [ href "https://github.com/mburakerman/clapemojigenerator", rel "external", target "_blank" ]
                [ text "@mburakerman" ]
            ]
        , Textfield.render Mdl
            [ 9 ]
            model.mdl
            [ Textfield.label "Type or paste your text here..."
            , Textfield.floatingLabel
            , Textfield.textarea
            , Textfield.rows 6
            , Options.onInput Change
            , Options.css "margin" "6%"
            ]
            []
        , Textfield.render Mdl
            [ 9 ]
            model.mdl
            [ Textfield.label "👏 Output 👏"
            , Textfield.floatingLabel
            , Textfield.textarea
            , Textfield.rows 6
            , Textfield.value (replace " " " 👏 " model.content)
            , Options.css "margin" "6%"
            ]
            []
        , Options.styled p
            [ Typo.body1
            , Typo.center
            , Options.css "margin-top" "5%"
            ]
            [ text "© Made with ♥ and Elm by "
            , a [ href "https://twitter.com/alejandroRINC0N", rel "external", target "_blank" ]
                [ text "@alejandroRINC0N" ]
            ]
        ]



-- Load Google Mdl CSS. You'll likely want to do that not in code as we
-- do here, but rather in your master .html file. See the documentation
-- for the `Material` module for details.


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
