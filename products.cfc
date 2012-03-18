<cfscript>
component {
    property struct products = structNew();

    public Products function init() hint = "Constructor"
    {
        return this;
    }


    public void function createThumbnail(original, destination, size) {
        writeOutput("Scaling: " & destination & "<br />");
        image = ImageRead(original);
        imageScaleToFit(image, width, height);
        imageWrite(image, destination, 0.75);
    }

    public struct function getProducts() hint = "Get All Products"
    {
        if (!cacheKeyExists('products')) {
            productFiles = directoryList("./products", false, "query");
            products = StructNew();
            for (i = 1; i <= productFiles.Recordcount; i = i + 1) {
                fileName = productFiles["name"][i];
                key = listToArray(fileName, ".")[1];
                directory = productFiles["directory"][i];
                if (!FindNoCase(".json", fileName) or FindNoCase("~", fileName)) {
                    continue;
                }
                jsonData = fileRead(directory & "/" & fileName);
                try {
                    item = deserializeJSON(jsonData);
                    structInsert(products, key, item);

                    if (structKeyExists(item, "images")) {
                        if (isArray(item.images)) {
                            for (n = 1; n <= ArrayLen(item.images); n++) {
                                imagePath = item.images[n];
                                smallImagePath = imagePath & '.small.jpg';
                                tinyImagePath = imagePath & '.tiny.jpg';
                                sizes = [[smallImagePath, 420], [tinyImagePath, 131]];
                                for (j = 1; j <= ArrayLen(sizes); j++) {
                                    size = sizes[j];
                                    thumbnailName = size[1];
                                    width = size[2];
                                    height = size[2];
                                    if (!fileExists(thumbnailName)) {
                                        this.createThumbnail(imagePath, thumbnailName, width);
                                    }
                                }
                            }
                        }
                    }
                }
                catch (any e) {
                    if (e.type == "java.lang.OutOfMemoryError") {
                        writeOutput("Please upload a smaller image <br />");
                    } else {
                        //Write an email or log error?
                        writeDump(e);
                    }
                }
            }
            cachePut('products', products);
        } else {
            products = cacheGet('products');
        }

        this.products = products;

        return products;
    }
}
</cfscript>