/*
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
(function () {
  "use strict";

  Ext.namespace('Hippo.Targeting');

  Hippo.Targeting.EngagementCharacteristicPlugin = Ext.extend(Hippo.Targeting.CharacteristicPlugin, {

    constructor: function (config) {
      Hippo.Targeting.EngagementCharacteristicPlugin.superclass.constructor.call(this, Ext.apply(config, {
        visitorCharacteristic: {
          targetingDataProperty: 'engagement',
          xtype: 'Hippo.Targeting.TargetingDataPropertyCharacteristic'
        }
      }));
    }

  });
}());