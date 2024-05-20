
](https://medium.com/@melvingrooms?source=post_page-----9fbe79a589cd--------------------------------)

## \* prerequisite: GitHub account,Vscode, and Git CLI

Https is a common and secure way to clone a Git repository. One of it’s drawbacks, it may require your username and password in the url. There are ways around it, so let’s talk about using SSH.

SSH to clone a Git repo is a better option. When it comes to best practices. SSH or (secure shell) provides a secure connection from sever to your local machine using key pairs. The keypair consists of a public and a private key. The public key will be stored to your Git repo while the private key is save to a file on your local machine. This will allow the Git repo and your local machine to communicate using ssh. This limits repo access to the machine that generates the key pair, and to whoever is issued a copy of the private key.

Let’s “Git” started.

First you want to create a new repository. Login into you GitHub Account, select new repository and make it private. Give the repo a name, add .gitignore and README.md, create repository.

## **\*Note**: when adding .gitignore select the correct language for the repo, this will insure certain files will not be tracked by GitHub and will not be seen in the repo.

![](https://miro.medium.com/v2/resize:fit:700/1*apiOny3PxVzSLZw7otJT5Q.png)

Open up vscode , select the view tab and open a new terminal. In the terminal switch to the Git Bash shell. Using the CLI we need to create a new directory to store the cloned repo. Change into the new directory. Follow the commands and example below.

```
<span id="cd01" data-selectable-paragraph=""><br><span>mkdir</span> &lt;name-of-directory&gt;<br></span>
```

```
<span id="9aeb" data-selectable-paragraph="">###change directory<br>cd &lt;name-of-directory&gt;</span>
```

![](https://miro.medium.com/v2/resize:fit:700/1*zL4LXMLsoCBUgFIHhHzCNg.png)

To clone the repo via ssh we will need to create a keypair. ssh\_keygen command will generate a public/private rsa key. Using the CLI enter the command below.

```
<span id="e183" data-selectable-paragraph="">ssh-keygen -t rsa -<span>b</span> <span>4096</span></span>
```

After the key pair is generated you will be asked to enter a file to save the key. Note that it creates a default path to where the key is saved if left unchanged. I used the default path for simplicity. Press Enter 3x

![](https://miro.medium.com/v2/resize:fit:700/1*djidCFncsj038K2Vd1QJhw.png)

## **\*Note: For this example we skipped passphrase, but adding passphrase is a best practice as it adds security to your ssh keys.**

Now cd into the directory where the key is saved (in this case .ssh) and use the ls command to list the files in the directory. You will see the id\_rsa and id\_rsa.pub, Using the cat command open the the public key, and copy the text. This will be used in your GitHub account in the next step. Follow the commands and example below.

```
<span id="2765" data-selectable-paragraph=""><br><span>ls</span></span>
```

```
<span id="6a42" data-selectable-paragraph="">###open <span>public</span> <span>key</span> file<br>cat id_rsa.pub</span>
```

![](https://miro.medium.com/v2/resize:fit:700/1*IB9MxEHPJac18SHJITVGkA.png)

Back in GitHub click your profile picture in the top right hand corner, select settings. Under setting select SSH and GPG keys, select ssh and new ssh key. Give the key a name, in the box below key paste in the public key you copied from the step above. click add ssh key.

![](https://miro.medium.com/v2/resize:fit:700/1*OrFl50_dtG53nb4KnKAMAg.png)

Go to the repo you wish to clone and select code, copy the ssh link and return to the terminal in vscode.

![](https://miro.medium.com/v2/resize:fit:621/1*k9d6Xd9UnhpxYHf4jOCxUQ.png)

Using the cd command change to the directory you created to save the cloned repo. Type git clone and paste the link copied from GitHub. When prompted to type yes to continue. Follow the command and example below the repo is now cloned.

```
<span id="94e0" data-selectable-paragraph="">git <span>clone</span> &lt;ssh-link-<span>from</span>-GitHub&gt;</span>
```

![](https://miro.medium.com/v2/resize:fit:700/1*iJbMicqggNhNqN3q1M8qaw.png)

Lastly go to file, open file, and select the file with the name of the cloned repo. All of the contents of the repo are ready to use in vscode.

![](https://miro.medium.com/v2/resize:fit:467/1*zjh8XKb2qwC3eLTXWnA-nA.png)