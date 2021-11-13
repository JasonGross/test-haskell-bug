{-# OPTIONS_GHC -cpp -XMagicHash -XNoPolyKinds #-}
{- For Hugs, use the option -F"cpp -P -traditional" -}

module Main where

import qualified Prelude

#ifdef __GLASGOW_HASKELL__
import qualified GHC.Base
#else
-- HUGS
import qualified IOExts
#endif

#ifdef __GLASGOW_HASKELL__
type Any = GHC.Base.Any
#else
-- HUGS
type Any = ()
#endif

data Type base_type =
   Base base_type
 | Arrow (Type base_type) (Type base_type)

type Interp base_type base_interp = Any

data Type0 base_type =
   Type_base base_type
 | Prod (Type0 base_type) (Type0 base_type)
 | List (Type0 base_type)
 | Option (Type0 base_type)
 | Unit

type Interp0 base base_interp = Any

type ExprInfoT =
  (Type (Type0 Any)) -> Any -> Interp (Type0 Any) (Interp0 Any Any)
  -- singleton inductive, whose constructor was Build_ExprInfoT

type Base0 = Any

type Ident = Any

type Base_interp = Any

ident_interp :: ExprInfoT -> (Type (Type0 Base0)) -> Ident -> Interp (Type0 Base0) (Interp0 Base0 Base_interp)
ident_interp exprInfoT =
  exprInfoT

seq :: a1 -> a2 -> a2
seq _ y =
  y

main :: GHC.Base.IO ()
main =
  seq ident_interp (GHC.Base.return ())
