/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.onehippo.gogreen.components.facebook;

import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.HstQueryResult;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.standard.*;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import com.onehippo.gogreen.beans.FBPostDocument;
import java.util.ArrayList;
import java.util.Collection;
import com.onehippo.gogreen.components.BaseComponent;
import org.hippoecm.hst.core.request.HstRequestContext;

public class FBPostOverview extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) throws HstComponentException {
        super.doBeforeRender(request, response);

        HippoBean scope = request.getRequestContext().getContentBean();
        HstRequestContext ctx = request.getRequestContext();
        try {
            HstQuery hstQuery = ctx.getQueryManager().createQuery(scope, FBPostDocument.class);
            HstQueryResult queryResult = hstQuery.execute();
            request.setAttribute("posts", fetchPosts(queryResult));

        } catch (QueryException e) {
            throw new HstComponentException("Query error while getting facebook posts: " + e.getMessage(), e);
        }
    }

    private Collection<FBPostDocument> fetchPosts(final HstQueryResult queryResult) {
        final Collection<FBPostDocument> news = new ArrayList<FBPostDocument>();
        HippoBeanIterator iterator = queryResult.getHippoBeans();
        while (iterator.hasNext()) {
            HippoBean bean = iterator.next();
            if (bean instanceof FBPostDocument) {
                news.add((FBPostDocument) bean);
            }
        }
        return news;
    }
}
