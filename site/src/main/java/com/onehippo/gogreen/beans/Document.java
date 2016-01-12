/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.beans;

import static com.onehippo.gogreen.utils.Constants.PROP_DESCRIPTION;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.ItemExistsException;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;
import javax.jcr.lock.LockException;
import javax.jcr.nodetype.ConstraintViolationException;
import javax.jcr.nodetype.NoSuchNodeTypeException;
import javax.jcr.version.VersionException;

import org.hippoecm.hst.content.beans.ContentNodeBinder;
import org.hippoecm.hst.content.beans.ContentNodeBindingException;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFacetSelect;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.hippoecm.hst.content.beans.standard.HippoMirror;
import org.hippoecm.hst.utils.SimpleHtmlExtractor;

import com.onehippo.gogreen.beans.compound.Copyright;
import com.onehippo.gogreen.beans.compound.ImageSet;
import com.onehippo.gogreen.utils.Constants;

@Node(jcrType = "hippogogreen:document")
public class Document extends BaseDocument implements ContentNodeBinder {

    private String title;
    private String summary;
    private HippoHtml description;
    private String descriptionContent;
    private String descriptionContentAsText;
    private List<ImageSet> images;

    public String getTitle() {
        return (title == null) ? (String) getProperty("hippogogreen:title") : title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return (summary == null) ? (String) getProperty("hippogogreen:summary") : summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public HippoHtml getDescription() {
        if (description == null) {
            description = getBean(PROP_DESCRIPTION);
        }
        return description;
    }

    public void setDescriptionContent(String descriptionContent) {
        this.descriptionContent = descriptionContent;
    }

    public String getDescriptionContent() {
        if (descriptionContent == null) {
            if (getDescription() != null) {
                descriptionContent = getDescription().getContent();
            }
        }
        return descriptionContent;
    }

    /**
     * SEO Support plugin may get this property to generate 'description' meta tag.
     * So, this method extracts only text from description markup string.
     * @return extracted description string without any markup
     */
    public String getDescriptionContentAsText() {
        if (descriptionContentAsText == null) {
            if (getDescriptionContent() != null) {
                descriptionContentAsText = SimpleHtmlExtractor.getText(getDescriptionContent());
            }
        }
        return descriptionContentAsText;
    }

    public Copyright getCopyright() {
        return getBean(Constants.PROP_COPYRIGHT);
    }

    public boolean bind(Object content, javax.jcr.Node node) throws ContentNodeBindingException {
        try {
            Document bean = (Document) content;
            node.setProperty("hippogogreen:title", bean.getTitle());
            node.setProperty("hippogogreen:summary", bean.getSummary());

            if (getDescriptionContent() != null) {
                if (node.hasNode(PROP_DESCRIPTION)) {
                    javax.jcr.Node htmlNode = node.getNode(PROP_DESCRIPTION);
                    if (!htmlNode.isNodeType("hippostd:html")) {
                        throw new ContentNodeBindingException("Expected html node of type 'hippostd:html' but was '" + htmlNode.getPrimaryNodeType().getName() + "'");
                    }
                    htmlNode.setProperty("hippostd:content", getDescriptionContent());
                } else {
                    javax.jcr.Node html = node.addNode(PROP_DESCRIPTION, "hippostd:html");
                    html.setProperty("hippostd:content", html);
                }
            }
        } catch (PathNotFoundException e) {
            log.error("Error binding object, Ppath not found", e);
        } catch (ItemExistsException e) {
            log.error("Error binding object, item doesn't exist", e);
        } catch (NoSuchNodeTypeException e) {
            log.error("Error binding object, Node not found", e);
        } catch (ValueFormatException e) {
            log.error("Error binding object, formatting exception", e);
        } catch (VersionException e) {
            log.error("Error binding object, version exc", e);
        } catch (ConstraintViolationException e) {
            log.error("Error binding object", e);
        } catch (LockException e) {
            log.error("Error binding object, locking exception", e);
        } catch (RepositoryException e) {
            log.error("Error binding object", e);
        }
        return true;
    }

    public List<ImageSet> getImages() {
        if (images == null) {
            initImages();
        }
        return images;
    }

    public ImageSet getFirstImage() {
        initImages();
        return images.isEmpty() ? null : images.get(0);
    }

    private void initImages() {
        images = new ArrayList<ImageSet>();
        List<HippoMirror> mirrors = getChildBeansByName(Constants.NT_IMAGE);
        for (HippoBean mirror : mirrors) {
            if (mirror instanceof HippoFacetSelect) {
                HippoFacetSelect facetSelect = (HippoFacetSelect) mirror;
                HippoBean referenced = facetSelect.getReferencedBean();
                if (referenced instanceof ImageSet) {
                    ImageSet image = (ImageSet) referenced;
                    images.add(image);

                }
            }
        }
    }
}
