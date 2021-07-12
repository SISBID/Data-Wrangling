## Github lab for SISBID

### Part 1

Complete this "Getting Started" Guide:
https://guides.github.com/activities/hello-world/
to learn more about using GitHub, specifically making branches

### Part 2

Within RStudio Cloud:

1. Create a new RStudio Cloud project from this Github repo
- First get the URL using the Clone/Download button on Github
- Then create a new project from Git repo on rstudio.cloud
- You may be prompted for your username and password

2. Create a file README.md in this new repo. Check out the `usethis` package, specifically the usethis::use_readme_rmd() function

3. Add, commit, and push this file as described in the class.

4. Look at the url https://github.com/[your-username]/hello-world to confirm the file is there. 

### Part 3

5. Branches are great for development without fear of messing up your main repository files. Create a branch called "code-dir" by 
- naming this branch in the "main" drop down menu and doing a `git pull` followed by `git checkout code-dir`
OR BY
- typing `git checkout -b code-dir` in the RStudio Cloud terminal

6. Create a directory "code" for your analyses.

7. Create a new R Script from the drop down menu in RStudio Cloud. Add some code (perhaps `print("My Git Practice")`). Save it in the new "code" directory.

8. Commit, add and push these changes. Check GitHub (https://github.com/[your-username]/hello-world/tree/code-dir) to confirm your new file structure is in place.

9. Go to https://github.com/[your-username]/hello-world/pulls to create a new pull request - this will help you merge your changes. - Click the green button that says "New pull request"
- From the "compare" drop-down menu, select code-dir
- Click the green "Create pull request" button, leave yourself comments (optional), and click the "Create pull request" again.
- Click "Merge pull request" and "Confirm merge" to finalize your changes in your main branch.

Extra: Find a partner and do this exercise: https://github.com/kbroman/Tools4RR/blob/master/05_Git_Lab/git_lab.md
