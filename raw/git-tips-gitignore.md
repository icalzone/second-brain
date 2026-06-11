https://stackoverflow.com/questions/9750606/git-still-shows-files-as-modified-after-adding-to-gitignore

Questions: git still shows files as modified after adding to .gitignore

Your .gitignore is working, but it still tracks the files because they were already in the index.

To stop this you have to do : git rm -r --cached .idea/

When you commit the .idea/ directory will be removed from your git repository and the following commits will ignore the .idea/ directory.

PS: You could use .idea/ instead of .idea/* to ignore a directory. You can find more info about the patterns on the .gitignore man page.

Helpful quote from the git-rm man page

--cached
    Use this option to unstage and remove paths only from the index. 
    Working tree files, whether modified or not, will be left alone.


187

To the people who might be searching for this issue still, are looking at this page only.

This will help you remove cached index files, and then only add the ones you need, including changes to your .gitignore file.

1. git rm -r --cached .
2. git add .
3. git commit -m 'Removing ignored files'
Here is a little bit more info.

This command will remove all cached files from index.
This command will add all files except those which are mentioned in gitignore.
This command will commit your files again and remove the files you want git to ignore, but keep them in your local directory.