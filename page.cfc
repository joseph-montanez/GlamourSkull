<cfscript>
component accessors="true" {
    property string title = "";
    property string description = "";
    property string keywords = "";
    property string data = "";

    public Page function init() hint = "Constructor"
    {
        return this;
    }

    public void function setData(string data) {
        this.data = data;
    }

    public string function getData() {
        return this.data;
    }

    public void function setDescription(string description) {
        this.description = description;
    }

    public string function getDescription() {
        return this.description;
    }

    public void function setTitle(string title) {
        this.title = title;
    }

    public string function getTitle() {
        return this.title;
    }

    public void function setKeywords(string keywords) {
        this.keywords = keywords;
    }

    public string function getKeywords() {
        return this.keywords;
    }
}
</cfscript>