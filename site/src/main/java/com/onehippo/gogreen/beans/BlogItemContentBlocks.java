package com.onehippo.gogreen.beans;

import com.onehippo.gogreen.beans.compound.Copyright;
import com.onehippo.gogreen.beans.compound.ImageSet;
import com.onehippo.gogreen.utils.Constants;
import org.hippoecm.hst.content.beans.ContentNodeBinder;
import org.hippoecm.hst.content.beans.ContentNodeBindingException;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFacetSelect;
import org.hippoecm.hst.content.beans.standard.HippoMirror;

import javax.jcr.ItemExistsException;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;
import javax.jcr.lock.LockException;
import javax.jcr.nodetype.ConstraintViolationException;
import javax.jcr.nodetype.NoSuchNodeTypeException;
import javax.jcr.version.VersionException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by charliechen on 11/19/15.
 */
@Node(jcrType="hippogogreen:blogitemcb")
public class BlogItemContentBlocks extends BlogItem {

    public List<?> getParagraphBlocks() {
        return getChildBeans("hippogogreen:paragraphblock");
    }

    public List<?> getImageBlocks() {
        return getChildBeans("hippogogreen:imageblock");
    }

    public List<?> getQuoteBlocks() {
        return getChildBeans("hippogogreen:quoteblock");
    }

    public List<?> getContentBlocks() {
        return getChildBeansByName("hippogogreen:contentblocksitem");
    }

    @Override
    public boolean bind(Object content, javax.jcr.Node node) throws ContentNodeBindingException {
        try {
            Document bean = (Document) content;
            node.setProperty("hippogogreen:title", bean.getTitle());
            node.setProperty("hippogogreen:summary", bean.getSummary());
        } catch (PathNotFoundException e) {
            log.error("Error binding object, path not found", e);
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
}
