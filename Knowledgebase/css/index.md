# CSS Notes

### Absolute position elements break out of overflow hidden
Instead of using overflow hidden on parent, use .clearfix inside at the bottom of the overflow:hidden element. This also gives element space in DOM and fixes padding that will not work on overflow:hidden element.

If overflow:hidden is needed on element, try position:relative on parent of element. This does not always work depending on nesting of divs.

### Example
<code>
<div id="grandparent">
    <div id="parent">
        <p>this has a lot of content which ...</p>
        <p>this has a lot of content which ...</p>
        <p>this has a lot of content which ...</p>
        <p>this has a lot of content which ...</p>
        <p>this has a lot of content which ...</p>
        <p>this has a lot of content which ...</p>
        <p>this has a lot of content which ...</p>
    </div>
    <div id="child">
        dudes
    </div>    
</div>
</code>

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