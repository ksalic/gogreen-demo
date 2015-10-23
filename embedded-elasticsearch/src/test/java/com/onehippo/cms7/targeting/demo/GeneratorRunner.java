/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.cms7.targeting.demo;

import com.onehippo.cms7.targeting.demo.generator.DataGenerator;

import org.junit.Test;

public class GeneratorRunner {

    @Test
    public void runDataGenerator() throws Exception {
        final DataGenerator generator = new DataGenerator();
        generator.setSimulatedDays(7);
        generator.setSpeedup(1000);
        generator.setGlobalRate(100);
        generator.run();
    }

}
