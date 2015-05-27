/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
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


import com.google.common.collect.ImmutableSet
import org.onehippo.repository.update.BaseNodeUpdateVisitor

import javax.jcr.Item
import javax.jcr.Node
import javax.jcr.Session

/*
* runs as:
 * content/documents/hippogogreen/events/2016//*[@hippotranslation:id]
* */

class LinkTranslations extends BaseNodeUpdateVisitor {


    static final String ROOT = "hippogogreen";
    static final ImmutableSet<String> PATHS = new ImmutableSet.Builder<String>()
            .add("hippogagroen")
            .add("hippomiseauvert")
            .add("hippo-geht-gruen")
            .add("河马转到绿")
            .build();

    boolean doUpdate(Node node) {
        log.debug "Checking node ${node.path}"
        if (node.hasProperty("hippotranslation:id")) {
            String translation = node.getProperty("hippotranslation:id").getString();


            Session session = node.session;
            for (String p : PATHS) {
                String translationPath = node.path.replace(ROOT, p)
                if (session.itemExists(translationPath)) {
                    Item translationNode = session.getItem(translationPath)
                    translationNode.setProperty("hippotranslation:id", translation)
                    log.debug "Changed ${translationPath} translationID: ${translation}"
                }

            }
        }


        return false;
    }


    boolean undoUpdate(Node node) {
        throw new UnsupportedOperationException('Updater does not implement undoUpdate method')
    }

}