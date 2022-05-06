/*
 * Copyright 2016-2019 Bloomreach Inc (https://www.bloomreach.com)
 */
package com.bloomreach.cms.translations.events.impl;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.stream.Stream;

import org.apache.commons.lang.LocaleUtils;

import org.apache.commons.lang.StringUtils;
import org.onehippo.cms7.event.HippoEvent;
import org.onehippo.cms7.services.HippoServiceRegistry;
import org.onehippo.cms7.services.eventbus.Subscribe;

import org.onehippo.repository.events.PersistedHippoEventListenerRegistry;

import com.bloomreach.cms.translations.common.LifeCycle;
import com.bloomreach.cms.translations.common.TranslationException;
import com.bloomreach.cms.translations.common.TranslationTarget;
import com.bloomreach.cms.translations.events.TranslationEvent;
import com.bloomreach.cms.translations.events.api.TranslationEventsService;
import com.bloomreach.cms.translations.jobstore.api.TranslationJobPersistenceManager;
import com.bloomreach.cms.translations.repository.api.TranslationDocumentManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Implementation of TranslationEventsService that listens to incoming persisted translation events on the
 * Hippo Event Bus and creates documents from it.
 */
@SuppressWarnings("unused")
public class TranslationEventsServiceImpl implements TranslationEventsService, LifeCycle {

    private static Logger log = LoggerFactory.getLogger(TranslationEventsServiceImpl.class);

    @Override
    public synchronized void initialize(Map<String, String> props) {
        log.debug("Initializing {}, registering to {}", TranslationEventsServiceImpl.class.getName(), PersistedHippoEventListenerRegistry.class.getSimpleName());

        PersistedHippoEventListenerRegistry.get().register(this);
    }

    @Override
    public void destroy() {
        log.debug("Destroying {}", TranslationEventsServiceImpl.class.getName());
        PersistedHippoEventListenerRegistry.get().unregister(this);
    }

    @Override
    public String getEventCategory() {
        return TranslationEvent.CATEGORY_VALUE;
    }

    @Override
    public String getChannelName() {
        return TranslationEvent.CHANNEL_NAME;
    }

    @Override
    public boolean onlyNewEvents() {
        return true;
    }

    /**
     * Listen for translation events put on Hippo Event Bus by the callback resource called by Livewords, or other
     * extenal system, to create translated documents.
     */
    @Override
    @Subscribe
    public void onHippoEvent(final HippoEvent hippoEvent) {

        log.debug("Received event = {}", hippoEvent);
        if (!isTranslationEvent(hippoEvent)) {
            return;
        }

        final String targetLocale = (String) hippoEvent.get(TranslationEvent.KEY_TARGET_LOCALE);
        final String data = (String) hippoEvent.get(TranslationEvent.KEY_DATA);

        log.info("Received translation event with data length/hash {}/{} for locale {} from Hippo event bus.",
                data.length(), data.hashCode(), targetLocale);

        try {
            final TranslationTarget translationTarget = createTranslation(targetLocale, data.getBytes(StandardCharsets.UTF_8));
            getJobPersistenceManager().updateTranslationTarget(translationTarget);
            log.debug("Successfully updated translated document: {}", translationTarget);
        } catch (TranslationException e) {
            log.error("Error while receiving translations", e);
        }
    }

    private boolean isTranslationEvent(final HippoEvent hippoEvent) {
        return TranslationEvent.CATEGORY_VALUE.equals(hippoEvent.category());
    }

    private TranslationTarget createTranslation(String targetLocale, final byte[] data) throws TranslationException {
        final TranslationDocumentManager documentManager = getDocumentManager();
        if (documentManager == null) {
            log.error("Could not obtain TranslationDocumentManager, cancelling callback processing");
            return null;
        }

        targetLocale = targetLocale.replace("-", "_");

        String country = StringUtils.substringAfterLast(targetLocale, "_");
        targetLocale = targetLocale.replaceAll(country, country.toUpperCase());

        final Locale locale = LocaleUtils.toLocale(targetLocale);
        final TranslationTarget translationTarget = documentManager.storeTranslatedDocument(data, locale);
        log.debug("{} status for storing translated document: {}", translationTarget.getStatus(), translationTarget);
        return translationTarget;
    }

    private TranslationDocumentManager getDocumentManager() {
        return HippoServiceRegistry.getService(TranslationDocumentManager.class);
    }

    private TranslationJobPersistenceManager getJobPersistenceManager() {
        return HippoServiceRegistry.getService(TranslationJobPersistenceManager.class);
    }
}
