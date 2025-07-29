## Contributing

### Course Administration

For future instructors, the following may be helpful.

A sheet with a checklist for setting up the course and dividing lectures can be found here: https://docs.google.com/spreadsheets/d/1lvcSg16AEw8AROBzd2erRP7hLkT8BbmkAXHT_9b6uVE/edit?usp=sharing 
(ask Carrie Wright or Ava Hoffman if you need access).

### Rendering Notes

Currently all rendering is done manually, we found this easier for this repo as we often make changes right before lecture and rendering the site can take very long, although we usually use GitHub Actions (see https://github.com/jhudsl/intro_to_r). The function `pagedown::chrome_print()` works well for PDFs.

There are also several Google Slide lectures that are on our [Google Drive](https://drive.google.com/drive/folders/1GHfONWXJ_b7LPAFlQhrFSzFi0Dcp-f96). These are added to the index file to update the schedule. Be sure to download the PDF version and upload it to GitHub with the current filename to populate the schedule with the newest version.

Also make sure to rerender the index.Rmd file so that the new PDFs appear on the website.

There is an older script for downloading PDFs in a more automated way. 

### Rendering Documentation

To render **everything** using the `makefile`, including website index page, lectures, and labs, navigate to this top level directory locally and run:

```
make all
```

To render lectures, run:

```
make lectures
```

To render labs, run:

```
make labs
```

To render the website homepage, run:

```
make index.html
```

If you would like to run a "fresh" render, you can delete `index.html` and all HTML files and PDFs associated with lectures and labs. This will not affect materials in `admin/` or `archive/`. Run:

```
make clean
```