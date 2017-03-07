module StringOps


export
intercalate : Foldable t => String -> t String -> String
intercalate                 sep       xs       = intercalateList sep (toList xs) where
  intercalateList : String -> List String -> String
  intercalateList   sep       []          = ""
  intercalateList   sep       (x :: [])   = x
  intercalateList   sep       (x :: ys) = x ++ sep ++ (intercalateList sep ys)
