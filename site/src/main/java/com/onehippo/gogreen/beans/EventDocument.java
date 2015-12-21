/**
 * Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.onehippo.gogreen.beans;

import java.util.Calendar;

import com.onehippo.gogreen.beans.compound.Address;
import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;

@Node(jcrType = "hippogogreen:event")
public class EventDocument extends Document {

    public Calendar getDate() {
        return getProperty(Constants.PROP_DATE);
    }

    public Calendar getEndDate() {
        return getProperty(Constants.PROP_ENDDATE);
    }

    public Address getLocation() {
        return getBean(Constants.PROP_LOCATION);
    }

    public String[] getTags() {
        return getProperty(Constants.PROP_TAGS);
    }

    public String[] getCategories() {
        return getProperty(Constants.PROP_CATEGORIES);
    }

}
