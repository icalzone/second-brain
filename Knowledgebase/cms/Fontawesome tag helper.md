---
created: 2024-05-22T15:08:45 (UTC -04:00)
tags: []
source: https://vega.rd.no/writing/cool-stuff-with-asp.net-core-tag-helpers-and-font-awesome
author: 
---

# Cool stuff with ASP.NET Core Tag Helpers and Font Awesome

---
I’ve recently had a chance to work with ASP.NET Core 2.0. There are lots of cool stuff in here, but discovering [tag helpers](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/tag-helpers/intro) may have been the coolest thing so far.

I’ve created a few small helpers, but the one that really hit the nail on the head was when I wanted to use the new [FontAwesome Pro](https://fontawesome.com/) for icons. The new icons are awesome, and provide a lot better experience than previous versions of their framework did.

However, they didn’t completely nail size requirements for websites that don’t really need all of their icons. If you go with the [SVG with JS](https://fontawesome.com/get-started/svg-with-js) solution, you’ll end up loading over 400 kB of icons per set you include (in total more than 1.6 MB if you want all four sets). This really wasn’t an option for the small website I’m working on.

So, I set to work combining the ASP.NET tag helpers with FontAwesome, and the results were pretty good.

> The basic idea is to inline the actual SVG in the HTML wherever you use the icons.

There are a few steps:

1.  Add the raw SVG icons to your project, and make Visual Studio copy them to the output directory

2.  Create and enable your tag helper

3.  Add some styling for your icons

4.  ??

5.  Profit!

## Adding the SVGs

In the FontAwesome Pro archive, find `advanced-options/raw-svg` and copy the four folders into your project. I put mine under `Assets/FontAwesome` (not in `wwwroot`, because they don’t have to be).

Now, right click your project, and choose **Unload project**. Right click again and **Edit YourWebsite.csproj**. You’ll need to insert something so Visual Studio knows to copy these files to the output directory when you deploy. Find an existing `<ItemGroup>` with e.g. `<Folder>` or `<Content>` tags and include the content snippet. (You could probably also do this with a `<Folder>` tag).

```xml
<ItemGroup>
  <Content Include="Assets\**\*.svg">
    <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
  </Content>
</ItemGroup>
```

Save the file, right click your project and choose **Reload Project**.

## Creating the tag helper

There is a great template to get you started writing tag helpers. In the **New item window**, under **Visual C#**, **ASP.NET Core**, **Web**, you’ll find a template called **Razor Tag Helper**, which is a good starting point. I put mine in a `.TagHelpers` namespace.

```csharp
namespace Your.Website.TagHelpers
{
    using System.IO;

    using Microsoft.AspNetCore.Html;
    using Microsoft.AspNetCore.Razor.TagHelpers;

    [HtmlTargetElement("icon", TagStructure = TagStructure.WithoutEndTag)]
    public class IconTagHelper : TagHelper
    {
        public string Name { get; set; }

        public FontAwesomeSet Set { get; set; } = FontAwesomeSet.Solid;

        public override void Process(TagHelperContext context, TagHelperOutput output)
        {
            output.TagName = "span";

            var classAttribute = output.Attributes["class"];
            var classes = (classAttribute?.Value as HtmlString)?.Value ?? string.Empty;
            classes += " icon";
            classes = classes.Trim();
            output.Attributes.SetAttribute("class", classes);

            output.TagMode = TagMode.StartTagAndEndTag;

            var svg = File.ReadAllText($"Assets/FontAwesome/{this.Set.ToString().ToLowerInvariant()}/{this.Name}.svg");
            output.Content.SetHtmlContent(svg);
        }
    }

    public enum FontAwesomeSet
    {
        Solid,
        Regular,
        Light,
        Brands
    }
}
```

This tag helper looks for a self-closed `<icon>` tag, and it accepts two properties, `name` and `set`. You would use it like this:

```xml
<icon set="Brands" name="windows" class="white" />
```

The enum `FontAwesomeSet` ensures you get IntelliSense for the `set` property. You could in theory do something similar for the name, but it would provide a false sense of security as the available icons vary between the sets.

If you’d like to have IntelliSense even for the icon names, you could make 4 different enums, and change the syntax to something like:

```xml
<icon brands="Windows" />
```

However, that would require maintaining and updating complete lists of the FontAwesome icons, which I found to be too much work.

We convert the tag to a `span`. Then we massage the `class` attribute, to append the `icon` class to the existing set of classes. We read the SVG file from disk, and insert it as HTML. We’ll end up with a structure like this:

```xml
<span class="white icon">
  <svg xmlns="http://www.w3.org/2000/svg">
     
  </svg>
</span>
```

This structure is easily stylable using CSS.

## Enabling the tag helper

In your `Views/_ViewImports.cshtml` file, add the following at the bottom:

```xml
@addTagHelper *, Your.Website
```

Note how I used the assembly name here, not the namespace name. This will add all custom tag helpers from your project to be usable in all your views.

## Adding some style

My styles were simple, as I didn’t need to support all the [cool stuff](https://fontawesome.com/how-to-use/svg-with-js) FontAwesome can do. Yours can be more complex if you’d like:

```less
span.icon {
    display: inline-block;
    vertical-align: middle;
    height: 1em;
    width: 1em;
    margin: 0;

    
    margin-top: -0.2em;

    &.white {
        svg * { fill: white; }
    }
}
```
