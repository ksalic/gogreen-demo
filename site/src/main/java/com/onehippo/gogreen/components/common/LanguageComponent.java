/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;
import org.hippoecm.hst.content.beans.standard.HippoAvailableTranslationsBean;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.linking.HstLink;
import org.hippoecm.hst.core.request.HstRequestContext;

import java.util.ArrayList;
import java.util.List;

public class LanguageComponent extends BaseComponent {

    static public class Translation {

        private final String language;

        private final boolean available;
        private final HstLink link;
        public Translation(String language, final HstLink link, boolean available) {
            this.language = language;
            this.available = available;
            this.link = link;
        }

        public String getLanguage() {
            return language;
        }

        public boolean isAvailable() {
            return available;
        }

        public HstLink getLink() {
            return link;
        }
    }

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        final HippoBean baseBean = ctx.getSiteContentBaseBean();
        final HippoAvailableTranslationsBean<HippoBean> availableBaseTranslations = baseBean.getAvailableTranslations();

        final HippoBean contentBean = ctx.getContentBean();
        final HippoAvailableTranslationsBean<HippoBean> availableContentTranslations = contentBean == null ? null : contentBean.getAvailableTranslations();

        final String requestLocaleLang = request.getLocale().getLanguage();
        final String requestLocaleCountry = request.getLocale().getCountry() == null ? "" : request.getLocale().getCountry().toLowerCase();
        final HstRequestContext requestContext = request.getRequestContext();

        final List<Translation> translations = new ArrayList<Translation>();

        String currentLocale = "";
        for (String baseLocale : availableBaseTranslations.getAvailableLocales()) {
            if (baseLocale.equals(requestLocaleLang + "-" + requestLocaleCountry)) { //exact match
                currentLocale = baseLocale;
                break;
            } else if (baseLocale.equals(requestLocaleLang)) { //partial match
                currentLocale = baseLocale;
            }
        }

        for (String baseLocale : availableBaseTranslations.getAvailableLocales()) {
            // skip the current locale
            if (baseLocale.equals(currentLocale)) {
                request.setAttribute("currentLocale", baseLocale);
                continue;
            }

            Translation translation = null;

            // first try to create a direct link to the translated content
            translation = createTranslation(requestContext, availableContentTranslations, baseLocale, true);

            // second, try to create a link to the base site
            if (translation == null) {
                translation = createTranslation(requestContext, availableBaseTranslations, baseLocale, false);
            }

            if (translation != null) {
                translations.add(translation);
            }
        }

        request.setAttribute("translations", translations);
    }

    private Translation createTranslation(final HstRequestContext requestContext, final HippoAvailableTranslationsBean<HippoBean> availableTranslations, final String baseLocale, final boolean translatedContentAvailable) {
        if (availableTranslations == null || !availableTranslations.hasTranslation(baseLocale)) {
            return null;
        }

        HippoBean translationBean = availableTranslations.getTranslation(baseLocale);
        HstLink link = requestContext.getHstLinkCreator().create(translationBean.getNode(), requestContext);

        if (link.isNotFound()) {
            return null;
        }

        return new Translation(baseLocale, link, translatedContentAvailable);
    }

}
