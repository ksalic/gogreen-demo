/*
 * Copyright 2017 Hippo B.V. (https://www.onehippo.com)
 */
package com.onehippo.gogreen.channels;

import java.util.List;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.onehippo.cms7.services.hst.Channel;
import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.core.container.ComponentManager;
import org.hippoecm.hst.core.container.ComponentManagerAware;
import org.hippoecm.hst.pagecomposer.jaxrs.api.BeforeChannelDeleteEvent;
import org.hippoecm.hst.pagecomposer.jaxrs.services.exceptions.ClientError;
import org.hippoecm.hst.pagecomposer.jaxrs.services.exceptions.ClientException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.eventbus.AllowConcurrentEvents;
import com.google.common.eventbus.Subscribe;

public class DeleteChannelDemoContent implements ComponentManagerAware {

    private static Logger log = LoggerFactory.getLogger(DeleteChannelDemoContent.class);
    private ComponentManager componentManager;

    @Subscribe
    @AllowConcurrentEvents
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

            for(Mount mount : mounts) {
                final String contentPath = mount.getContentPath();
                final Node node = session.getNode(contentPath);
                if(node.isNodeType("hippogogreen:deletecontentwithchannel")) {
                    node.remove();
                }
            }

        } catch (RepositoryException e) {
            log.error("Deleting the content when deleting a channel failed.", e);
            event.setException(new ClientException("Deleting the content failed", ClientError.UNKNOWN));
        }
    }

    @Override
    public void setComponentManager(ComponentManager componentManager) {
        this.componentManager = componentManager;
    }

    public void init() {
        componentManager.registerEventSubscriber(this);
    }

    public void destroy() {
        componentManager.unregisterEventSubscriber(this);
    }
}
