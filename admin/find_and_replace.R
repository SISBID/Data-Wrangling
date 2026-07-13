#!/bin/bash
#to replace %>% with |> for mac
find . -type f \( -name "*.Rmd" \) -exec sed -i '' 's/%>%/|>/g' {} +