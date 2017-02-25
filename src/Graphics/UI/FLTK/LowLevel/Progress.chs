{-# LANGUAGE CPP, ExistentialQuantification, TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses, FlexibleContexts, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Graphics.UI.FLTK.LowLevel.Progress
    (
     -- * Constructor
     progressNew
     -- * Hierarchy
     --
     -- $hierarchy

     -- * Functions
     --
     -- $functions
    )
where
#include "Fl_ExportMacros.h"
#include "Fl_Types.h"
#include "Fl_ProgressC.h"
import C2HS hiding (cFromEnum, cFromBool, cToBool,cToEnum)

import Graphics.UI.FLTK.LowLevel.Fl_Types
import Graphics.UI.FLTK.LowLevel.Utils
import Graphics.UI.FLTK.LowLevel.Hierarchy
import Graphics.UI.FLTK.LowLevel.Dispatch
import qualified Data.Text as T

{# fun Fl_Progress_New as progressNew' { `Int',`Int',`Int',`Int' } -> `Ptr ()' id #}
{# fun Fl_Progress_New_WithLabel as progressNewWithLabel' { `Int',`Int',`Int',`Int', unsafeToCString `T.Text'} -> `Ptr ()' id #}
progressNew :: Rectangle -> Maybe T.Text -> IO (Ref Progress)
progressNew rectangle l'=
    let (x_pos, y_pos, width, height) = fromRectangle rectangle
    in case l' of
        Nothing -> progressNew' x_pos y_pos width height >>=
                             toRef
        Just l -> progressNewWithLabel' x_pos y_pos width height l >>=
                               toRef

{# fun Fl_Progress_Destroy as progressDestroy' { id `Ptr ()' } -> `()' supressWarningAboutRes #}
instance (impl ~ ( IO ())) => Op (Destroy ()) Progress orig impl where
  runOp _ _ win = swapRef win $ \winPtr -> do
    progressDestroy' winPtr
    return nullPtr
{# fun Fl_Progress_set_maximum as setMaximum' { id `Ptr ()',`Float' } -> `()' #}
instance (impl ~ (Float ->  IO ())) => Op (SetMaximum ()) Progress orig impl where
  runOp _ _ progress v = withRef progress $ \progressPtr -> setMaximum' progressPtr v
{# fun Fl_Progress_maximum as maximum' { id `Ptr ()' } -> `Float' #}
instance (impl ~ ( IO (Float))) => Op (GetMaximum ()) Progress orig impl where
  runOp _ _ progress = withRef progress $ \progressPtr -> maximum' progressPtr
{# fun Fl_Progress_set_minimum as setMinimum' { id `Ptr ()',`Float' } -> `()' #}
instance (impl ~ (Float ->  IO ())) => Op (SetMinimum ()) Progress orig impl where
  runOp _ _ progress v = withRef progress $ \progressPtr -> setMinimum' progressPtr v
{# fun Fl_Progress_minimum as minimum' { id `Ptr ()' } -> `Float' #}
instance (impl ~ ( IO (Float))) => Op (GetMinimum ()) Progress orig impl where
  runOp _ _ progress = withRef progress $ \progressPtr -> minimum' progressPtr
{# fun Fl_Progress_set_value as setValue' { id `Ptr ()',`Float' } -> `()' #}
instance (impl ~ (Float ->  IO ())) => Op (SetValue ()) Progress orig impl where
  runOp _ _ progress v = withRef progress $ \progressPtr -> setValue' progressPtr v
{# fun Fl_Progress_value as value' { id `Ptr ()' } -> `Float' #}
instance (impl ~ ( IO (Float))) => Op (GetValue ()) Progress orig impl where
  runOp _ _ progress = withRef progress $ \progressPtr -> value' progressPtr

-- $functions
-- @
--
-- destroy :: 'Ref' 'Progress' -> 'IO' ()
--
-- getMaximum :: 'Ref' 'Progress' -> 'IO' 'Float'
--
-- getMinimum :: 'Ref' 'Progress' -> 'IO' 'Float'
--
-- getValue :: 'Ref' 'Progress' -> 'IO' 'Float'
--
-- setMaximum :: 'Ref' 'Progress' -> 'Float' -> 'IO' ()
--
-- setMinimum :: 'Ref' 'Progress' -> 'Float' -> 'IO' ()
--
-- setValue :: 'Ref' 'Progress' -> 'Float' -> 'IO' ()
-- @

-- $hierarchy
-- @
-- "Graphics.UI.FLTK.LowLevel.Widget"
--  |
--  v
-- "Graphics.UI.FLTK.LowLevel.Progress"
-- @
