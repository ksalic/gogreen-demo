Ext.namespace('GoGreen');
GoGreen.AgeCharacteristicPlugin =
  Ext.extend(Hippo.Targeting.CharacteristicPlugin, {

    constructor: function(config) {
      Ext.apply(config, {
        visitorCharacteristic: {
          xtype: 'GoGreen.AgeCharacteristic'
        }
      });

      GoGreen.AgeCharacteristicPlugin.superclass.constructor.call(this, config);
    }

  });

GoGreen.AgeCharacteristic =
  Ext.extend(Hippo.Targeting.VisitorCharacteristic, {

    constructor: function(config) {
      GoGreen.AgeCharacteristic.superclass.constructor.call(this, config);
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

Ext.reg('GoGreen.AgeCharacteristic', GoGreen.AgeCharacteristic);
