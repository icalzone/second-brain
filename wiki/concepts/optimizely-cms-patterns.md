---
type: concept
domains: [work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# Optimizely CMS Patterns

Development patterns, code snippets, and operational guides for Optimizely CMS 12 (formerly Episerver).

## Content Area Operations

### Looping Through Content Area Items (C#)

Use `FilteredItems` (not `Items`) to respect personalization, publish status, and access control.

**With LINQ — type-filtered:**
```cs
var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();

IEnumerable<CodeBlock> items = currentPage.ContentArea?.Items?
    .Where(block => block.GetContent() is CodeBlock)
    .Select(block => contentLoader.Get<CodeBlock>(block.ContentLink))
    .Where(block => block.Tags.Contains("Episerver"));
```

**With LINQ — generic `IContent`:**
```cs
IEnumerable<IContent> items = currentPage.ContentArea?.Items?
    .Select(content => contentLoader.Get<IContent>(content.ContentLink))
    .Where(content => content.Name.Contains("block"));
```

**Without LINQ:**
```cs
foreach (ContentAreaItem item in currentPage.PrimaryComponentArea.FilteredItems)
{
    IContent content;
    if (contentLoader.TryGet(item.ContentLink, out content))
        resultList.Add(content);
}
```

→ Source: [ContentAreaItems](/raw/ContentAreaItems.md)

### Moving ContentAreaItems Between Areas

Calling `Clear()` alone does **not** persist — it doesn't set `IsModified`. Fix:

```cs
// Option 1: Remove items individually
while (layoutPage.SecondColumnContentArea.Items.Any())
    layoutPage.SecondColumnContentArea.Items.RemoveAt(0);

// Option 2: Set IsModified explicitly
layoutPage.SecondColumnContentArea.Items.Clear();
layoutPage.SecondColumnContentArea.IsModified = true;
```

→ Source: [Programmatically move ContentAreaItem](/raw/Programmatically%20move%20ContentAreaItem%20from%20one%20Content%20Area%20to%20other%20Content%20Area.md)

### List Block Property Migration

**Strategy:** Hide the old property instead of removing it — keeps data accessible during migration.

```cs
[Display(Name = "New Field Name")]
[MaxElements(20)]
public virtual IList<MyNewBlock>? NewField { get; set; }

[Obsolete("Remove after prod migration is complete.")]
[ScaffoldColumn(false)]  // hides from CMS editor UI
public virtual ThirdPartyPackageProperty? OldField { get; set; }
```

Create a `MigrationStep` that **swallows the first-run exception** (new property doesn't exist yet on first startup). On second startup, migration executes successfully.

Key services: `IContentTypeRepository`, `IContentModelUsage`, `IContentRepository`.

→ Source: [Working Programmatically With List Block properties](/raw/Working%20Programmatically%20With%20List%20Block%20properties.md)

---

## Catalog Operations

### Migrating Catalog Content Properties

Safe approach: traverse catalog recursively via batched loading (avoid direct DB manipulation).

```cs
public virtual IEnumerable<T> GetEntriesRecursive<T>(
    ContentReference parentLink, CultureInfo defaultCulture)
    where T : EntryContentBase
{
    foreach (var node in LoadChildrenBatched<NodeContent>(parentLink, defaultCulture))
        foreach (var entry in GetEntriesRecursive<T>(node.ContentLink, defaultCulture))
            yield return entry;

    foreach (var entry in LoadChildrenBatched<T>(parentLink, defaultCulture))
        yield return entry;
}
```

Use case: changing a property type (e.g., `Money` → `Decimal`) by reading old values and writing new ones.

→ Source: [Migrate Catalog content properties – Quan Mai's blog](/raw/Migrate%20Catalog%20content%20properties%20%E2%80%93%20Quan%20Mai%27s%20blog.md)

---

## SQL Debugging

### Query a Property Across All Content Instances

Useful for debugging or one-time reporting — not for production code.

1. Find the content type's PK: Admin → Content Types → (type name in URL)
2. Get the property PK:
   ```sql
   SELECT * FROM tblPropertyDefinition WHERE fkContentTypeID = <type_pk>
   ```
3. Use the property PK to join against `tblPropertyData`

→ Source: [Getting all content of a specific property with a simple SQL script](/raw/Getting%20all%20content%20of%20a%20specific%20property%20with%20a%20simple%20SQL%20script%20-%20Blogs%20-%20Pe....md)

---

## Production Operations

### Download Blob Assets from Production (DXP / CMS 11)

For syncing production images to a local dev environment:

1. Get **Project ID** from the PAAS Portal URL
2. Generate an **API Key + Secret** in the API tab → "Add API Credentials" → select Production
3. Install the EpiCloud PowerShell module:
   ```powershell
   Install-Module -Name EpiCloud
   ```
4. Use module commands to pull blob storage locally

→ Source: [Download Blob items from Production](/raw/Download%20Blob%20items%20from%20Production.md)

---

## Monitoring & Audit

### Identifying Spike Requests in Application Insights

1. **Metrics** → Server response time → Split by `cloud_RoleInstance` → Narrow to ~30-min UTC window
2. Note the offending instance ID and UTC time range
3. **Logs → KQL** to extract slow requests:
   ```kql
   union isfuzzy=true requests
   | where cloud_RoleInstance in ("INSTANCE")
   | order by duration desc
   | take 100
   | project timestamp, id, name, url, duration, performanceBucket
   ```
4. **Transaction Search** → filter by instance + time range → drill into specific request traces

→ Source: [Identifying Spike Requests and Issues in Application Insights](/raw/Identifying%20Spike%20Requests%20and%20Issues%20in%20Application%20Insights/Identifying%20Spike%20Requests%20and%20Issues%20in%20Application%20Insights.md)

### Automated Content Audit System (CMS 12)

Build a custom scheduled audit to address: limited page visibility, publishing confusion, lifecycle drift, change tracking, and CSV export needs.

**Use cases:**
- Scheduled report export (title, URL, author, last-modified → CSV)
- Metadata validation (missing Title, Description, Keywords)
- Expired/archived content detection
- Long-standing draft identification
- SEO URL health checks

→ Source: [Automated Page Audit for Large Content Sites in Optimizely](/raw/Automated%20Page%20Audit%20for%20Large%20Content%20Sites%20in%20Optimizely/Automated%20Page%20Audit%20for%20Large%20Content%20Sites%20in%20Optimizely.md)
