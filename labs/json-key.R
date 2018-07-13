github_url = "https://api.github.com/users/hadley/repos"
jsonData <- fromJSON(github_url)
jsonData$stargazers_count
jsonData$open_issues_countdata:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAWElEQVR42mNgGPTAxsZmJsVqQApgmGw1yApwKcQiT7phRBuCzzCSDSHGMKINIeDNmWQlA2IigKJwIssQkHdINgxfmBBtGDEBS3KCxBc7pMQgMYE5c/AXPwAwSX4lV3pTWwAAAABJRU5ErkJggg==


recount_urls = c("http://bowtie-bio.sourceforge.net/recount",
                "http://bowtie-bio.sourceforge.net/recount")

for(i in 1:2){
  htmlfile = read_html(recount_urls[1])
  Sys.sleep(5)
}