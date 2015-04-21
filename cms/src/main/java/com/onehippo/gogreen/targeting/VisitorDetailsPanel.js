/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";

Ext.namespace('Hippo.Hgge');

Hippo.Hgge.VisitorDetailsPanel = Ext.extend(Hippo.Targeting.BaseVisitorDetailsPanel, {

    constructor: function (config) {
        Ext.apply(config, {
            items: [
                {
                    xtype: 'Hippo.Targeting.Journey'
                },
                {
                    xtype: 'Hippo.Targeting.Spacer'
                },
                {
                    xtype: 'Hippo.Targeting.VisitorDetailsRightColumn',
                    items: [
                        {
                            xtype: 'Hippo.Targeting.MatchingPersonas'
                        },
                        {
                            xtype: 'Hippo.Targeting.VisitorDetailsRightColumnPanel',
                            title: config.resources['interest-title'],
                            height: 220,
                            layout: 'hbox',
                            layoutConfig: {
                                align: 'stretch'
                            },
                            items: [
                                {
                                    flex: 1,
                                    xtype: 'Hippo.Targeting.TermsFrequencyChart',
                                    characteristic: 'categories',
                                    noDataText: config.resources['categories-no-data'],
                                    title: config.resources['categories-title']
                                },
                                {
                                    flex: 1,
                                    xtype: 'Hippo.Targeting.TermsFrequencyChart',
                                    characteristic: 'documenttype',
                                    noDataText: config.resources['documenttype-no-data'],
                                    title: config.resources['documenttype-title']
                                }
                            ]
                        },
                        {
                            xtype: 'Hippo.Targeting.VisitorCharacteristics'
                        }
                    ]
                }
            ]
        });
        Hippo.Hgge.VisitorDetailsPanel.superclass.constructor.call(this, config);
    }

});
