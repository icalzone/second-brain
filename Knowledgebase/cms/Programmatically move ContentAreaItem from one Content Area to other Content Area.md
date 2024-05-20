---
id: 48ae74f2-cbdd-48b6-89a8-730b52f55fd2
title: Programmatically move ContentAreaItem from one Content Area to o
author: Nenad Nicevski
tags:
  - save-cms
date_saved: 2024-04-09 13:42:06
date_published: 2019-06-20 13:46:46
---

## Metadata
- Author: [[Nenad Nicevski]]
- Title: [Programmatically move ContentAreaItem from one Content Area to o]
- URL: [(https://world.optimizely.com/forum/developer-forum/CMS/Thread-Container/2019/6/programmatically--move-contentareaitem-from-one-content-area-to-other-content-area-/]


## Entire Post
Hi,

The reason is, calling `Clear()` doesn't automatically set the `IsModified` boolean for the property to true, so ultimately the change isn't persisted in the database.

You can either remove the items individually:

```reasonml
while (layoutPage.SecondColumnContentArea.Items.Any())
{
    layoutPage.SecondColumnContentArea.Items.RemoveAt(0);
}
```

or, set `IsModified` yourself:

```abnf
layoutPage.SecondColumnContentArea.Items.Clear();
layoutPage.SecondColumnContentArea.IsModified = true;
```

Unless there is a reason for it you stipped out of your snippet there is also no need to get each block from the content repository. The following _should_ work:

```reasonml
var contentRepository = ServiceLocator.Current.GetInstance<IContentRepository>();

var pageLink = new PageReference(id);

if (ContentReference.IsNullOrEmpty(pageLink))
{
    return;
}

LayoutPage layoutPage;

if (!contentRepository.TryGet(pageLink, out layoutPage))
{
    return;
}

var items = layoutPage?.SecondColumnContentArea?.Items;

if (items == null || !items.Any())
{
    return;
}

layoutPage = (LayoutPage)layoutPage.CreateWritableClone();

if (layoutPage.FirstColumnContentArea == null)
{
    layoutPage.FirstColumnContentArea = new ContentArea();
}

foreach (var item in items)
{
    layoutPage.FirstColumnContentArea.Items.Add(item);
}

while (layoutPage.SecondColumnContentArea.Items.Any())
{
    layoutPage.SecondColumnContentArea.Items.RemoveAt(0);
}

contentRepository.Save(layoutPage, SaveAction.Publish, AccessLevel.NoAccess);
```

<#204925>

Edited,  Jun 20, 2019 23:55

[Mark Rullo]()  \- Apr 21, 2021 15:49

Thank you so much for the IsModified comment. That was a lifesaver!


Hi Jake, 

Thank you for your time and your response. In the meantime I figureout why the Clear() is not woriking and to set IsModifid property so that the changes are registered.

And your code is helpfull :) . 

So now the moving items is working but I have another big problem: page versions.

I am trying to achive the same effect when the editor click on the second content area item and drag&drop that item to the first content area and the change is instantly visible and the page draft is saved (autosave).

I manage to move content items but those chages are saved in the previous page draft or on the new page draft and the previous draft is set to Primary Draft.

I tried this in two ways:  
1\. change event is fired from the DOJO widget and the web api method is called (code snipped in my first post). I tried every combination with SaveAction flags and with versionRepository.SetCommonDraft(saveReference) to force the new page draft to bi set as a Primary Draft.

2\. hooked on the content events : tried with SavingContent, CheckingOut, SavedContent and CheckedContent (I know how this events works and what is their function/role) but the result is the same.

In the first approach the changes are instantly visible but I have manually to change to the page draft that have changes and republish them.

In the second apporach the changes are not instantly visibile and I have to refresh the page, of with F5 or just publish the page and then the changes are visible.

Any ideas? Did somebody tried something similar?

<#204929>

 Jun 21, 2019 11:33

#Omnivore
[Read on Omnivore](https://omnivore.app/me/programmatically-move-content-area-item-from-one-content-area-to-18ec3f3ea55)
[Read Original](https://world.optimizely.com/forum/developer-forum/CMS/Thread-Container/2019/6/programmatically--move-contentareaitem-from-one-content-area-to-other-content-area-/)
