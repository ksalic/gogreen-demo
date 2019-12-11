/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import java.util.Calendar;

import javax.jcr.RepositoryException;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.repository.api.HippoNode;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = "hippogogreen:basedocument")
public class BaseDocument extends HippoDocument {

    public static final Logger log = LoggerFactory.getLogger(BaseDocument.class);

    private String localizedName = null;

    public String getDisplayName() {
        if (localizedName == null) {
            try {
                javax.jcr.Node canonical = ((HippoNode) this.getNode()).getCanonicalNode();
                if (canonical == null) {
                    // for a virtual only node, the local name is just the node name itself
                    localizedName = this.getName();
                } else {
                    localizedName = ((HippoNode) canonical).getDisplayName();
                }
            } catch (RepositoryException e) {
                log.warn("RepositoryException for localized name", e);
            }
        }
        return localizedName;
    }

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

    public String [] getCampaigns() {
        return getMultipleProperty("hippogogreen:campaign");
    }
}
