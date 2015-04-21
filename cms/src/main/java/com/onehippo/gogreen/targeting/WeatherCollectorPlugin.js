/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";

Ext.namespace('Hippo.Targeting');

Hippo.Targeting.WeatherCollectorPlugin = Ext.extend(Hippo.Targeting.CollectorPlugin, {

    constructor: function(config) {
        this.resources = config.resources;

        this.weatherTypeMap = new Hippo.Targeting.Map(config.weatherTypes, 'code', 'description');

        Hippo.Targeting.WeatherCollectorPlugin.superclass.constructor.call(this, Ext.apply(config, {
            editor: {
                weatherTypeMap: this.weatherTypeMap,
                resources: config.resources,
                xtype: 'Hippo.Targeting.WeatherTargetingDataEditor'
            },
            renderer: this.renderWeatherDescription
        }));
    },

    renderWeatherDescription: function(value) {
        return Ext.value(this.weatherTypeMap.getValue(value && String(value.weatherCode)), this.resources['unknown-weather-description']);
    }

});

Hippo.Targeting.WeatherTargetingDataEditor = Ext.extend(Hippo.Targeting.TargetingDataRadioGroup, {

    UNKNOWN_WEATHER_CODE: '-1',

    constructor: function(config) {
        var radioButtons = [];

        config.weatherTypeMap.each(function(weatherCode, weatherDescription) {
            radioButtons.push({
                boxLabel: weatherDescription,
                inputValue: String(weatherCode),
                name: 'targeting-data-weather',
                listeners: Hippo.Targeting.formElementQtipListeners(weatherDescription)
            });
        }, this);

        Hippo.Targeting.WeatherTargetingDataEditor.superclass.constructor.call(this, Ext.apply(config, {
            columns: 2,
            items: radioButtons,
            vertical: true
        }));
    },

    convertDataToInputValue: function(data) {
        if (data === null) {
            return this.UNKNOWN_WEATHER_CODE;
        }
        return String(Ext.value(data.weatherCode, this.UNKNOWN_WEATHER_CODE));
    },

    convertInputValueToData: function(inputValue) {
        return {
            collectorId: this.collector,
            weatherCode: inputValue
        };
    }

});
Ext.reg('Hippo.Targeting.WeatherTargetingDataEditor', Hippo.Targeting.WeatherTargetingDataEditor);
