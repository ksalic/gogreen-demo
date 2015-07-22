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

package com.onehippo.gogreen.beans;

import org.hippoecm.hst.content.beans.Node;
import java.util.Calendar;


@Node(jcrType="hippogogreen:facebookpost")
public class FBPostDocument extends BaseDocument{

    public String getPost(){ return getProperty("hippogogreen:post");}

    public Calendar getDate(){
        return getProperty("hippogogreen:date");
    }

    public String getLink(){
        return  getProperty("hippogogreen:link");
    }


    public String getFrom(){
        return  getProperty("hippogogreen:from");
    }

}
