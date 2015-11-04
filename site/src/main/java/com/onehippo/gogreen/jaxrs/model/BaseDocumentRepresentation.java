/*
 *  Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 * 
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 * 
 *       http://www.apache.org/licenses/LICENSE-2.0
 * 
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
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
