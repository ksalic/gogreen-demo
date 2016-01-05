/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.cms7.targeting.demo.bootstrap;

import java.util.function.Supplier;

import javax.jcr.Session;

import org.elasticsearch.client.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BootstrapGoGreen extends BootstrapTargeting {

    @Autowired
    public BootstrapGoGreen(Client client) {
        super(client);
    }
}
