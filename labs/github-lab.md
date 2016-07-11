### Github lab for SISBID


1. First we need to set up Git/Github. Here are a good set of instructions:http://stat545.com/git00_index.html. When telling Git your name and email
address you need to run the commands in the shell. You can do this with Tools -> Shell in Rstudio. 

2. Use the approach discussed in class to clone the data sharing repo: https://github.com/jtleek/datasharing

3. Create a new directory File -> New Project -> New Directory -> Empty Project (be sure to click on the link to make it version controlled with git!). 

4. Create a file in the directory called "test.md" and write some stuff in it. 

5. Click on Github menu -> Commit or type `Ctrl + Alt + M`

6. Click next to "test.md", write a comment in the comment box and click "Commit"

7. Go to Github and create a repo with the same name (if you go to https://github.com/yourusername?tab=repositories you should see a big green button to do this). Don't initiate it with a readme. 

8. Open a shell with Tools -> Shell

9. Execute these commands in the same directory:
  - `git remote add origin https://github.com/yourusername/yourdirectoryname.git`
  - `git push -u origin master`
  
10. You are all set up!

11. Try adding another file `test2.md` and write some stuff in it. 

12. Add it by following Steps 5-6, but with `test2.md` to commit. 

13. Now click on the "Push" button in the Rstudio menu. This will push your new file up

14. On https://github.com/yourusername/yourdirectoryname click on the place where it says something like "3 commits". You can see each of the changes you have made. 

15. If you are done and want to go big, find a partner and do this exercise: https://github.com/kbroman/Tools4RR/blob/master/05_Git_Lab/git_lab.md


