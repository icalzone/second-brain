---
id: 4620625f-ffa7-4283-8aee-3228a02dc9f7
title: Set up and Use Winget on Windows 11 - Easy Steps
tags:
  - save-dev
date_saved: 2024-05-06 08:11:22
date_published: 2024-02-24 03:05:07
---

## Metadata
- Author: [[]]
- Title: [Set up and Use Winget on Windows 11 - Easy Steps]
- URL: [(https://orcacore.com/set-up-use-winget-windows11/]


## Entire Post
![Set up and Use Winget on Windows 11 - orcacore.com](https://proxy-prod.omnivore-image-cache.app/768x576,s5Rqv5c3TACGCjGe_sZZ9us6BGsjS1IBsR-qk-fq7Nog/https://orcacore.com/wp-content/uploads/2024/02/use-winget-windows11-768x576.webp)

This guide intends to teach you to **Set up and Use Winget on Windows 11**. Winget in Windows 11 is a command-line package manager that is used for installing, updating, and managing software applications. With Winget, users can quickly install multiple applications without the need to visit individual websites or rely on third-party package managers. It also ensures that installed applications are up to date by enabling easy updates through the command line interface.

Now follow the steps below to set up and use Winget on Windows 11.

* [Steps To Set up and Use Winget on Windows 11](#steps-to-set-up-and-use-winget-on-windows-11)
* [Step 1 - Check Winget Status on Windows 11](#step-1-check-winget-status-on-windows-11)
* [Step 2 - Install Winget Tool on Windows 11](#step-2-install-winget-tool-on-windows-11)
* [Step 3 - Use the Winget CLI Tool on Windows 11](#step-3-use-the-winget-cli-tool-on-windows-11)
* [Step 4 - List of Common Winget Commands](#step-4-list-of-common-winget-commands)
* [Step 5 - Managing Sources with Winget CLI Tool](#step-5-managing-sources-with-winget-cli-tool)

To complete this guide, you must log in to your **[Windows Client](https://orcacore.com/tag/windows-cl/)** and follow the steps below. First, we start to check the status of Winget if it is installed by default or not.

## Step 1 – Check Winget Status on Windows 11

By default, Winget must be installed on Windows 11\. To verify it, **[open the PowerShell as an Administrator](https://orcacore.com/run-powershell-administrator-windows/)** and run the command below: Or you can use Command Prompt.

```ebnf
winget
```

If the Winget tool is installed, you should see:

![Check Winget Status on Windows 11](https://proxy-prod.omnivore-image-cache.app/724x395,snuuuD4rUT0SuHlsKktHvLgIJt1Xnf2VhyUuoYxXPCGI/https://orcacore.com/wp-content/uploads/2024/02/winget1.webp)

If you don’t have Winget installed on your system, the system will not recognize it. So you can proceed to the next step to install it.

At this point, you can simply visit the [GitHub Winget Page](https://github.com/microsoft/winget-cli/releases/) and get the latest release of Winget. Click the **.msixbundle file** to start the download.

![Install Winget Tool on Windows 11](https://proxy-prod.omnivore-image-cache.app/854x242,s4DXGgU_5rD6QOvuw6qfZq_gC-SGyYc3AYpV10tbyaNE/https://orcacore.com/wp-content/uploads/2024/02/winget2.webp)

Then, you will the following screen, from there, you can install your App Installer. Because we have Winget installed, we see the following screen:

![App Installer Windows 11](https://proxy-prod.omnivore-image-cache.app/627x450,sfvIKHWvIHPIWHf49Z4Y1Vkbx0Kb0gqkDagz1sicKMfg/https://orcacore.com/wp-content/uploads/2024/02/winget3.webp)

Wait for the installation process to finish. The app may automatically install additional dependencies required for the Winget to work.

## Step 3 – Use the Winget CLI Tool on Windows 11

At this point, you can start to use Winget on Windows 11 from the terminal.

To **search for a package**, you can run the following command:

```pgsql
winget search package-name
```

For example:

```ebnf
winget search chrome
```

![Winget Search Package](https://proxy-prod.omnivore-image-cache.app/874x422,sB34tEA4kIsZwQM3HrjlalIZJm6ujKEKGQHmWQccizMo/https://orcacore.com/wp-content/uploads/2024/02/winget4.webp)

Once you search for your desired package, you can **install the package** by using the command below:

```sql
winget install package-ID
```

For example:

```cmake
winget install Google.Chrome
```

This will easily install Chrome on Windows 11 from the Command Line with a single command. When your installation is completed, you will get the following output:

![Winget Install Package](https://proxy-prod.omnivore-image-cache.app/836x180,smC0vtYNqmIxKYu2s-2N4eJxUJmcbWWEKZWxmCFHqIF0/https://orcacore.com/wp-content/uploads/2024/02/winget5.webp)

Another usage of Winget is to **display information about installed packages**. The syntax of it is like this:

```sql
winget show package-ID
```

For example:

```css
winget show Google.Chrome
```

![display information about installed packages with Winget](https://proxy-prod.omnivore-image-cache.app/788x416,s-EEYkXyNIOxv4gN6VnOfEEkFKdJYH_daqWgIqARl5Jg/https://orcacore.com/wp-content/uploads/2024/02/winget6-1.webp)

Also, you can **list all of the installed packages**, by running the command below:

```applescript
winget list
```

![list all of the installed packages with Winget](https://proxy-prod.omnivore-image-cache.app/848x292,sDQZ8wiOp87Va8is3CzxMnHYynY6FFf9fnKlcZxq9tjI/https://orcacore.com/wp-content/uploads/2024/02/winget7.webp)

If you plan to **uninstall a package** by using the Winget on Windows 11, run the following command:

```sql
winget uninstall package-ID
```

## Step 4 – List of Common Winget Commands

Here we provide a list of available commands that you can use in Winget:

* **install**: Installs the given package
* **show**: Shows information about a package
* **source**: Manage sources of packages
* **search**: Find and show basic info on packages
* **list**: Display installed packages
* **upgrade**: Shows and performs available upgrades
* **uninstall**: Uninstalls the given package
* **hash**: Helper to hash installer files
* **validate**: Validates a manifest file
* **settings**: Open settings or set administrator settings
* **features**: Shows the status of experimental features
* **export**: Exports a list of the installed packages
* **import**: Installs all the packages in a file
* **pin**: Manage package pins
* **configure**: Configures the system into a desired state
* **download**: Downloads the installer from a given package

## Step 5 – Managing Sources with Winget CLI Tool

Managing sources with Winget on Windows 11 allows users to control where Winget searches for available packages. Sources refer to repositories or locations where Winget looks for software packages to install.

Winget installs packages from online repositories. The two official Winget repositories are:

* **msstore.** The Microsoft Store repository.
* **winget.** The Winget software repository is maintained by Microsoft.

To check the repositories, you can run the command below:

```tcl
winget source list

```

![Check Winget repositories on Windows 11](https://proxy-prod.omnivore-image-cache.app/518x104,syBXjtzVGqdnyi8TK8A5UL-jOKvPQwlfPc8AAZZql3aI/https://orcacore.com/wp-content/uploads/2024/02/winget8.webp)

Now you can simply add, remove, and update sources with Winget. To do this, you can follow the steps below:

* **Add Sources**: You can add additional package sources to Winget using the winget source add command followed by the URL of the source repository. This allows Winget to search for packages from multiple locations.

```css
winget source add --name [name] [url]
```

* **Update Sources**: You can simply update your existing repositories by using the command below:

```tcl
winget source update

```

* **Remove Sources**: If you no longer want Winget to search for packages from a particular source, you can remove it using the following command:

```delphi
winget source remove --name [name]
```

**_Note_**: If you plan to reset winget back to its original configuration, removing all third-party repositories and setting the sources to the default ones, run the command below:

```pgsql
winget source reset --force
```

### Conclusion

By learning Winget’s command-line interface, users can easily search for, install, update, and uninstall software applications directly from the command prompt or PowerShell. Additionally, Winget makes the process of managing package sources simple and allows users to customize where Winget searches for available software packages.

Hope you enjoy this guide on set up and use Winget on Windows 11\. Also, you may like to read the following articles:

**[2 Simple Methods To Access BIOS in Windows 11](https://orcacore.com/access-bios-windows11/)**

**[Work with Windows 11 Terminal](https://orcacore.com/work-windows11-terminal/)**

**[Find Windows Public IP Address From PowerShell and CMD](https://orcacore.com/find-windows-public-ip-address-powershell-cmd/)**

### Newsletter Updates

Enter your email address below and subscribe to our newsletter

Stay informed and not overwhelmed, subscribe now!

#Omnivore
[Read on Omnivore](https://omnivore.app/me/set-up-and-use-winget-on-windows-11-easy-steps-18f4dc9f977)
[Read Original](https://orcacore.com/set-up-use-winget-windows11/)
