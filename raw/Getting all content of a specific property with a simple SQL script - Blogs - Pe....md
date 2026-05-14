---
id: 36d520f8-b993-45d6-b205-770cbc6e8752
title: Optimizely CMS - Getting all content of a specific property with a simple SQL script / Blogs / Perficient
author: Tung Tran
tags:
  - save-cms
date_saved: 2024-04-15 08:11:53
date_published: 2023-06-18 20:00:00
---

## Metadata
- Author: [[Tung Tran]]
- Title: [Optimizely CMS - Getting all content of a specific property with a simple SQL script / Blogs / Perficient]
- URL: [(https://blogs.perficient.com/2023/06/19/optimizely-cms-getting-all-content-of-a-specific-property-with-a-simple-sql-script/]


## Entire Post
When you need to retrieve all content of a specific property from a Page/Block type, normally you will use the IContentLoader or IContentRepository, or even IContentModelUsage to get all instances of a content type then select them by property. This is the correct implementation by code.

But what if you only need to check the property’s value for debugging/development purpose? Or generate a quick report for a property’s usage? Then you have to wrap the above implementation inside an API or a custom tool, and then build, deploy, etc. Seems excessive for a single-use requirement, doesn’t it? This article will guide you to go through this by just a SQL script.

## Scenario

In this article, we will try to get all MetaDescription of Standard Pages inside the Alloy template:

![Alloy](https://proxy-prod.omnivore-image-cache.app/751x479,sH5lCGtfTCSrsuo4KdUPF2QweLX1jYtTTEqopuQtxmcg/https://blogs.perficient.com/files/alloy.png)

## Before we start

In order to execute the script, we need to know the Primary Key ID of both Standard Page and MetaDescription Property.

For the Standard Page, we can easily spot its Primary Key by going to the Admin Section -> Content Types -> StandardPage, it’s displaying in the URL. For my local environment, the Primary Key is 20

![Standardpagepkid](https://proxy-prod.omnivore-image-cache.app/679x462,sOzTCEN_j_PGhoGprziBW7SzTj8pNNdixNwuGSvyhnEc/https://blogs.perficient.com/files/StandardPagePkId.png)

For the MetaDescription property, we need to query the table tblPropertyDefinition, to get all property’s definitions of the StandardPage.

select \* from tblPropertyDefinition 

where fkContentTypeID = 20 \-- standard page's pkId

select \* from tblPropertyDefinition where fkContentTypeID = 20 -- standard page's pkId

select * from tblPropertyDefinition 
where fkContentTypeID = 20 -- standard page's pkId

As you can see, the Primary Key ID of MetaDescription property is 138 in my local machine.

![Querypropertyid](https://proxy-prod.omnivore-image-cache.app/537x387,sCsbNCOSrePFp1QOLUU2WL9-J5UTvBmGjXUZyRJH5NQk/https://blogs.perficient.com/files/QueryPropertyId.png)

## The script

Now we have all the necessary IDs, it’s time for the script:

 wcp.LongString as MetaDescription

inner join tblWorkContent wc on c.pkID = wc.fkContentID

inner join tblWorkContentProperty wcp on wcp.fkWorkContentID = wc.pkID

where c.fkContentTypeID = 20 \-- standard page type ID

and wc.Status = 4 \-- last publish version

and wcp.fkPropertyDefinitionID = 138 \-- metadescription property ID

select c.pkID as PageID, wc.Name as PageName, wcp.LongString as MetaDescription from tblContent c inner join tblWorkContent wc on c.pkID = wc.fkContentID inner join tblWorkContentProperty wcp on wcp.fkWorkContentID = wc.pkID where c.fkContentTypeID = 20 -- standard page type ID and wc.Status = 4 -- last publish version and wcp.fkPropertyDefinitionID = 138 -- metadescription property ID

select c.pkID as PageID,
    wc.Name as PageName,
    wcp.LongString as MetaDescription
from tblContent c
     inner join tblWorkContent wc on c.pkID = wc.fkContentID
     inner join tblWorkContentProperty wcp on wcp.fkWorkContentID = wc.pkID
where c.fkContentTypeID = 20 -- standard page type ID
     and wc.Status = 4 -- last publish version
     and wcp.fkPropertyDefinitionID = 138 -- metadescription property ID

## Explanation

To get the data we need, we have to do an inner join between 3 different tables: tblContent, tblWorkContent and tblWorkContentProperty.

* **tblContent**: This is one of the most important tables in Optimizely Content Cloud. Each row contains all crucial information of a content. It includes the ID (pkId) of the content and this table is considered as a root to connect with other tables in the system. In this example we will use the condition _where tblContent.fkContentTypeID = 20_ to only get contents of type Standard Page.
* **tblWorkContent:** This table contains all versions of content in the CMS. When you Save/Publish a page or a block, a new record will be inserted to the tblWorkContent. Or when you browsing the Versions add-on in Edit mode, you are actually seeing data from this table. For this script, we use the condition _where tblWorkContent.Status = 4_ to retrieve only the last publish version of a content.
* **tblWorkContentProperty:** This table also contains data of versions. But unlike tblWorkContent, this one store the data of each property. When a page/block is published, there could be one or more properties get modified within a version, so this table will keep track of all modified properties for a specific version. For the purpose of this scenario, will will use the condition where tblWorkContentProperty.fkPropertyDefinitionID = 138 to only take the MetaDescription property.

## The result

![Query result](https://proxy-prod.omnivore-image-cache.app/1297x274,sF-nG0RtJbhczB5Z6gwDaDGxIxF4Si6XUIcSoOp5RidY/https://blogs.perficient.com/files/QueryResult.png)

That’s it! Now you have the magic spell in your hand, feel free to discover your database whenever you need to. Happy coding!

Tung is an Optimizely Certified Content Cloud Developer with experience working with .NET technologies. Strong engineering professional skilled in developing both Windows and Web Applications. In his free time, he enjoys watching, playing soccer, and spending time with his small family.

**[More from this Author](https://blogs.perficient.com/author/ttran/ "Tung Tran")**

##### Follow Us

#Omnivore
[Read on Omnivore](https://omnivore.app/me/optimizely-cms-getting-all-content-of-a-specific-property-with-a-18ee1abc225)
[Read Original](https://blogs.perficient.com/2023/06/19/optimizely-cms-getting-all-content-of-a-specific-property-with-a-simple-sql-script/)
