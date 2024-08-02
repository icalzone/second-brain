# CSS Notes

### Absolute position elements break out of overflow hidden
Instead of using overflow hidden on parent, use .clearfix inside at the bottom of the overflow:hidden element. This also gives element space in DOM and fixes padding that will not work on overflow:hidden element.

If overflow:hidden is needed on element, try position:relative on parent of element. This does not always work depending on nesting of divs.

### Example
<pre><code>
&lt;div id=&quot;grandparent&quot;&gt;&#13;&#10;    &lt;div id=&quot;parent&quot;&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;        &lt;p&gt;this has a lot of content which ...&lt;/p&gt;&#13;&#10;    &lt;/div&gt;&#13;&#10;    &lt;div id=&quot;child&quot;&gt;&#13;&#10;        dudes&#13;&#10;    &lt;/div&gt;    &#13;&#10;&lt;/div&gt;

#grandparent {&#13;&#10;    position: relative;&#13;&#10;    width: 150px;&#13;&#10;    height: 150px;&#13;&#10;    margin: 20px;&#13;&#10;    background: #d0d0d0;&#13;&#10;}&#13;&#10;#parent {&#13;&#10;    width: 150px;&#13;&#10;    height: 150px;&#13;&#10;    overflow:hidden;&#13;&#10;}&#13;&#10;#child {&#13;&#10;    position: absolute;&#13;&#10;    background: red;&#13;&#10;    color: white;&#13;&#10;    left: 100%;&#13;&#10;    top: 0;&#13;&#10;}
</code></pre>