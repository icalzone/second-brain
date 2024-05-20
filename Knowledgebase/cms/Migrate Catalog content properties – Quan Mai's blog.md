---
id: 3d9064a0-bcdb-4cab-b0ac-01c9248309bf
title: Migrate Catalog content properties – Quan Mai's blog
author: vimvq1987
tags:
  - save-cms
date_saved: 2024-02-21 11:13:39
date_published: 2024-02-20 11:48:55
---

## Metadata
- Author: [[vimvq1987]]
- Title: [Migrate Catalog content properties – Quan Mai's blog]
- URL: [(https://vimvq1987.com/migrate-catalog-content-properties/]


## Entire Post
A colleague asked me yesterday – how do we migrate properties of catalog content. There is, unfortunately, no official way to do it. There are several unofficial ways to do it, however. Today we will explore the way I personally recommend – for its safety and backward compatible.

Let’s say we have `FashionProduct` with a `MSRP` property with type of `Money`, now we would want to change it to `Decimal` . There are a some hacky ways to do this, but all of them require direct database manipulation which we should try to avoid – if possible.

First we will need this piece of code. it was “stolen” from a colleague of mine and has been used for countless times. You probably want to bookmark it as it’ll likely be useful in the future (I should probably do so myself as I have to find it every time I need). It is a snippet to traverse the catalog structure based on the content type you’d want.

```cs
public virtual IEnumerable<T> GetEntriesRecursive<T>(ContentReference parentLink, CultureInfo defaultCulture) where T : EntryContentBase
    {
        foreach (var nodeContent in LoadChildrenBatched<NodeContent>(parentLink, defaultCulture))
        {
            foreach (var entry in GetEntriesRecursive<T>(nodeContent.ContentLink, defaultCulture))
            {
                yield return entry;
            }
        }

        foreach (var entry in LoadChildrenBatched<T>(parentLink, defaultCulture))
        {
            yield return entry;
        }
    }

    private IEnumerable<T> LoadChildrenBatched<T>(ContentReference parentLink, CultureInfo defaultCulture) where T : IContent
    {
        var start = 0;

        while (true)
        {
            var batch = _contentLoader.GetChildren<T>(parentLink, defaultCulture, start, 50);
            if (!batch.Any())
            {
                yield break;
            }

            foreach (var content in batch)
            {
                // Don't include linked products to avoid including them multiple times when traversing the catalog
                if (!parentLink.CompareToIgnoreWorkID(content.ParentLink))
                {
                    continue;
                }

                yield return content;
            }
            start += 50;
        }
    }
```

To make sure we don’t load to many content at once, the batch is set size 50 but that is of course configurable (up to you)!

Now the fun part, where it actually does the work. Once we have the content, we will need to actually migrate the data, it is can be simple as this

```maxima
private void MigrateProperty<T>(IEnumerable<T> contents) where T: EntryContentBase
{
      var batch = new List<T>();
      foreach(var content in contents)
      {
           var writeableClone = content.CreateWriteableClone<T>();
           Transform(writeableClone);
           batch.Add(writeableClone);
      }
      _contentRepository.Publish(batch, PublishAction.SyncDraft);
}
```

With the `Transform` method you can do whatever you want with the property value. As you might just want to rename it – it can do nothing except assign value to the new property. Or in the case we mentioned at the beginning, convert `Money` to `Decimal` is an easy task (`Money` is the less precision version of `Decimal`). Note that if you convert between data types, for example from `double` to `int` , there are potential data loss, but you are probably aware of that already.

The final step is to publish the change. For performance reasons, it is probably the best that you the `Publish` extension method of `IContentRepository` and save multiple content in one batch – may of of size 50 or 100\. Those will skip things like creating new versions for optimal performance. You can read it about here [New simple batch saving API for Commerce | Optimizely Developer C](https://world.optimizely.com/blogs/Quan-Mai/Dates/2019/10/new-simple-batch-saving-api-for-commerce/)

The remaining question is where to put it. In a perfect world, I’d say in a migration step (i.e. a class that implement `IMigrationStep` ), so you ensure that your data will be properly migrated before anything else run, for example your new code that access the new property, or indexing of your content after migration. But if you have a sizeable catalog, this will take time and it might not be a good idea to let your users wait for it to complete. For that, it makes senses to do this in a schedule job and when it completes, you make a switch.

Migrating properties is not an easy or quick task, but it can be done with relative ease. It also reminds us about modeling – try to get it right from beginning so we don’t have to migrate. In the end, the fastest code is the code that does not need to be run!

#Omnivore
[Read on Omnivore](https://omnivore.app/me/migrate-catalog-content-properties-quan-mai-s-blog-18dcc71afca)
[Read Original](https://vimvq1987.com/migrate-catalog-content-properties/)
