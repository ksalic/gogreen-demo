package com.onehippo.gogreen.beans;

import com.onehippo.gogreen.beans.compound.ImageSet;
import com.onehippo.gogreen.utils.Constants;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFacetSelect;
import org.hippoecm.hst.content.beans.standard.HippoMirror;

import java.util.ArrayList;
import java.util.List;

@Node(jcrType = "hippogogreen:imagedocument")
public class ImageDocument extends Document {
    private List<ImageSet> images;

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
