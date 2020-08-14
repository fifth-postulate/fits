module FITS.Encode exposing (fits)

import Bytes.Encode as Encode exposing (Encoder)
import Debug
import FITS exposing (Fits, HDU, Header, Keyword(..), KeywordRecord, Value(..))
import String exposing (fromFloat)


fits : Fits -> Encoder
fits f =
    Encode.sequence
        [ primary_hdu f.primary_hdu
        ]


primary_hdu : HDU -> Encoder
primary_hdu hdu =
    Encode.sequence
        [ header hdu.header
        ]


header : Header -> Encoder
header =
    Encode.sequence << List.map keyword_record << .keyword_records


keyword_record : KeywordRecord -> Encoder
keyword_record record =
    [ keyword record.keyword
    , Maybe.map value record.value |> Maybe.withDefault ""
    , Maybe.map comment record.comment |> Maybe.withDefault ""
    ]
        |> String.join ""
        |> String.padRight 80 ' '
        |> String.left 80
        |> Encode.string


keyword : Keyword -> String
keyword k =
    let
        word =
            case k of
                AV ->
                    "AV"

                BITPIX ->
                    "BITPIX"

                CAMPAIGN ->
                    "CAMPAIGN"

                CHANNEL ->
                    "CHANNEL"

                CHECKSUM ->
                    "CHECKSUM"

                CREATOR ->
                    "CREATOR"

                DATASUM ->
                    "DATASUM"

                DATA_REL ->
                    "DATA_REL"

                DATE ->
                    "DATE"

                DEC_OBJ ->
                    "DEC_OBJ"

                EBMINUSV ->
                    "EBMINUSV"

                END ->
                    "END"

                EQUINOX ->
                    "EQUINOX"

                EXTEND ->
                    "EXTEND"

                EXTNAME ->
                    "EXTNAME"

                EXTVER ->
                    "EXTVER"

                FEH ->
                    "FEH"

                FILEVER ->
                    "FILEVER"

                GCOUNT ->
                    "GCOUNT"

                GKCOLOR ->
                    "GKCOLOR"

                GLAT ->
                    "GLAT"

                GLON ->
                    "GLON"

                GMAG ->
                    "GMAG"

                GRCOLOR ->
                    "GRCOLOR"

                HMAG ->
                    "HMAG"

                IMAG ->
                    "IMAG"

                INSTRUME ->
                    "INSTRUME"

                JKCOLOR ->
                    "JKCOLOR"

                JMAG ->
                    "JMAG"

                KEPLERID ->
                    "KEPLERID"

                KEPMAG ->
                    "KEPMAG"

                KMAG ->
                    "KMAG"

                LOGG ->
                    "LOGG"

                MISSION ->
                    "MISSION"

                MODULE ->
                    "MODULE"

                NAXIS ->
                    "NAXIS"

                NAXISn n ->
                    "NAXIS" ++ String.fromInt n

                NEXTEND ->
                    "NEXTEND"

                OBJECT ->
                    "OBJECT"

                OBSMODE ->
                    "OBSMODE"

                ORIGIN ->
                    "ORIGIN"

                OUTPUT ->
                    "OUTPUT"

                PARALLAX ->
                    "PARALLAX"

                PCOUNT ->
                    "PCOUNT"

                PMDEC ->
                    "PMDEC"

                PMRA ->
                    "PMRA"

                PMTOTAL ->
                    "PMTOTAL"

                PROCVER ->
                    "PROCVER"

                RADESYS ->
                    "RADESYS"

                RADIUS ->
                    "RADIUS"

                RA_OBJ ->
                    "RA_OBJ"

                RMAG ->
                    "RMAG"

                SIMPLE ->
                    "SIMPLE"

                TDIMn n ->
                    "TDIM" ++ String.fromInt n

                TDISPn n ->
                    "TDISP" ++ String.fromInt n

                TEFF ->
                    "TEFF"

                TELESCOP ->
                    "TELESCOP"

                TFIELDS ->
                    "TFIELDS"

                TFORMn n ->
                    "TFORM" ++ String.fromInt n

                TIMVERSN ->
                    "TIMVERSN"

                THEAP ->
                    "THEAP"

                TMINDEX ->
                    "TMINDEX"

                TNULLn n ->
                    "TNULL" ++ String.fromInt n

                TSCALn n ->
                    "TSCAL" ++ String.fromInt n

                TTABLEID ->
                    "TTABLEID"

                TTYPEn n ->
                    "TTYPE" ++ String.fromInt n

                TUNITn n ->
                    "TUNIT" ++ String.fromInt n

                TZEROn n ->
                    "TZERO" ++ String.fromInt n

                XTENSION ->
                    "XTENSION"

                ZMAG ->
                    "ZMAG"

                Unprocessed ->
                    Debug.todo "remove Unprocessed"
    in
    String.padRight 8 ' ' word


value : Value -> String
value v =
    let
        w =
            case v of
                CharacterString s ->
                    s

                Logical b ->
                    if b then
                        "T"

                    else
                        "F"

                Integer n ->
                    String.fromInt n

                Real f ->
                    String.fromFloat f

                Complex ( r, i ) ->
                    [ r, i ]
                        |> List.map String.fromFloat
                        |> String.join ","
                        |> surround "(" ")"

                Undefined ->
                    ""
    in
    "= " ++ w


comment : String -> String
comment c =
    "/ " ++ c


surround : String -> String -> String -> String
surround left right target =
    left ++ target ++ right
