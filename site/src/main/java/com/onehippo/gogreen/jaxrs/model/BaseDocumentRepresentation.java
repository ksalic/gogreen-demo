/*
 *  Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.jaxrs.model;

import javax.jcr.RepositoryException;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlElements;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.ArrayUtils;
import org.hippoecm.hst.jaxrs.model.content.HippoDocumentRepresentation;

import com.onehippo.gogreen.beans.BaseDocument;

/**
 * @version $Id$
 */
@XmlRootElement(name = "basedocument")
public class BaseDocumentRepresentation extends HippoDocumentRepresentation {

    private String [] campaigns;

    public BaseDocumentRepresentation represent(BaseDocument bean) throws RepositoryException {
        super.represent(bean);
        this.campaigns = (String[]) ArrayUtils.clone(bean.getCampaigns());
        return this;
    }

    @XmlElementWrapper(name="campaigns")
    @XmlElements(@XmlElement(name="campaign"))
    public String[] getCampaigns() {
        return campaigns;
    }

    public void setCampaigns(String[] campaigns) {
        this.campaigns = campaigns;
    }

}
