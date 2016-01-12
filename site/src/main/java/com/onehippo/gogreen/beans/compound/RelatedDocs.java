/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.RepositoryException;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFacetSelect;
import org.hippoecm.hst.content.beans.standard.HippoFolder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Node(jcrType = "relateddocs:docs")
public class RelatedDocs extends HippoFolder {

    private static final Logger log = LoggerFactory.getLogger(RelatedDocs.class);
    
    public List<HippoBean> getRelatedDocs(String primaryNodeType) {
        if (primaryNodeType == null) {
            return null;
        }
        
        List<HippoFacetSelect> relatedDocs = getChildBeansByName("relateddocs:reldoc");

        if (relatedDocs != null) {
            List<HippoBean> beans = new ArrayList<HippoBean>(relatedDocs.size());
            try {
                for (HippoFacetSelect facetSelect : relatedDocs) {
                    if (facetSelect != null) {
                        HippoBean bean = facetSelect.getReferencedBean();
                        if (bean != null) {
                            String nodeType = bean.getNode().getPrimaryNodeType().getName();
                            if (nodeType.equals(primaryNodeType)) {
                                beans.add(bean);
                            }
                        }
                    }
                }
            } catch (RepositoryException e) {
                log.warn("Error while searching related documents of type " + primaryNodeType, e);
            }
            return beans;
        }
        
        return null;
    }
    
}
