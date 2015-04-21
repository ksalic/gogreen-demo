/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";

Ext.namespace('Hippo.Targeting');

Hippo.Targeting.WeatherCharacteristicPlugin = Ext.extend(Hippo.Targeting.CharacteristicPlugin, {

    constructor: function(config) {
        this.weatherTypeMap = new Hippo.Targeting.Map(config.weatherTypes, 'code', 'description')
        Hippo.Targeting.WeatherCharacteristicPlugin.superclass.constructor.call(this, Ext.apply(config, {
            visitorCharacteristic: {
                weatherTypeMap: this.weatherTypeMap,
                xtype: 'Hippo.Targeting.WeatherCharacteristic'
            },
            editor: {
                weatherTypeMap: this.weatherTypeMap,
                resources: config.resources,
                xtype: 'Hippo.Targeting.WeatherTargetGroupEditor'
            },
            renderer: this.renderWeatherTypes,
            scope: this
        }));
    },

    renderWeatherTypes: function(properties) {
        var result = [];
        Ext.each(properties, function(property) {
            var weatherDescription = this.weatherTypeMap.getValue(property.name);
            if (!Ext.isEmpty(weatherDescription)) {
                result.push(weatherDescription);
            }
        }, this);
        return result.join(', ');
    }

});

Hippo.Targeting.WeatherTargetGroupEditor = Ext.extend(Hippo.Targeting.TargetGroupCheckboxGroup, {

    constructor: function(config) {
        var checkboxes = [];

        config.weatherTypeMap.each(function(weatherCode, weatherDescription) {
            checkboxes.push({
                boxLabel: weatherDescription,
                name: weatherCode,
                listeners: Hippo.Targeting.formElementQtipListeners(weatherDescription)
            });
        });

        Hippo.Targeting.WeatherTargetGroupEditor.superclass.constructor.call(this, Ext.apply(config, {
            allowBlank: config.allowBlank || false,
            blankText: config.resources['error-select-at-least-one-type-of-weather'],
            columns: config.columns || 2,
            items: checkboxes,
            vertical: true
        }));
    }

});
Ext.reg('Hippo.Targeting.WeatherTargetGroupEditor', Hippo.Targeting.WeatherTargetGroupEditor);

Hippo.Targeting.WeatherCharacteristic = Ext.extend(Hippo.Targeting.VisitorCharacteristic, {

    constructor: function(config) {
        Hippo.Targeting.WeatherCharacteristic.superclass.constructor.call(this, config);
        this.weatherTypeMap = config.weatherTypeMap;
    },

    isCollected: function(targetingData) {
        var weatherCode = targetingData.weatherCode;
        return !Ext.isEmpty(weatherCode) && !Ext.isEmpty(this.weatherTypeMap.getValue(String(weatherCode)));
    },

    getTargetGroupName: function(targetingData) {
        return this.weatherTypeMap.getValue(String(targetingData.weatherCode));
    },

    getTargetGroupProperties: function(targetingData) {
        return [{ name: String(targetingData.weatherCode), value: '' }];
    }

});
Ext.reg('Hippo.Targeting.WeatherCharacteristic', Hippo.Targeting.WeatherCharacteristic);
