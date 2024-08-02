# CSS Notes

### Absolute position elements break out of overflow hidden
Instead of using overflow hidden on parent, use .clearfix inside at the bottom of the overflow:hidden element. This also gives element space in DOM and fixes padding that will not work on overflow:hidden element.

If overflow:hidden is needed on element, try position:relative on parent of element. This does not always work depending on nesting of divs.

### Example
<pre><code>
&lt;div id=&quot;grandparent&quot;&gt;&#13;&#10;    &lt;div id=&quot;parent&quot;&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;    &lt;/div&gt;&#13;&#10;    &lt;div id=&quot;child&quot;&gt;&#13;&#10;        dudes&#13;&#10;    &lt;/div&gt;    &#13;&#10;&lt;/div&gt;
</code></pre>

<code>
#grandparent {
    position: relative;
    width: 150px;
    height: 150px;
    margin: 20px;
    background: #d0d0d0;
}
#parent {
    width: 150px;
    height: 150px;
    overflow:hidden;
}
#child {
    position: absolute;
    background: red;
    color: white;
    left: 100%;
    top: 0;
}
</code>