# Optimizely CMS Development

A reference for Optimizely (formerly Episerver) CMS development, covering ContentArea manipulation, catalog content, SQL utilities, and Azure Blob storage.

## ContentArea

### Working with ContentAreaItems
ContentArea items can be accessed and manipulated programmatically via the Episerver API.

Key operations from `development/raw/`:
- **List ContentAreaItems** — enumerate items in a properties ContentArea
- **Move ContentAreaItem** between ContentAreas programmatically
- **Work with List Block properties**

**Pattern: Get items from a ContentArea**
```csharp
// ContentArea property on a block/page
var contentArea = myPage.MainContentArea;
foreach (var item in contentArea.Items)
{
    var content = _contentLoader.Get<IContent>(item.ContentLink);
    // process content
}
```

**Pattern: Move a ContentAreaItem**
```csharp
// Source and destination content areas
var sourceArea = sourcePage.ContentArea;
var destArea = destinationPage.ContentArea;

var item = sourceArea.Items.FirstOrDefault(i => i.ContentLink == targetLink);
if (item != null)
{
    sourceArea.Items.Remove(item);
    destArea.Items.Add(item);
    _contentRepository.Save(sourcePage, SaveAction.Publish);
    _contentRepository.Save(destinationPage, SaveAction.Publish);
}
```

### Fontawesome Tag Helper
Custom tag helper for rendering Font Awesome icons in Razor views. See `development/raw/Fontawesome tag helper.md`.

---

## SQL Utilities

### Get All Content with a Specific Property Value
SQL script to find all content items that have a specific property set to a given value — useful for bulk audits or migrations.

See `development/raw/Getting all content of a specific property with a simple SQL script.md`.

---

## Azure Blob Storage

### Download Blob Items from Production
Steps to download blobs from an Azure production environment for local development or migration.

See `development/raw/Download Blob items from Production.md`.

---

## Catalog Content

### Migrate Catalog Content Properties
Guide from Quan Mai's blog on migrating catalog content properties in Optimizely Commerce — useful when upgrading or restructuring catalog data.

See `development/raw/Migrate Catalog content properties.md`.

---

## Optimizely CLI

**Install:**
```sh
dotnet tool install -g EPiServer.Net.Cli
```

**Common commands:**
```sh
# Create new Optimizely project from template
dotnet new epi-cms-empty -n MyProject

# List available templates
dotnet new --list | grep epi
```

Resources:
- [Optimizely CMS 12 CLI tools, getting started (herlitz.io)](https://www.herlitz.io/2022/05/03/optimizely-cms-12-cli-tools-getting-started/)
- [Install Optimizely (ASP.NET Core)](https://docs.developers.optimizely.com/content-management-system/docs/installing-optimizely-net-5)

---

## Application Insights

### Identifying Spike Requests and Issues
Guide for spotting performance spikes and request issues in Azure Application Insights.

Key queries (KQL):
```kql
// Find slow requests
requests
| where duration > 2000
| summarize count() by name
| order by count_ desc

// Find exceptions
exceptions
| summarize count() by type, outerMessage
| order by count_ desc
```

See `development/raw/Identifying Spike Requests and Issues in Application Insights/`.

---

## Page Audit (Optimizely)

### Automated Page Audit for Large Content Sites
Automated approach for auditing large Optimizely content sites. See `development/raw/Automated Page Audit for Large Content Sites in Optimizely/`.

---

## Sources
- `development/raw/ContentAreaItems.md`
- `development/raw/Programmatically move ContentAreaItem.md`
- `development/raw/Working Programmatically With List Block properties.md`
- `development/raw/Fontawesome tag helper.md`
- `development/raw/Getting all content of a specific property with a simple SQL script.md`
- `development/raw/Download Blob items from Production.md`
- `development/raw/Migrate Catalog content properties.md`
- `development/raw/Identifying Spike Requests and Issues in Application Insights/`
- `development/raw/Automated Page Audit for Large Content Sites in Optimizely/`

## Related
- [[csharp-razor]] — Razor views used in Optimizely templates
- [[docker]] — Docker for local Optimizely development
- [[INDEX]] — Development wiki home
