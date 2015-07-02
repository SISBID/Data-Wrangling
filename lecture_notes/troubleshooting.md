## Troubleshooting on windows:

### If `Sys.getenv("HOME")` returns an empty string, HOME isn't set.

Open a command prompt and type the following:

    setx HOME %USERPROFILE%
    
Then restart the R session. The home should now be `C:\\Users\\<username>`.

### If `CreateConnection` gives an Error 401: Unauthorized

Check that the _netrc file has no typo.  
Check that the file has the right name:
 
    list.files(Sys.getenv("HOME"))

If it returns "_netrc.txt" then open the file with notepad and use `Save as` with
the name `"_netrc"` (include quotes).