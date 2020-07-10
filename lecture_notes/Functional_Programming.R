## -----------------------------------------------------------------------------
str_split("I.like.strings", ".")
str_split("I.like.strings", fixed("."))


## ----stsplit2-----------------------------------------------------------------
map_chr(y, first) # on the fly
map_chr(y, nth, 2) # on the fly
map_chr(y, last) # on the fly

