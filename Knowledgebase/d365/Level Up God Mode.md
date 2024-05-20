---
id: 7e56865d-9d4d-45a8-9dc5-ac029b745d23
title: Level Up God Mode – @ramontebar 👨‍💻
author: "@ramontebar"
tags:
  - save-d365
  - power_automate
date_saved: 2024-03-25 08:36:54
date_published: 2020-04-29 07:44:02
---

## Metadata
- Author: [[@ramontebar]]
- Title: [Level Up God Mode – @ramontebar 👨‍💻]
- URL: [(https://ramontebar.net/2020/04/29/level-up-god-mode/]


## Entire Post
[Level Up for Dynamics 365 ](https://chrome.google.com/webstore/detail/level-up-for-dynamics-365/bjnkkhimoaclnddigpphpgkfgeggokam)is one of the most useful productivity tools if you are working with the **Power Platform** and **model-driven apps**. This utility is a Chrome extension that allows users to perform advanced actions, that normally would require JavaScript bookmarklets. In this article I’ll describe how **God Mode** works and cover some of the security concerns you may have.

![](https://proxy-prod.omnivore-image-cache.app/1024x646,s4DvjxT_o6H9xaMcK8cE7TDcMF5Wy7IHZ13Nmy3kMaw8/https://ramontebar.files.wordpress.com/2020/04/ramontebar-blog-d635-levelup-chrome-extension.jpg?w=1024)

<https://chrome.google.com/webstore/detail/level-up-for-dynamics-365/bjnkkhimoaclnddigpphpgkfgeggokam>

**God Mode** is one of the most powerful options in this utility, which makes **all mandatory fields optional,** make **hidden fields/tabs/sections visible** and makes **read-only fields editable**.

![](https://proxy-prod.omnivore-image-cache.app/1024x464,s0JlBulB_LTcuBIP5BRIjM-u9H9DOjcqf-oMVeQecpgw/https://ramontebar.files.wordpress.com/2020/04/ramontebar-blog-d635-levelup-god-mode-1.jpg?w=1024)

Using God Mode in Model-driven app

One of the questions you may have is: so **does Level Up break the Dynamics 365 security model**? The short answer is **No**.

God Mode just **runs in the client side**, it doesn’t call the API service with any kind of elevated priviligies. You can actually see the current code in the following screenshot taken from [the original GitHub repository:](https://github.com/rajyraman/Levelup-for-Dynamics-CRM)

![https://github.com/rajyraman/Levelup-for-Dynamics-CRM/blob/master/app/scripts/inject/levelup.forms.ts](https://proxy-prod.omnivore-image-cache.app/1024x511,s6MtJfqBgs24lfxHkoMas0fSBG07MxXFby2-fw4hq6Ds/https://ramontebar.files.wordpress.com/2020/04/ramontebar-blog-d635-levelup-god-mode-typescript.jpg?w=1024)

<https://github.com/rajyraman/Levelup-for-Dynamics-CRM/blob/master/app/scripts/inject/levelup.forms.ts>

In consecuence, we can say that: 

* God Mode doesn’t allow you to see or update additional records beyond what your **security role(s)** already does.
* God Mode allows you to see hidden form attributes, which you could also see by [**Advanced Find**](https://docs.microsoft.com/en-us/dynamics365/customerengagement/on-premises/basics/save-advanced-find-search).
* God Mode allows you to update read-only form attributes, which you could also edit by **importing** the same records or calling the API.
* God Mode doesn’t allow you to read/create/update attributes secured by **Field Level Security profiles**
* God Mode doesn’t allow you to update attributes secured by **server-side extensions** (e.g. pre-validation **plugins**)
* God Mode doesn’t skip the **auditing** control (e.g. updating a read-only form attribute would be tracked in the auditing history).

Actually, you could easily run God Mode without having the Level Up extension by just using the native **Developer tools** that any browser offers nowadays. For instance, in Chrome, just press **F12**, navigate to the **Console section** and run the following code. It will do exactly the same as God Mode:

```reasonml
Xrm.Page.data.entity.attributes.forEach(function(attr) {attr.setRequiredLevel('none')} );

Xrm.Page.ui.controls.forEach(function(c){ c.setVisible(true);
      if (c.setDisabled) {
        c.setDisabled(false);
      }
      if (c.clearNotification) {
        c.clearNotification();
      }});


Xrm.Page.ui.tabs.forEach(function(tab){
      tab.setVisible(true);
      tab.setDisplayState('expanded');
      tab.sections.forEach(function(section) {section.setVisible(true)});
    });
```

![](https://proxy-prod.omnivore-image-cache.app/1024x608,sxDkqEeUWryyUtQ-O96GRdmrM_2dxbpX8Yo0MgMQ_78o/https://ramontebar.files.wordpress.com/2020/04/ramontebar-blog-god-mode-by-f12-browswer-developers-tools.jpg?w=1024)

Chrome Developers Tools – Running JavaScript in Console

So, as a summary, we could conclude the following points:

* Don’t rely on client side controls (e.g. show/hide) if you really want to secure some information in the Common Data Service. Use the main security model components: security roles, business units, teams, field level security profiles, server-side validation and auditing.
* Although God Mode doesn’t break the platform security model, don’t instigage your business users to use the tool. Your UI customisations should offer them the right experience and guidance. I predominantly recommend technical and support teams to take advantage of this great utility.

This article has been written based on the **Level Up version 3.5.2** and the **CDS versio**n **9.1**.0000.16532 (server) / 1.4.551-2004.1 (client) with 2020 Wave 1 enabled.

Hope you find it useful! ![🙂](https://proxy-prod.omnivore-image-cache.app/0x0,svMiL63_Nv-2gKg0JWD0bnuS9QI6qFZJ8u3g4U8U61ek/https://s0.wp.com/wp-content/mu-plugins/wpcom-smileys/twemoji/2/svg/1f642.svg)

##  Published by @ramontebar 

 Software Engineer specialised on Microsoft Technologies with experience in large projects for different industrial sectors as developer, consultant and architect. I enjoy designing and developing software applications, it is my job and one of my hobbies. I’m interested in design patterns, new technologies and best practices. Making those part of the ALM process is a great challenge. During the last years, I have specialised in Microsoft Dynamics CRM (now Dynamics 365). I customise and extend the platform to provide tailored solutions and integrations based on service-oriented architectures and messages queuing. Motivated by community events and contributor in blogs, technical books, open source projects and forums, I have been awarded Microsoft Most Valuable Professional (MVP) on Dynamics 365 (CRM) from 2012 to 2019\. [ View all posts by @ramontebar ](https://ramontebar.net/author/ramontebar8c38232f8e/) 

**Published** 

#Omnivore
[Read on Omnivore](https://omnivore.app/me/level-up-god-mode-ramontebar-18e759d1b41)
[Read Original](https://ramontebar.net/2020/04/29/level-up-god-mode/)
