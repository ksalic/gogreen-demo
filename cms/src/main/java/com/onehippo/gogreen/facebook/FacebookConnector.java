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
package com.onehippo.gogreen.facebook;


import facebook4j.Facebook;
import facebook4j.FacebookFactory;
import facebook4j.auth.AccessToken;
import java.net.URLEncoder;

/**
 * Purpose of this class is to establish connection with Facebook API provider
 * authenticate, and query various data (posts, likes, etc) from facebook
 * account.
 */
public class FacebookConnector {

    private static Facebook facebook;

    /**
     * Keep Facebook instance singleton (one facebook page per site)
     *
     * @param appId
     * @param appSecret
     * @param accessToken
     * @return
     * @throws Exception
     */
    public static Facebook getFacebook(String appId, String appSecret, String accessToken) throws Exception {
        if (facebook == null) {
            facebook = new FacebookFactory().getInstance();
            facebook.setOAuthAppId(appId, appSecret);
            facebook.setOAuthAccessToken(new AccessToken(URLEncoder.encode(accessToken, "UTF-8"), null));

        }
        return facebook;

    }

}
