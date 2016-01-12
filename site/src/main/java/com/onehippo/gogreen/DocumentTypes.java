/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen;


/**
 * Contains constants for all names of node types and properties.
 */
public class DocumentTypes {

    private DocumentTypes() {
        // prevent instantiation
    }

    public static final String IMAGE_SET = "hippogogreengallery:imageset";

    public static final class ImageSet {
        public static final String ALT = "hippogogreengallery:alt";
        public static final String COPYRIGHT = "hippogogreengallery:copyright";
        public static final String EXTRA_LARGE_THUMBNAIL = "hippogogreengallery:extralargethumbnail";
        public static final String LARGE_THUMBNAIL = "hippogogreengallery:largethumbnail";
        public static final String MOBILE_LOGO = "hippogogreengallery:mobilelogo";
        public static final String MOBILE_THUMBNAIL = "hippogogreengallery:mobilethumbnail";
        public static final String SMALL_THUMBNAIL = "hippogogreengallery:smallthumbnail";
        public static final String BANNER_CAROUSEL = "hippogogreengallery:bannercarousel";
        public static final String BANNER = "hippogogreengallery:banner";
        public static final String LANDSCAPE_IMAGE = "hippogogreengallery:landscapeimage";
    }

}
