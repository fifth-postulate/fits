module FITS exposing (DataArray, Fits, HDU, Header, Keyword(..), KeywordRecord, Value(..))


type alias Fits =
    { primary_hdu : HDU }


type alias HDU =
    { header : Header
    , data_array : Maybe DataArray
    }


type alias Header =
    { keyword_records : List KeywordRecord }


type alias KeywordRecord =
    { keyword : Keyword
    , value : Maybe Value
    , comment : Maybe String
    }


type Keyword
    = AV
    | BITPIX
    | CAMPAIGN
    | CHANNEL
    | CHECKSUM
    | CREATOR
    | DATASUM
    | DATA_REL
    | DATE
    | DEC_OBJ
    | EBMINUSV
    | END
    | EQUINOX
    | EXTEND
    | EXTNAME
    | EXTVER
    | FEH
    | FILEVER
    | GCOUNT
    | GKCOLOR
    | GLAT
    | GLON
    | GMAG
    | GRCOLOR
    | HMAG
    | IMAG
    | INSTRUME
    | JKCOLOR
    | JMAG
    | KEPLERID
    | KEPMAG
    | KMAG
    | LOGG
    | MISSION
    | MODULE
    | NAXIS
    | NAXISn Int
    | NEXTEND
    | OBJECT
    | OBSMODE
    | ORIGIN
    | OUTPUT
    | PARALLAX
    | PCOUNT
    | PMDEC
    | PMRA
    | PMTOTAL
    | PROCVER
    | RADESYS
    | RADIUS
    | RA_OBJ
    | RMAG
    | SIMPLE
    | TDIMn Int
    | TDISPn Int
    | TEFF
    | TELESCOP
    | TFIELDS
    | TFORMn Int
    | TIMVERSN
    | THEAP
    | TMINDEX
    | TNULLn Int
    | TSCALn Int
    | TTABLEID
    | TTYPEn Int
    | TUNITn Int
    | TZEROn Int
    | XTENSION
    | ZMAG
    | Unprocessed -- TODO Remove the unprocessed keyword


type Value
    = -- A string enclosed in single quotes `'`.
      CharacterString String
      -- A logical constant signified by either an uppercase `F` or an uppercase `T`.
    | Logical Bool
      -- An optionally signed decimal integer.
    | Integer Int
      -- Fixed format real floating point number.
    | Real Float
      -- Complex number represented by a real and imaginary component.
    | Complex ( Float, Float )
      -- When a value is not present
    | Undefined


type alias DataArray =
    {}
