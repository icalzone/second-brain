---
created: 2025-05-02T07:18:00 (UTC -04:00)
tags: []
source: https://world.optimizely.com/blogs/scott-reed/dates/2025/4/identifying-spike-requests-and-issues-in-application-insights/
author: 
---

# Identifying Spike Requests and Issues in Application Insights

> ## Excerpt
> Sometimes within the DXP we see specific Azure App Instances having request spikes causing performance degredation and we need to investigate. I find the performance tab often lacking to narrow down to the specifics of what I want to look at, so this helps me get to the bottom of things easily

---
Sometimes within the DXP we see specific Azure App Instances having request spikes causing performance degredation and we need to investigate. I find the performance tab often lacking to narrow down to the specifics of what I want to look at, so this helps me get to the bottom of things easily

Here's some of my easy steps to figure these out

**Step 1: Identify Instance**

Open Application Insights and navigate to the Monitoring -> Metrics area and set the following filters

Metric: Log-based metrics, Server response time, Avg aggregation

Split by: Cloud role instance

Set the time range (**IN UTC)** to when the issue occured and keep narrowing it in until you have a 30 minute or so window

![](https://world.optimizely.com/contentassets/9c2bea15842a4fc8afda7a3344890fc6/image25.png "Click image to zoom")

Make a note of the affending instance that's causing the issue, in our case **2a9f3a38c4ac** and the 10 minute time range (IN UTC) when the issue occured

**Step 2: Extract High Performance Bucket Requests**

Navigate to the Monitoring -> Logs area and set the following KQL, replacing the INSTANCE with your noted instance. Also in the run area set the time frame in UTC to the 10 minute range noted above

```
union isfuzzy=<span>true</span> requests
| <span><span>where</span> cloud_RoleInstance <span>in</span> (<span><span>"INSTANCE"</span></span>)
| order <span>by</span> duration desc
| take 100
| project timestamp, id, name, url, duration, performanceBucket</span>
```

This will give you a list you can export to CSV of high requests

![](https://world.optimizely.com/contentassets/9c2bea15842a4fc8afda7a3344890fc6/image28.png "Click image to zoom")

**Step 3: Viewing Request Details**

Now navigate to Investigate -> Transaction Search

Set the filter Event Types = Request and in the search copy and of the id values from our list and search. You can then open the request and drill in to dependency issues or profiler traces, in our case to see a slow Find query

![](https://world.optimizely.com/contentassets/9c2bea15842a4fc8afda7a3344890fc6/image29.png "Click image to zoom")
