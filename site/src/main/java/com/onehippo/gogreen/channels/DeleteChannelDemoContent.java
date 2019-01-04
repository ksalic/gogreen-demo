 /*
 * Copyright 2017-2019 Hippo B.V. (https://www.onehippo.com)
 */
package com.onehippo.gogreen.channels;

import java.util.List;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.onehippo.cms7.services.hst.Channel;
import org.onehippo.cms7.services.eventbus.Subscribe;

import org.hippoecm.hst.configuration.hosting.Mount;

import org.hippoecm.hst.pagecomposer.jaxrs.api.BeforeChannelDeleteEvent;
import org.hippoecm.hst.pagecomposer.jaxrs.api.ChannelEventListenerRegistry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DeleteChannelDemoContent {

    private static Logger log = LoggerFactory.getLogger(DeleteChannelDemoContent.class);

    @Subscribe
    @SuppressWarnings({"ThrowableResultOfMethodCallIgnored", "unused"})
    public void onChannelDeleteEvent(BeforeChannelDeleteEvent event) {
        // no action if an exception is already set
        if (event.getException() != null) {
            return;
        }

        final Channel channel = event.getChannel();

        try {
            final Session session = event.getRequestContext().getSession();
            final List<Mount> mounts = event.getMounts();

            for (Mount mount : mounts) {
                final String contentPath = mount.getContentPath();
                final Node node = session.getNode(contentPath);
                if (node.isNodeType("hippogogreen:deletecontentwithchannel")) {
                    node.remove();
                }
            }

        } catch (RepositoryException e) {
            log.error("Deleting the content when deleting a channel failed.", e);
            event.setException(new IllegalStateException("Deleting the content failed because of a " + e.getClass().getSimpleName()));
        }
    }

    @SuppressWarnings("UnusedDeclaration")
    public void init() {
        ChannelEventListenerRegistry.get().register(this);
    }

    @SuppressWarnings("UnusedDeclaration")
    public void destroy() {
        ChannelEventListenerRegistry.get().unregister(this);
    }
}
