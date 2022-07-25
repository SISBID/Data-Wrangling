## -----------------------------------------------------------------------------
seps <- read_csv("http://www.mm-c.me/mdsi/hospitals93to98.csv")


## -----------------------------------------------------------------------------
if (interactive()) View(seps)


## -----------------------------------------------------------------------------
seps %>% 
  gather(year,value,FY1993:FY1998)


## -----------------------------------------------------------------------------
seps %>%
  gather(year,value,FY1993:FY1998) %>%
  spread(Field,value)


## -----------------------------------------------------------------------------
seps %>%
  gather(year,value,FY1993:FY1998) %>%
  spread(Field,value) %>%
  separate(col=year,into = c("abb","year"),sep=2)


## -----------------------------------------------------------------------------
seps %>%
  gather(year,value,FY1993:FY1998) %>%
  spread(Field,value) %>%
  separate(col=year,into = c("abb","year"),sep=2) %>%
  unite(newyear,abb,year,sep="-")

