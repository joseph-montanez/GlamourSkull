<!DOCTYPE html>
<html>
<head>
    <cfoutput>
    <cfparam name="pageDescription" default="">
    <cfparam name="pageKeywords" default="">
    <cfparam name="pageTitle" default="">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="description" content="#pageDescription#"/>
    <meta name="keywords" content="#pageKeywords#"/>
    <title>#pageTitle#</title>
    <link href="#application.siteurl#/css/style.css" rel="stylesheet" type="text/css" />
    </cfoutput>
    <style type="text/css">
        #menu-bar {
            background: #272727;
        }
        #menu-container {
            width: 954px; 
            margin: 0 auto; 
            text-align: left;
        }
        #menu {
            list-style: none outside none; 
            margin: 0 0 0 -15px; 
            overflow: hidden; 
            padding: 7px 0 7px 0;
            width: 620px;
            float: left;
        }
        .menu-item {
            float: left; 
            font: 13px/18px Arial,Helvetica,sans-serif; 
            margin: 0; 
            padding: 0 19px 0 20px; 
            text-transform: uppercase; 
            width: auto;
            border-right: 1px solid white;
        }
        .menu-item:last-child {
            border-right: none;
        }
        .menu-link {
            text-decoration: normal;  
            background: none repeat scroll 0 0 transparent; 
            color: #FFFFFF; 
            display: block; 
            padding: 0 0 0px;
        }
        .menu-link.active {
            text-decoration: underline; 
        }
        .clear {
            height: 0px;
            line-height: 0px;
            font-size: 0px;
            clear: left;
        }
        #search-bar {
            padding-top: 6px;
            width: 205px;
            float: left;
            margin-left: 140px;
        }
        #search-text {
            color: white; 
            font: normal 11px/13px Arial, Helvetica, sans-serif; 
            float: left; 
            text-transform: none; 
            margin: 3px 6px 0 0;
        }
        #search-box {
            color: #333; 
            background: #fff; 
            width: 110px; 
            height: 21px; 
            padding: 0; 
            margin: 0; 
            border: none; 
            border-radius: 5px; 
            display: block; 
            float: left; 
            padding: 0 5px; 
            margin-right: 5px
        }
        #search-button {
            color: #fff; 
            background: #950b89; 
            width: 32px; 
            height: 21px; 
            border: none; 
            border-radius: 5px; 
            display: block; 
            float: left;
        }
    </style>
</head>
<body>
    <div id="page-header" style="height: 165px; overflow: hidden; width: 954px; padding: 0 0 0 0; margin: 0 auto; text-align: left;">
        <img src="<cfoutput>#application.siteurl#</cfoutput>/images/_kandy.png" style="padding: 0.25em; vertical-align: top;" />
        <span style='line-height: 4em; font-size: 4em; color: #999'>
            Glamour
            <span style="color: #ccc;">Skull</span>
        </span>
    </div> <!--- page-header ---->
    <div id="menu-bar">
        <div id="menu-container">
            <ul id="menu">
                <li class="menu-item">
                    <a class="menu-link active" href=""> 
                        <span>Online Store</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a class="menu-link" href=""> 
                        <span>Custom Resin / Bling Cases</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a class="menu-link" href="http://www.facebook.com/GlamourSkull"> 
                        <span>Facebook</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a class="menu-link" href="contact.cfm"> 
                        <span>Contact Us</span>
                    </a>
                </li>
            </ul> <!--- #menu ---->
            <div id="search-bar">
                <div id="search-text">Search:</div>
                <input type="text" value="" placeholder="terms or keywords" id="search-box" />
                <input type="submit" value="Go" id="search-button" />
                <div class="clear"></div>
            </div> <!--- #search-bar ---->
            <div class="clear"></div>
        </div> <!--- #menu-container ---->
    </div> <!--- #menu-bar ---->