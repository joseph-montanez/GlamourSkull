<div style="width: 954px; padding: 1em 0 0 0; margin: 0 auto; text-align: left;" id="container">
    <h1 class="item-name">Resin Jewelry</h1>
    <div class="" style="padding-top: 0px">
        <div style="float: left; width: 150px" id="categories">
            <h3 style="margin-top: 0px; color: #000000; font: bold 13px/18px Arial,Helvetica,sans-serif; text-transform: uppercase;">CATEGORIES</h3>
            <ul style="padding-left: 0px; list-style: none;">
                <li style="background: url(&quot;images/parent-point.gif&quot;) no-repeat scroll 0 9px transparent; padding-left: 16px">
                    <a style="color: #817A7A; font: 13px/16px Arial,Helvetica,sans-serif;" href="store/store/resin-jewelry">
                        Resin Jewelry
                    </a>
                </li>
                <li style="background: url(&quot;images/list-marker.gif&quot;) no-repeat scroll 0 7px transparent; padding-left: 16px">
                    <a style="color: #817A7A; font: 13px/16px Arial,Helvetica,sans-serif;" href="store/store/resin-rings">
                    Resin Rings
                    </a>
                </li>
                <li style="background: url(&quot;images/list-marker.gif&quot;) no-repeat scroll 0 7px transparent; padding-left: 16px">
                    <a style="color: #817A7A; font: 13px/16px Arial,Helvetica,sans-serif;" href="store/store/resin-necklaces">
                        Resin Necklaces
                    </a>
                </li>
                <li style="background: url(&quot;images/list-marker.gif&quot;) no-repeat scroll 0 7px transparent; padding-left: 16px">
                    <a style="color: #817A7A; font: 13px/16px Arial,Helvetica,sans-serif;" href="store/store/resin-magnets">
                        Resin Magnets
                    </a>
                </li>
                <li style="background: url(&quot;images/list-marker.gif&quot;) no-repeat scroll 0 7px transparent; padding-left: 16px">
                    <a style="color: #817A7A; font: 13px/16px Arial,Helvetica,sans-serif;" href="store/products/rose-pen">
                        Rose Pens
                    </a>
                </li>
            </ul>
        </div>
        <div style="width: 804px; float: left;">
            <cfoutput>
            <cfloop collection="#prods.products#" item="key">
                <cfset product="#products[key]#" />
                <div class="item-display-cont">
                    <a class="item-display" href="store/products/#key#">
                        <img border="0" width="258" src="#product.images[1]#.small.jpg">
                    </a>
                    <h3>#product.name#</h3>
                </div>
            </cfloop>
            </cfoutput>
        </div>
        <br clear="left">
        <p style="padding-top: 0px">
            GlamourSkull is a new business that will be focusing on some rockabilly jewelry, cameo necklaces, and decoden cellphone cases. Everything is hand made by us, and come from our brain.</p><p><em>*We reserve the right to change our prices at any time. We reserve the right to refuse service to anyone.*</em></p><p>While there are many items available for immediate purchase, most of our items are "custom" and therefore made to order. Please message and let me know your order. If it is for a phone case then dont forget to include the make and model of your phone. We do all sorts, Phone Cases, iPod Cases, DS cases, Jewellery, and much more. Please look through our photo albums for some items i have made for other customers or if there is anything you dont see but would like to request, please don't hesitate to get in contact. We look forward to hearing from you.
        </p>
        <br>
    </div>
</div>