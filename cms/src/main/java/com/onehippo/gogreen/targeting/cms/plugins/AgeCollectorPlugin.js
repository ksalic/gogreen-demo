'use strict';

Ext.namespace('GoGreen');

GoGreen.AgeCollectorPlugin =
        Ext.extend(Hippo.Targeting.CollectorPlugin, {
            constructor: function(config) {
                var editor;

                editor = {
                    collector: config.collector,
                    resources: config.resources,
                    xtype: 'GoGreen.AgeTargetingDataEditor'
                };
                
                Ext.apply(config, {
                            editor: editor,
                            renderer: this.render
                });

                GoGreen.AgeCollectorPlugin.superclass.constructor
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
        
GoGreen.AgeTargetingDataEditor = Ext.extend(Ext.form.TextField, {

        constructor: function(config) {
            GoGreen.AgeTargetingDataEditor.superclass.constructor.call(this, config);
        },

        getValue: function() {            
            var data = GoGreen.AgeTargetingDataEditor.superclass.getValue.call(this);
                       
            return {
                collectorId: this.collector,
                age: data
            };
        },

        setValue: function(data) {
            GoGreen.AgeTargetingDataEditor.superclass.setValue.call(this, data.age);
        }

    });
    Ext.reg('GoGreen.AgeTargetingDataEditor', GoGreen.AgeTargetingDataEditor);

//Ext.reg('GoGreen.AgeCollectorPlugin', GoGreen.AgeCollectorPlugin);