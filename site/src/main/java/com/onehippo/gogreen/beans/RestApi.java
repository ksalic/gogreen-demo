/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

/*

[hippogogreen:restapi] > hippogogreen:basedocument
- hippogogreen:type (string)
- hippogogreen:summary (string)
+ hippogogreen:documentation (hippostd:html)
- hippogogreen:url (string)
- hippogogreen:response (string)
- hippogogreen:path (string)

*/
@Node(jcrType = "hippogogreen:restapi")
public class RestApi extends BaseDocument {

    private String path;

    private String type;
    private String summary;
    private HippoHtml documentation;
    private String url;
    private String response;


    public String getApiPath() {
        return (path == null) ? (String) getProperty("hippogogreen:path") : path;
    }

    public String getType() {
        return (type == null) ? (String) getProperty("hippogogreen:type") : type;
    }

    public String getSummary() {
        return (summary == null) ? (String) getProperty("hippogogreen:summary") : summary;
    }

    public HippoHtml getDocumentation() {
        if (documentation ==null){
            documentation  =  getBean("hippogogreen:documentation");
        }
        return documentation ;
    }

    public String getUrl() {
        return (url == null) ? (String) getProperty("hippogogreen:url") : url;
    }

    public String getResponse() {
        return (response == null) ? (String) getProperty("hippogogreen:response") : response;
    }

}
