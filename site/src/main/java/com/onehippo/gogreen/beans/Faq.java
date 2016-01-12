/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import com.onehippo.gogreen.beans.compound.Copyright;
import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

@Node(jcrType=Constants.NT_FAQ)
public class Faq extends BaseDocument {

    public String getQuestion() {
        return getProperty(Constants.PROP_QUESTION);
    }

    public HippoHtml getAnswer() {
        return getBean(Constants.PROP_ANSWER);
    }
    
    public Copyright getCopyright() {
        return getBean(Constants.PROP_COPYRIGHT);
    }
    
}
