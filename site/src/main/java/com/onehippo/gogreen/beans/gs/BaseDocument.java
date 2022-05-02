/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.gs;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.repository.api.HippoNode;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import java.util.Calendar;

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = "myproject:basedocument")
public class BaseDocument extends HippoDocument {

    public static final Logger log = LoggerFactory.getLogger(BaseDocument.class);


    public String getLastModifiedBy() {
        return getSingleProperty("hippostdpubwf:lastModifiedBy");
    }

    public String getCreatedBy() {
        return getSingleProperty("hippostdpubwf:createdBy");
    }

    public Calendar getLastModificationDate() {
        return getSingleProperty("hippostdpubwf:lastModificationDate");
    }

    public Calendar getCreationDate() {
        return getSingleProperty("hippostdpubwf:creationDate");
    }

    public Calendar getPublicationDate() {
        return getSingleProperty("hippostdpubwf:publicationDate");
    }


}
