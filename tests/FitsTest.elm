module FitsTest exposing (suite)

import Bytes.Decode exposing (decode)
import Bytes.Encode exposing (encode)
import Expect
import FITS exposing (Keyword(..), Value(..))
import FITS.Decode as Decode
import FITS.Encode as Encode
import Test exposing (..)


suite : Test
suite =
    describe "module FITS"
        [ describe "decode"
            [ test "hand crafted FITS" <|
                \_ ->
                    let
                        f =
                            { primary_hdu =
                                { header =
                                    { keyword_records =
                                        [ { keyword = SIMPLE
                                          , value = Just <| Logical True
                                          , comment = Nothing
                                          }
                                        ]
                                    }
                                , data_array = Nothing
                                }
                            }

                        data =
                            encode <| Encode.fits f

                        actual =
                            decode Decode.fits data

                        expected =
                            Just f
                    in
                    Expect.equal actual expected
            ]
        ]
