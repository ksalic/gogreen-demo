/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
'use strict';

Ext.namespace('Hippo.Targeting');

Hippo.Targeting.DeviceTypeCollectorPlugin =
        Ext.extend(Hippo.Targeting.CollectorPlugin, {
            constructor: function(config) {
                this.resources = config.resources;

                this.deviceTypeMap = new Hippo.Targeting.Map(config.deviceTypes, 'type', 'description');

                var editor;

                editor = {
                    deviceTypeMap: this.deviceTypeMap,
                    resources: config.resources,
                    xtype: 'Hippo.Targeting.DeviceTypeTargetingDataEditor'
                };

                Ext.apply(config, {
                    editor: editor,
                    renderer: this.renderDeviceTypeDescription
                });

                Hippo.Targeting.DeviceTypeCollectorPlugin.superclass.constructor
                        .call(this, config);
            },

            renderDeviceTypeDescription: function(value) {
                return Ext.value(this.deviceTypeMap.getValue(value && String(value.deviceType)), this.resources['unknown-devicetype-description']);
            }
        });
        
Hippo.Targeting.DeviceTypeTargetingDataEditor = Ext.extend(Hippo.Targeting.TargetingDataRadioGroup, {

    DEFAULT_DEVICE_TYPE: 'DESKTOP',

    constructor: function(config) {
        var radioButtons = [];

        config.deviceTypeMap.each(function(deviceType, deviceTypeDescription) {
            radioButtons.push({
                boxLabel: deviceTypeDescription,
                inputValue: String(deviceType),
                name: 'targeting-data-devicetype',
                listeners: Hippo.Targeting.formElementQtipListeners(deviceTypeDescription)
            });
        }, this);

        Hippo.Targeting.DeviceTypeTargetingDataEditor.superclass.constructor.call(this, Ext.apply(config, {
            columns: 1,
            items: radioButtons,
            vertical: true
        }));
    },

    convertDataToInputValue: function(data) {
        if (data === null) {
            return this.DEFAULT_DEVICE_TYPE;
        }
        return String(Ext.value(data.deviceType, this.DEFAULT_DEVICE_TYPE));
    },

    convertInputValueToData: function(inputValue) {
        return {
            collectorId: this.collector,
            deviceType: inputValue
        };
    }

});
Ext.reg('Hippo.Targeting.DeviceTypeTargetingDataEditor', Hippo.Targeting.DeviceTypeTargetingDataEditor);

//Ext.reg('Hippo.Targeting.DeviceTypeCollectorPlugin', Hippo.Targeting.DeviceTypeCollectorPlugin);