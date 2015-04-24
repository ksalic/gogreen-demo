/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";
(function() {
    Ext.namespace('Hippo.Targeting');

    Hippo.Targeting.AutomationCharacteristicPlugin = Ext.extend(Hippo.Targeting.CharacteristicPlugin, {
        constructor: function(config) {
            Hippo.Targeting.AutomationCharacteristicPlugin.superclass.constructor.call(this, Ext.apply(config, {
                visitorCharacteristic: {
                    targetingDataProperty: 'lists',
                    xtype: 'Hippo.Targeting.TargetingDataPropertyCharacteristic'
                }
            }));
        }
    });
}());

