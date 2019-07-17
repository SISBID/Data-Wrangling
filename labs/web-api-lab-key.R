library(rvest)
wwc_url = "https://www.espn.com/soccer/league/_/name/fifa.wwc"


htmlfile = read_html(wwc_url)

nds = html_nodes(htmlfile,                
                 xpath='//*[@id="main-container"]/div/section[2]/article[2]/div/table')
dat = html_table(nds)
dat = as.data.frame(dat)
head(dat)

//*[@id="main-container"]/div/section[2]/article[2]/div/table


