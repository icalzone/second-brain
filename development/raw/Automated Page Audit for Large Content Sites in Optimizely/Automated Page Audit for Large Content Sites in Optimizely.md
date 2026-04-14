---
created: 2025-10-23T07:31:12 (UTC -04:00)
tags: []
source: https://world.optimizely.com/blogs/sanjay-katiyar/dates/2025/10/content-management-audit-system-a-comprehensive-guide/
author: 
---

# Automated Page Audit for Large Content Sites in Optimizely

> ## Excerpt
> Large content sites often face significant challenges in maintaining visibility and control over thousands of pages. Content managers struggle to track publishing status, identify outdated or unpublished content, and ensure overall content quality. Without automation, auditing becomes time-consuming, error-prone, and inefficient, creating risks in governance, compliance, and user experience.

---
Large content sites often face significant challenges in maintaining visibility and control over thousands of pages. Content managers struggle to track publishing status, identify outdated or unpublished content, and ensure overall content quality. Without automation, auditing becomes time-consuming, error-prone, and inefficient, creating risks in governance, compliance, and user experience.

Managing content at enterprise scale is difficult because:

-   **Limited Visibility** – No consolidated view of all site content.
    
-   **Publishing Confusion** – Hard to track what is published, unpublished, or pending.
    
-   **Lifecycle Issues** – Identifying outdated or expired content requires manual checks.
    
-   **Change Tracking** – Monitoring edits across thousands of pages is resource-intensive.
    
-   **Data Exporting** – Manual CSV exports are slow, error-prone, and not scalable.
    
-   **High Effort** – Auditing consumes substantial IT and administrative time.
    

**Use Cases:**

      **1. Scheduled Report Export:** 

Extend the reports feature by integrating a scheduled job that automatically exports selected page and content data (e.g., title, URL, author, last modified date) into a structured CSV or Excel format for content audit and review.

**2\. Metadata Validation and Updates**

Identify and update missing or incomplete metadata (e.g., Title, Description, or Keywords) for published pages to maintain content accuracy, SEO compliance, and adherence to governance standards.

**3\. Expired or Archived Content**

Detect and list archived or expired pages that are no longer active or relevant, enabling content teams to clean up and improve site performance and user experience.

**4\. Long-standing Draft Pages**

Highlight draft pages that have been sitting unpublished for an extended period. This helps content managers review, update, or remove outdated drafts to ensure content freshness.

**5\. SEO-friendly Simplified URLs**

Automate updates to simple addresses (SEO-friendly URLs) to ensure consistency with naming conventions and improve search visibility.

**6\. Approved but Unpublished Pages**

Identify pages that have been approved by authors or editors but not yet published, allowing administrators to review and publish them efficiently.

**Solution**

A custom **PageReportsJob** automates page auditing for large content sites. It generates CSV reports that give administrators and content managers an overview of content structure, publishing status, and updates.

  
We solves these issues with an automated job process that:

-   Automatically scans and identifies all content types and statuses.
-   Generates standardized CSV reports for consistency.
-   Efficiently processes large datasets using paging and async execution.
-   Provides near real-time insights on content status and updates.
-   Secures access with role-based permissions.

```
<span>using</span> EPiServer.Logging;
<span>using</span> EPiServer.PlugIn;
<span>using</span> EPiServer.Scheduler;
<span>using</span> EPiServer.Security;
<span>using</span> EPiServer.ServiceLocation;
<span>using</span> EPiServer.Web;
<span>using</span> Microsoft.Extensions.Options;
<span>using</span> Nito.AsyncEx;
<span>using</span> MyCompany.Web.Features.Reports.ExistingPages.Models;
<span>using</span> MyCompany.Web.Infrastructure.Cms;
<span>using</span> MyCompany.Web.Infrastructure.Cms.Settings;
<span>using</span> <span>static</span> MyCompany.Web.Features.Core.Constants.CommonConstants;

<span>namespace</span> <span>MyCompany.Web.Features.Jobs</span>
{
    [<span>ScheduledPlugIn(
        DisplayName = <span>"Page Report Job "</span>,
        Description = <span>"Exports existing pages to CSV for administrators and content managers"</span>,
        IntervalType = ScheduledIntervalType.None,
        SortIndex = -1004 + 'D')</span>]
    <span>public</span> <span>class</span> <span>PageReportJob</span> : <span>ScheduledJobBase</span>
    {
        <span>private</span> <span>readonly</span> ILogger _logger;
        <span>private</span> <span>readonly</span> IMediaFileService _mediaFileService;
        <span>private</span> <span>readonly</span> IContentRepository _contentRepository;
        <span>private</span> <span>readonly</span> IContentReportQueryService _contentReportQueryService;
        <span>private</span> <span>readonly</span> IContentVersionRepository _contentVersionRepository;
        <span>private</span> <span>readonly</span> ISettingsService _settingsService;
        <span>private</span> <span>readonly</span> ExistingPagesReportOptions _options;

        <span>private</span> <span>bool</span> _stopSignaled;

        <span><span>public</span> <span>PageReportJob</span> (<span>
            IMediaFileService mediaFileService,
            IContentRepository contentRepository,
            IContentReportQueryService contentReportQueryService,
            IContentVersionRepository contentVersionRepository,
            ISettingsService settingsService,
            IOptions&lt;ExistingPagesReportOptions&gt; options</span>)</span>
        {
            _mediaFileService = mediaFileService;
            _contentRepository = contentRepository;
            _contentReportQueryService = contentReportQueryService;
            _contentVersionRepository = contentVersionRepository;
            _settingsService = settingsService;
            _options = options?.Value ?? <span>new</span> ExistingPagesReportOptions();
            _logger = LogManager.GetLogger();
            IsStoppable = <span>true</span>;
        }

        <span><span>public</span> <span>override</span> <span>void</span> <span>Stop</span>(<span></span>)</span> =&gt; _stopSignaled = <span>true</span>;

        <span><span>public</span> <span>override</span> <span>string</span> <span>Execute</span>(<span></span>)</span>
        {
            <span>try</span>
            {
                <span>return</span> AsyncContext.Run(GenerateReports);
            }
            <span>catch</span> (Exception ex)
            {
                _logger.Error(ex.StackTrace);
                <span>return</span> <span>"The job stopped due to an exception."</span>;
            }
        }

        <span><span>private</span> <span>async</span> Task&lt;<span>string</span>&gt; <span>GenerateReports</span>(<span></span>)</span>
        {
            <span>var</span> reportQueryTypes = Enum.GetValues(<span>typeof</span>(ContentReportQueryType))
                .Cast&lt;ContentReportQueryType&gt;()
                .Select(v =&gt; v.ToString())
                .ToList();

            <span>// Adding a custom query type</span>
            reportQueryTypes.Add(<span>"NotPublishedPages"</span>);

            <span>foreach</span> (<span>var</span> reportQueryType <span>in</span> reportQueryTypes)
            {
                <span>if</span> (_stopSignaled) <span>break</span>;
                <span>await</span> CreateReport(reportQueryType);
            }

            <span>return</span> <span>"Exported all pages successfully."</span>;
        }

        <span><span>private</span> <span>async</span> Task <span>CreateReport</span>(<span><span>string</span> reportQueryType</span>)</span>
        {
            <span>try</span>
            {
                _logger.Information(<span>$"Starting report creation for type '<span>{reportQueryType}</span>'."</span>);

                <span>var</span> csvFolderPath = _mediaFileService.GetOrCreateFolder(
                    ExistingPageReportTypes.FolderName,
                    SiteDefinition.Current.SiteAssetsRoot);

                <span>var</span> pageCollection = <span>await</span> SetPagesByTypeOfQuery(reportQueryType);

                <span>var</span> pages = pageCollection
                    .Select(x =&gt; ExistingPageViewModel.Make(
                        x, 
                        _contentVersionRepository.List(x.ContentLink).Where(v =&gt; v.LanguageBranch == x.Language?.Name)))
                    .Where(x =&gt; !<span>string</span>.IsNullOrWhiteSpace(x.Url))
                    .ToList();

                <span>var</span> fileName = <span>$"<span>{ExistingPageReportTypes.PrefixFileName}</span>_<span>{reportQueryType.ToLower()}</span>"</span>;
                <span>var</span> media = _mediaFileService.SaveFile(
                    fileName,
                    ExistingPageReportTypes.FileExtension,
                    csvFolderPath,
                    <span>new</span> <span>byte</span>[<span>0</span>]);

                _mediaFileService.WriteCsv(media, pages);
                _contentRepository.Save(media, SaveAction.Publish, AccessLevel.NoAccess);

                _logger.Information(<span>$"Report '<span>{fileName}</span>' created and published with <span>{pages.Count}</span> rows."</span>);
            }
            <span>catch</span> (Exception ex)
            {
                _logger.Error(<span>$"Error in CreateReport for type '<span>{reportQueryType}</span>': <span>{ex}</span>"</span>);
                <span>throw</span>;
            }
        }

        <span>private</span> <span>async</span> Task&lt;PageDataCollection?&gt; SetPagesByTypeOfQuery(<span>string</span> typeOfQuery)
        {
            <span>var</span> retryCounter = <span>0</span>;
            <span>do</span>
            {
                <span>try</span>
                {
                    <span>return</span> <span>await</span> ReadPageDataCollection(typeOfQuery);
                }
                <span>catch</span> (Exception ex)
                {
                    retryCounter++;
                    _logger.Warning(<span>$"Error in SetPagesByTypeOfQuery (attempt <span>{retryCounter}</span>) for query '<span>{typeOfQuery}</span>': <span>{ex}</span>"</span>);
                }
            }
            <span>while</span> (retryCounter &lt; <span>3</span>);

            _logger.Error(<span>$"Failed to get pages by type of query '<span>{typeOfQuery}</span>' after 3 attempts."</span>);
            <span>return</span> <span>null</span>;
        }

        <span><span>private</span> <span>async</span> Task&lt;PageDataCollection&gt; <span>ReadPageDataCollection</span>(<span><span>string</span> typeOfQuery</span>)</span>
        {
            <span>const</span> <span>int</span> MaximumRows = <span>50</span>;
            <span>int</span> receivedRecords, pageNumber = <span>0</span>;

            <span>var</span> queryType = <span>string</span>.Equals(<span>"NotPublishedPages"</span>, typeOfQuery, StringComparison.OrdinalIgnoreCase)
                ? <span>"ReadyToPublish"</span>
                : typeOfQuery;

            <span>var</span> typeEnum = GetType(queryType);

            <span>var</span> startDate = (typeEnum == ContentReportQueryType.Changed &amp;&amp; _options?.ChangedWindowDays <span>is</span> <span>int</span> days &amp;&amp; days &gt; <span>0</span>)
                ? DateTime.Now.AddDays(-days)
                : <span>new</span> DateTime(<span>1900</span>, <span>1</span>, <span>1</span>);

            <span>if</span> (typeEnum == ContentReportQueryType.Changed)
            {
                _logger.Information(<span>$"Using ChangedWindowDays of <span>{_options.ChangedWindowDays}</span>, start date <span>{startDate:yyyy-MM-dd}</span>"</span>);
            }

            <span>var</span> query = <span>new</span> ContentReportQuery
            {
                Root = ContentReference.StartPage,
                StartDate = startDate,
                EndDate = DateTime.Now,
                PageSize = <span>1</span>,
                PageNumber = pageNumber,
                TypeOfQuery = typeEnum,
                IsReadyToPublish = <span>string</span>.Equals(<span>"ReadyToPublish"</span>, typeOfQuery, StringComparison.OrdinalIgnoreCase)
            };

            <span>var</span> totalRecords = <span>await</span> Task.Run(() =&gt;
            {
                _contentReportQueryService.Get(query, <span>out</span> <span>int</span> outRows);
                <span>return</span> outRows;
            });

            <span>var</span> pageDataCollection = <span>new</span> PageDataCollection(totalRecords);

            <span>do</span>
            {
                query.PageNumber = pageNumber;
                query.PageSize = MaximumRows;

                <span>var</span> enumerable = <span>await</span> Task.Run(() =&gt; _contentReportQueryService.Get(query, <span>out</span> <span>int</span> _));
                <span>foreach</span> (ContentReference item <span>in</span> enumerable)
                {
                    <span>if</span> (_contentRepository.Get&lt;IContent&gt;(item) <span>is</span> PageData page)
                    {
                        pageDataCollection.Add(page);
                    }
                }

                pageNumber++;
                receivedRecords = MaximumRows * pageNumber + <span>1</span>;
            }
            <span>while</span> (totalRecords &gt; receivedRecords);

            _logger.Information(<span>$"Retrieved <span>{pageDataCollection.Count}</span> pages for query type '<span>{typeOfQuery}</span>'."</span>);

            <span>var</span> filtered = ApplyGuards(pageDataCollection, typeEnum, typeOfQuery);
            <span>return</span> <span>new</span> PageDataCollection(filtered);
        }

        <span><span>private</span> IEnumerable&lt;PageData&gt; <span>ApplyGuards</span>(<span>IEnumerable&lt;PageData&gt; items, ContentReportQueryType type, <span>string</span> typeOfQuery</span>)</span>
        {
            <span>var</span> now = DateTime.Now;

            <span>return</span> type <span>switch</span>
            {
                ContentReportQueryType.Published =&gt; items.Where(p =&gt;
                    p.CheckPublishedStatus(PagePublishedStatus.Published) &amp;&amp;
                    p.StartPublish &lt;= now &amp;&amp;
                    (!p.StopPublish.HasValue || p.StopPublish &gt; now)),

                ContentReportQueryType.ReadyToPublish <span>when</span> 
                    <span>string</span>.Equals(typeOfQuery, <span>"NotPublishedPages"</span>, StringComparison.OrdinalIgnoreCase) =&gt;
                    items.Where(p =&gt; (!p.StopPublish.HasValue || p.StopPublish &gt; now) &amp;&amp; (!p.StartPublish.HasValue || p.StartPublish &gt; now)),

                ContentReportQueryType.ReadyToPublish =&gt; items,
                ContentReportQueryType.Expired =&gt; items.Where(p =&gt; p.StopPublish.HasValue &amp;&amp; p.StopPublish.Value &lt;= now),
                ContentReportQueryType.Changed =&gt; items,
                ContentReportQueryType.SimpleAddress =&gt; items.Where(p =&gt; !<span>string</span>.IsNullOrWhiteSpace(p.URLSegment)),

                _ =&gt; items
            };
        }

        <span><span>private</span> ContentReportQueryType <span>GetType</span>(<span><span>string</span> type</span>)</span> =&gt;
            type <span>switch</span>
            {
                <span>"Published"</span> =&gt; ContentReportQueryType.Published,
                <span>"ReadyToPublish"</span> =&gt; ContentReportQueryType.ReadyToPublish,
                <span>"Expired"</span> =&gt; ContentReportQueryType.Expired,
                <span>"Changed"</span> =&gt; ContentReportQueryType.Changed,
                <span>"SimpleAddress"</span> =&gt; ContentReportQueryType.SimpleAddress,
                _ =&gt; ContentReportQueryType.Published
            };
    }
}
```

 The system automatically generates six types of page reports: Published, Not Published, Ready to Publish, Expired, Changed, and Simple Address Pages.

🧾 **Example: Page Audit Report (CSV Output)**

![](https://world.optimizely.com/contentassets/3b83ba9828134340b3a8068a48fad7e1/image31.png "Click image to zoom")

**Conclusion:**  
The **PagesAuditJob** represents a robust, enterprise-grade solution for content auditing and reporting. Its combination of scheduled automation, web interface accessibility, and comprehensive reporting capabilities makes it an essential tool for maintaining content quality and governance standards in Optimizely content management system.

Hope this post helps you strengthen and streamline your page audit process.

Cheers! 🥂

Oct 06, 2025
