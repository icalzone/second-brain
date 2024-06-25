1
# Loop through contentarea items

### To solve this using linq

// ServiceLocator as example, use dependency injection!
var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();

// Get all CodeBlock's from the contentarea
IEnumerable<CodeBlock> items = currentPage.ContentArea?.Items?
    .Where(block => block.GetContent() is CodeBlock) // validate type
    .Select(block => contentLoader.Get<CodeBlock>(block.ContentLink));

// Run a where on a specific property on the blocks
IEnumerable<CodeBlock> items = currentPage.ContentArea?.Items?
    .Where(block => block.GetContent() is CodeBlock) // validate type
    .Select(block => contentLoader.Get<CodeBlock>(block.ContentLink))
    .Where(block => block.Tags.Contains("Episerver"));
Now the trick here is to use the .Where(block => block.GetContent() is CodeBlock), the block.GetContent() will resolve an IContent object which allows you to verify the type of the block

For a more generic approach use this

IEnumerable<IContent> items = currentPage.ContentArea?.Items?
    .Select(content => contentLoader.Get<IContent>(content.ContentLink))  // Get as IContent
    .Where(content => content.Name.Contains("block")); // any properties you like
The last version will also include pages if they are dropped in the contentarea, if you only like to support a specific type use the same type validation

IEnumerable<IContent> items = currentPage.ContentArea?.Items?
    .Where(content => content.GetContent() is BlockData) // validate type
    .Select(content => contentLoader.Get<IContent>(content.ContentLink))
    .Where(content => content.Name.Contains("block"));
Always check variables if they are null when using null propagation as I do ContentArea?.Items?...

if(items != null) {
    // Yay!
}

### To solve with no Linq
 var resultList = new List<IContent>();
    var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();

    foreach (ContentAreaItem contentAreaItem in currentPage.PrimaryComponentArea.FilteredItems)
    {
        if (contentAreaItem != null && contentAreaItem.ContentLink != null &&
            contentAreaItem.ContentLink != ContentReference.EmptyReference)
        {

        IContent content;
        if (contentLoader.TryGet(contentAreaItem.ContentLink, out content))
            if (content != null)
            {
                resultList.Add(content);
            }
        }
    }

Above code will give you a list of blocks in the contentarea as IContent. Note that I used FilteredItems which also takes into consideration any personlization, publish status etc.

To access the properties of the blocks you will need to cast them to their type. So something like this might point you in the right direction

foreach (IContent content in resultList)
{
            var block = content as YourBlockType;
            if (content != null)
            {
                // the content is of type YourBlockType. Do work 
            }
}