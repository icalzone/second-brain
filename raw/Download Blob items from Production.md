---
created: 2024-06-10T07:48:59 (UTC -04:00)
tags: []
source: https://opticmsxperience.com/2023/04/04/optimizely-cms-11-download-blob-items-from-production/
author: 
---

# Optimizely CMS 11 – Download Blob items from Production – Optimizely Developer Blog

> ## Excerpt
> This post will walk you through the process of getting the blob assets from production to get the images working locally.

---
Have you tried to keep your local environment up to date with the same content as production but the images seem to be broken? This post will walk you through the process of getting the blob assets from production to get the images working locally.

Based on the documentation that Optimizely provides [https://docs.developers.optimizely.com/digital-experience-platform/v1.3.0-DXP-for-CMS11-COM13/docs/storage-containers](https://docs.developers.optimizely.com/digital-experience-platform/v1.3.0-DXP-for-CMS11-COM13/docs/storage-containers), I will add some extra steps you need to follow to make this easier.

**1\. Get the Project Id**  
If you have access to the PAAS Portal, you will be able to get it easily from the URL once you select the Organization:

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image.png?w=970)

You can also see the project Id, directly if you go to the API tab:

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-1.png?w=1024)

**2\. Generate an API Key**  
In the API tab, click on the “Add API Credentials” button in order to generate the key and secret keys.

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-2.png?w=406)

Select Production and add a name so you can identify it later:

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-3.png?w=589)

Once created, you will be able to copy the API key and the API secret values (store them in a safe place)

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-4.png?w=1024)

3\. Powershell Scripts  
Open Powershell in Administrator mode and install the [EpiCloud Powershell module](https://www.powershellgallery.com/packages/EpiCloud/1.2.0)

<table><tbody><tr><td><p>1</p></td><td><div><p><code>Install-Module</code> <code>-Name</code> <code>EpiCloud</code></p></div></td></tr></tbody></table>

If you are having issues executing scripts you can set the policy to allow all scripts:

<table><tbody><tr><td><p>1</p><p>2</p></td><td><div><p><code>Set-ExecutionPolicy</code> <code>Unrestricted</code></p><p><code>NOTE: this policy will alow the execution of any script. Risks running malicious scripts.</code></p></div></td></tr></tbody></table>

Once you install the module you will be able to execute specific commands

<table><tbody><tr><td><p>1</p></td><td><div><p><code>Get-EpiStorageContainer</code> <code>-ProjectId</code> <code>"48530467-XXXX-XXXX-8ded-ab30006f7e8b"</code> <code>-Environment</code> <code>"Production"</code></p></div></td></tr></tbody></table>

You need to provide the ClientKey and the ClientSecret – the ones you generated in the previous step.

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-5.png?w=669)

The result will show you the name of the containers that are used for production:

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-6.png?w=899)

We need to focus on the one we have for assets (in this case “media”). Then, we need to generate the SasLink so we can access the container.

<table><tbody><tr><td><p>1</p><p>2</p><p>3</p><p>4</p></td><td><div><p><code>Get-EpiStorageContainerSasLink</code> <code>-ProjectId</code> <code>"48530467-XXXX-XXXX-8ded-ab30006f7e8b"</code> <code>`</code></p><p><code>&nbsp;&nbsp;</code><code>-Environment</code> <code>"Production"</code> <code>`</code></p><p><code>&nbsp;&nbsp;</code><code>-StorageContainer</code> <code>"media"</code> <code>`</code></p><p><code>&nbsp;&nbsp;</code><code>-RetentionHours</code> <code>2</code></p></div></td></tr></tbody></table>

The parameter, **\-RetentionHours** takes a dynamic value for the SAS link expiry; if it is not provided, a default 24 hours is used to generate the link.  
Once you execute this script, it will display the link you need to use to download the blobs

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-7.png?w=959)

Then, you can use the [Microsoft Azure Storage Explorer](https://azure.microsoft.com/en-us/products/storage/storage-explorer) to access the container.  
a. Connect to a resource. Select Blob container

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-8.png?w=908)

b. Then select Shared access signature URL (SAS)

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-10.png?w=584)

c. Paste the URL generated with the command Get-EpiStorageContainerSasLink

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-11.png?w=899)

d. From there, you will be able to explore the assets and also download all so you can use them on your local

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-12.png?w=736)

Finally, you can then copy all the files into the Blobs folder of your local implementation.  
The images should be loading fine now. If you don’t see them working, you can execute the scheduled job called “Convert File Blobs” and they will be stored as defined on your configurations.

NOTE: I assume you already got the .bacpac file from the PaasPortal to get the latest content from production.

![](https://opticmsxperience.com/wp-content/uploads/2023/04/image-13.png?w=1024)

It can also be exported using the API as documented [here](https://docs.developers.optimizely.com/digital-experience-platform/v1.3.0-DXP-for-CMS11-COM13/docs/export-database)



created: 2024-06-10T07:53:09 (UTC -04:00)
source: https://www.epinova.no/folg-med/blogg/2020/download-blobs-from-your-dxp-project/

# Download Blobs from your DXP project | Epinova

> ## Excerpt
> It’s now possible to download BLOBs directly from your Episerver DXP environments with a PowerShell script – thus removing the need to contact the Episerver support.

---
It’s now possible to download BLOBs directly from your Episerver DXP environments with a PowerShell script – thus removing the need to contact the Episerver support.

For those that need to download BLOBs from your DXP environment there no longer a need to contact the Episerver support anymore. In the beginning of November Episerver updated their EpiCloud PowerShell module to version v0.12.14. In that version two new methods were released that made it possible to download BLOBs, website\- and application\-logs from the containers that are connected to the DXP project.  

The new methods are: 

**Get-****EpiStorageContainer**: Retrieves list of blob storage containers for specified project id and environment. 

**Get-****EpiStorageContainerSasLink**: Retrieves SAS link for specified project id, environment, storage container and retention hours. 

The really cool part is that you have the possibility to download this from either the Integration, Preproduction or Production environments. To make this a little simpler to use, I have created a script that you can run on your local computer to download content. 

## Example 

Here is an example when I download the BLOBs from a DXP website’s Preproduction environment:’ 

`.\DownloadDxpBlobs.ps1 -clientKey "yGxxxxxxxxxxxxxxDz" -clientSecret "s4xxxxxxxxxxxxx/b" -projectId "d5xxxxx4-5xx5-4xx6-bxx4-axxxxxxxxxxc" -environment "Preproduction" -downloadFolder "E:\dev\temp\_blobDownloads"` 

![PsDownloadBlobs.jpg](https://www.epinova.no/contentassets/db520c28138448139a88e40dc15f1712/psdownloadblobs.jpg?quality=80&mode=crop&width=1200&height=675)

![FilesDownloadedBlobs.jpg](https://www.epinova.no/contentassets/db520c28138448139a88e40dc15f1712/filesdownloadedblobs.jpg?quality=80&mode=crop&width=1200&height=675)

## How to get ProjectId/ClientKey/ClientSecret 

Login to [https://paasportal.episerver.net/](https://paasportal.episerver.net/) and select the project. Click on the “API” tab and generate an API Credentials. In the top you can also see the ProjectId. 

![PaasApiTab.jpg](https://www.epinova.no/contentassets/db520c28138448139a88e40dc15f1712/paasapitab.jpg?quality=80&mode=crop&width=1200&height=675)

## Outro 

I feel that this is unlocks new possibilities and I'll continue to play around with these methods and try to come up with more scripts that makes at least my days easier. 

You can find the documentation for the download script in our GitHub repo. [https://github.com/Epinova/epinova-dxp-deployment/blob/master/Scripts/DownloadDxpBlobs.md](https://github.com/Epinova/epinova-dxp-deployment/blob/master/Scripts/DownloadDxpBlobs.md) 

And the script can be downloaded from the same repo. [https://github.com/Epinova/epinova-dxp-deployment/blob/master/Scripts/DownloadDxpBlobs.ps1](https://github.com/Epinova/epinova-dxp-deployment/blob/master/Scripts/DownloadDxpBlobs.ps1) 