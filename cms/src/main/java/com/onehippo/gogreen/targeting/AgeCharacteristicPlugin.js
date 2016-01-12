/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
Ext.namespace('Hippo.Targeting');
Hippo.Targeting.AgeCharacteristicPlugin =
  Ext.extend(Hippo.Targeting.CharacteristicPlugin, {

    constructor: function(config) {
      Ext.apply(config, {
        visitorCharacteristic: {
          xtype: 'Hippo.Targeting.AgeCharacteristic'
        }
      });

        Hippo.Targeting.AgeCharacteristicPlugin.superclass.constructor.call(this, config);
    }

  });

Hippo.Targeting.AgeCharacteristic =
  Ext.extend(Hippo.Targeting.VisitorCharacteristic, {

    constructor: function(config) {
        Hippo.Targeting.AgeCharacteristic.superclass.constructor.call(this, config);
    },

    isCollected: function(targetingData) {
      if (targetingData.age) {
        return true;
      }
      return false;
    },

    getTargetGroupName: function(targetingData) {
      var age = targetingData.age;
      return age;
      //return 'age == ' + age;
    },

    getTargetGroupProperties: function(targetingData) {
      var age = targetingData.age;
      var cond = 'age == ' + age;
      return [
        { name: cond, value: "" }
      ];
    }
  });

Ext.reg('Hippo.Targeting.AgeCharacteristic', Hippo.Targeting.AgeCharacteristic);
