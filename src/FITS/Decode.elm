module FITS.Decode exposing (fits)

import Bytes.Decode as Decode exposing (Decoder)
import FITS exposing (Fits)


fits : Decoder Fits
fits =
    Decode.fail
