/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
'use strict';

Ext.namespace('Hippo.Targeting');

Hippo.Targeting.AgeCollectorPlugin =
        Ext.extend(Hippo.Targeting.CollectorPlugin, {
            constructor: function(config) {
                var editor;

                editor = {
                    collector: config.collector,
                    resources: config.resources,
                    xtype: 'Hippo.Targeting.AgeTargetingDataEditor'
                };
                
                Ext.apply(config, {
                            editor: editor,
                            renderer: this.render
                });

                Hippo.Targeting.AgeCollectorPlugin.superclass.constructor
                        .call(this, config);
            },
            render: function(value) {
                if (Ext.isDefined(value)) {
                    if (Ext.isDefined(value.age))
                        return value.age;
                }
                else 
                    return this.resources['no-age'];
            }
        });
        
Hippo.Targeting.AgeTargetingDataEditor = Ext.extend(Ext.form.TextField, {

        constructor: function(config) {
            Hippo.Targeting.AgeTargetingDataEditor.superclass.constructor.call(this, config);
        },

        getValue: function() {            
            var data = Hippo.Targeting.AgeTargetingDataEditor.superclass.getValue.call(this);
                       
            return {
                collectorId: this.collector,
                age: data
            };
        },

        setValue: function(data) {
            if (data != null) {
                Hippo.Targeting.AgeTargetingDataEditor.superclass.setValue.call(this, data.age);
            }
        }

    });
    Ext.reg('Hippo.Targeting.AgeTargetingDataEditor', Hippo.Targeting.AgeTargetingDataEditor);

//Ext.reg('Hippo.Targeting.AgeCollectorPlugin', Hippo.Targeting.AgeCollectorPlugin);