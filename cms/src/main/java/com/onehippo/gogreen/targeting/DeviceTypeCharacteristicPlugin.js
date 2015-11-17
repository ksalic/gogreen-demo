/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";

Ext.namespace('Hippo.Targeting');

Hippo.Targeting.DeviceTypeCharacteristicPlugin = Ext.extend(Hippo.Targeting.CharacteristicPlugin, {

    constructor: function(config) {
        this.deviceTypeMap = new Hippo.Targeting.Map(config.deviceTypes, 'type', 'description');
        Hippo.Targeting.DeviceTypeCharacteristicPlugin.superclass.constructor.call(this, Ext.apply(config, {
            visitorCharacteristic: {
                deviceTypeMap: this.deviceTypeMap,
                xtype: 'Hippo.Targeting.DeviceTypeCharacteristic'
            },
            editor: {
                deviceTypeMap: this.deviceTypeMap,
                resources: config.resources,
                xtype: 'Hippo.Targeting.DeviceTypeTargetGroupEditor'
            },
            renderer: this.renderDeviceTypes,
            scope: this
        }));
    },

    renderDeviceTypes: function(properties) {
        var result = [];
        Ext.each(properties, function(property) {
            var deviceTypeDescription = this.deviceTypeMap.getValue(property.name);
            if (!Ext.isEmpty(deviceTypeDescription)) {
                result.push(deviceTypeDescription);
            }
        }, this);
        return result.join(', ');
    }

});

Hippo.Targeting.DeviceTypeTargetGroupEditor = Ext.extend(Hippo.Targeting.TargetGroupCheckboxGroup, {

    constructor: function(config) {
        var checkboxes = [];

        config.deviceTypeMap.each(function(deviceType, deviceTypeDescription) {
            checkboxes.push({
                boxLabel: deviceTypeDescription,
                name: deviceType,
                listeners: Hippo.Targeting.formElementQtipListeners(deviceTypeDescription)
            });
        });

        Hippo.Targeting.DeviceTypeTargetGroupEditor.superclass.constructor.call(this, Ext.apply(config, {
            allowBlank: config.allowBlank || false,
            blankText: config.resources['error-select-at-least-one-type-of-device'],
            columns: config.columns || 1,
            items: checkboxes,
            vertical: true
        }));
    }

});
Ext.reg('Hippo.Targeting.DeviceTypeTargetGroupEditor', Hippo.Targeting.DeviceTypeTargetGroupEditor);

Hippo.Targeting.DeviceTypeCharacteristic = Ext.extend(Hippo.Targeting.VisitorCharacteristic, {

    constructor: function(config) {
        Hippo.Targeting.DeviceTypeCharacteristic.superclass.constructor.call(this, config);
        this.deviceTypeMap = config.deviceTypeMap;
    },

    isCollected: function(targetingData) {
        var deviceType = targetingData.deviceType;
        return !Ext.isEmpty(deviceType) && !Ext.isEmpty(this.deviceTypeMap.getValue(String(deviceType)));
    },

    getTargetGroupName: function(targetingData) {
        return this.deviceTypeMap.getValue(String(targetingData.deviceType));
    },

    getTargetGroupProperties: function(targetingData) {
        return [{ name: String(targetingData.deviceType), value: '' }];
    }

});
Ext.reg('Hippo.Targeting.DeviceTypeCharacteristic', Hippo.Targeting.DeviceTypeCharacteristic);
