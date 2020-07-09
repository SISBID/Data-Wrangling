## -----------------------------------------------------------------------------
is_package_installed = function(package) {
  requireNamespace(basename(package), quietly = TRUE)
}
if (!is_package_installed("nycflights13")) install.packages("nycflights13")
library(nycflights13)


## -----------------------------------------------------------------------------
pryr::object_size(flights)


## -----------------------------------------------------------------------------
my_flights_db <- src_sqlite("my_flights_db.sqlite3", 
create = TRUE)
flights_sqlite <- copy_to(my_flights_db, 
flights, temporary = FALSE,overwrite = TRUE)


## -----------------------------------------------------------------------------
src_tbls(my_flights_db)
my_flights_db %>% tbl("flights")


## -----------------------------------------------------------------------------
ave_delay = my_flights_db %>%
  tbl("flights") %>%
  filter(carrier == "AA") %>%
  summarise(ave_delay = mean(dep_delay))


## -----------------------------------------------------------------------------
system.time(my_flights_db %>%
  tbl("flights") %>%
  filter(carrier == "AA") %>%
  summarise(ave_delay = mean(dep_delay)))


## -----------------------------------------------------------------------------
ave_delay = my_flights_db %>%
  tbl("flights") %>%
  group_by(carrier) %>%
  summarise(ave_delay = mean(dep_delay))


## -----------------------------------------------------------------------------

### Doesn't work!! No mutate 
#ave_delay = my_flights_db %>%
#  tbl("flights") %>%
#  group_by(carrier) %>%
#  mutate(ave_delay = mean(dep_delay))

ave_delay = my_flights_db %>%
  tbl("flights") %>%
  group_by(carrier) %>%
  summarise(ave_delay = mean(dep_delay)) %>%
  collect()


### Doesn't work! Have to copy it over

# my_flights_db %>%
#  tbl("flights") %>%
#   left_join(ave_delay)


 my_flights_db %>%
  tbl("flights") %>%
   left_join(ave_delay,copy=TRUE)
  

