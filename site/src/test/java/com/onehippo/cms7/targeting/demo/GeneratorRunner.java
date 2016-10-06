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
        //generator.setRepoLocation("rmi://127.0.0.1:1099/hipporepository");
        generator.setSimulatedDays(31);
        generator.setSpeedup(350);
        generator.setGlobalRate(100);
        generator.setDefaultStoreLocation("sql=jdbc:mysql://localhost/targeting?useSSL=false,user=root");
        generator.setVisitsStoreLocation("elastic=http://localhost:9250,index=visits");
        generator.run();
    }

}
