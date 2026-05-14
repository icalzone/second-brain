C# Razor Syntax Quick Reference
Tuesday, August 30, 2016

Clipped from: <http://haacked.com/archive/2011/01/06/razor-syntax-quick-reference.aspx/>

I gave a presentation to another team at Microsoft yesterday on ASP.NET MVC and the Razor view engine and someone asked if there was a reference for the Razor syntax.
It turns out, there is a pretty [good guide about Razor](http://www.asp.net/webmatrix/tutorials/2-introduction-to-asp-net-web-programming-using-the-razor-syntax) available, but it’s focused on covering the basics of web programming using Razor and inline pages and not just the Razor syntax.
So I thought it might be handy to write up a really concise quick reference about the Razor syntax.

<table>
<colgroup>
<col style="width: 41%" />
<col style="width: 58%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><strong>Syntax/Sample</strong></th>
<th style="text-align: center;"><strong>Razor</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>Code Block</td>
<td>@{<br />
int x = 123;<br />
string y = "because.";<br />
}</td>
</tr>
<tr>
<td>Expression (Html Encoded)</td>
<td><a href="mailto:%3cspan%3e@model.Message%3c/span">&lt;span&gt;@model.Message&lt;/span</a>&gt;</td>
</tr>
<tr>
<td>Expression (Unencoded)</td>
<td>&lt;span&gt;<br />
@Html.Raw(model.Message)<br />
&lt;/span&gt;</td>
</tr>
<tr>
<td>Combining Text and markup</td>
<td>@foreach(var item in items) {<br />
<a href="mailto:%3cspan%3e@item.Prop%3c/span">&lt;span&gt;@item.Prop&lt;/span</a>&gt;<br />
}</td>
</tr>
<tr>
<td>Mixing code and Plain text</td>
<td>@if (foo) {<br />
&lt;text&gt;Plain Text&lt;/text&gt;<br />
}</td>
</tr>
<tr>
<td>Using block</td>
<td>@using (Html.BeginForm()) {<br />
&lt;input type="text" value="input here"&gt;<br />
}</td>
</tr>
<tr>
<td>Mixing code and plain text (alternate)</td>
<td>@if (foo) {<br />
@:Plain Text is @bar<br />
}</td>
</tr>
<tr>
<td>Email Addresses</td>
<td>Hi <a href="mailto:philha@example.com">philha@example.com</a></td>
</tr>
<tr>
<td>Explicit Expression</td>
<td>&lt;span&gt;ISBN@(isbnNumber)&lt;/span&gt;</td>
</tr>
<tr>
<td>Escaping the @ sign</td>
<td>&lt;span&gt;In Razor, you use the<br />
@@foo to display the value<br />
of foo&lt;/span&gt;</td>
</tr>
<tr>
<td>Server side Comment</td>
<td>@*<br />
This is a server side<br />
multiline comment<br />
*@</td>
</tr>
<tr>
<td>Calling generic method</td>
<td>@(MyClass.MyMethod&lt;AType&gt;())</td>
</tr>
<tr>
<td>Creating a Razor Delegate</td>
<td>@{<br />
Func&lt;dynamic, object&gt; b =<br />
@&lt;strong&gt;@item&lt;/strong&gt;;<br />
}<br />
@b("Bold this")</td>
</tr>
<tr>
<td>Mixing expressions and text</td>
<td>Hello @title. @name.</td>
</tr>
<tr>
<td><em><strong>NEW IN RAZOR v2.0/ASP.NET MVC 4</strong></em></td>
<td></td>
</tr>
<tr>
<td>Conditional attributes</td>
<td>&lt;div class="@className"&gt;&lt;/div&gt;</td>
</tr>
<tr>
<td>Conditional attributes with other literal values</td>
<td>&lt;div class="@className foo bar"&gt;<br />
&lt;/div&gt;</td>
</tr>
<tr>
<td>Conditional data-* attributes.<br />
<br />
data-* attributes are always rendered.</td>
<td>&lt;div data-x="@xpos"&gt;&lt;/div&gt;</td>
</tr>
<tr>
<td>Boolean attributes</td>
<td>&lt;input type="checkbox"<br />
checked="@isChecked" /&gt;</td>
</tr>
<tr>
<td>URL Resolution with tilde</td>
<td>&lt;script src="~/myscript.js"&gt;<br />
&lt;/script&gt;</td>
</tr>
</tbody>
</table>
