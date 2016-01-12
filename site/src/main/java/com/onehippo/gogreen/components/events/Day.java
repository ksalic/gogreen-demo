/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.events;

import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import com.onehippo.gogreen.beans.EventDocument;

import org.hippoecm.hst.content.beans.standard.facetnavigation.HippoFacetSubNavigation;

public class Day implements IDay {
    
    private int dayOfMonth;
    private List<EventDocument> events;
    private int numberOfEvents;
    /**
     * place holder to indicate that this Day is not real, but only a dummy placeholder in the week list (this, the days in the week of the
     * previous or next month)
     */
    private boolean dummy = false;


    public Day(Calendar cal, HippoFacetSubNavigation eventsForDay, boolean dummy) {
        if (dummy) {
            this.dummy = dummy;
            return;
        }
        dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);
        if (eventsForDay == null) {
            events = Collections.emptyList();
        } else {
            events = eventsForDay.getResultSet().getDocuments(EventDocument.class);
            numberOfEvents = events.size();
        }
    }

    public boolean isDummy() {
        return dummy;
    }

    public boolean isToday() {
        return false;
    }

    public int getDayOfMonth() {
        return dayOfMonth;
    }

    public List<EventDocument> getEvents() {
        return events;
    }

    public EventDocument getFirstEvent() {
        if (events.size() > 0) {
            return events.get(0);
        }
        return null;
    }

    public int getNumberOfEvents() {
        return numberOfEvents;
    }
}
