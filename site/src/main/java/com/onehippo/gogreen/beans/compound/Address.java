/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoItem;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;

/**
 * Bean mapping class for the 'hippogogreen:address' document type
 */
@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = "hippogogreen:address")
public class Address extends HippoItem {
    public String getStreet() {
        return getSingleProperty("hippogogreen:street");
    }

    public String getNumber() {
        return getSingleProperty("hippogogreen:number");
    }

    public String getCity() {
        return getSingleProperty("hippogogreen:city");
    }

    public String getPostalCode() {
        return getSingleProperty("hippogogreen:postalcode");
    }

    public String getProvince() {
        return getSingleProperty("hippogogreen:province");
    }

    public String getCountry() {
        return getSingleProperty("hippogogreen:country");
    }

    public String getTelephone() {
        return getSingleProperty("hippogogreen:telephone");
    }

    public String getFax() {
        return getSingleProperty("hippogogreen:fax");
    }

    public String getEmail() {
        return getSingleProperty("hippogogreen:email");
    }

    public String getWebsite() {
        return getSingleProperty("hippogogreen:website");
    }

    public String getOptionalText() {
        return getSingleProperty("hippogogreen:optionalText");
    }

    public Double getLatitude() {
        return getSingleProperty("hippogogreen:latitude");
    }

    public Double getLongitude() {
        return getSingleProperty("hippogogreen:longitude");
    }
}
