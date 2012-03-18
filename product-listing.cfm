<cfscript>
if (structKeyExists(url, "refresh")) {
    cacheDelete("products");
    cacheDelete("product-listing.cfm");
}

content = "";
if (!cacheKeyExists("product-listing.cfm")) {
    import products;
    import page;

    prods = new Products();
    products = prods.getProducts();

    page = new Page();
    page.setTitle("Resin Jewelry");
    page.setDescription("Resin Jewelry");

    savecontent variable="content" {
        include "templates/product-listing.cfm";
    }
    page.setData(content);
    savecontent variable="content" {
        include "templates/layout.cfm";
    }
    cachePut('product-listing.cfm', content);
} else {
    content = cacheGet('product-listing.cfm');
}

writeOutput(content);
</cfscript>