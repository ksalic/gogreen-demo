/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.events;

import java.util.List;

import com.onehippo.gogreen.beans.EventDocument;

public interface IDay {
    /**
     * @return <code>true</code> when this is not a real day but just an empty placeholder day for easy rendering
     */
    boolean isDummy();

    /**
     * @return <code>true</code> when this Day is the current day
     */
    boolean isToday();

    /**
     * @return the day of the month
     */
    int getDayOfMonth();

    /**
     * @return the List of EventDocument's for this Day
     */
    List<EventDocument> getEvents();

    /**
     * @return the first event document when present
     */
    EventDocument getFirstEvent();

    /**
     * @return the number of events for this day
     */
    int getNumberOfEvents();
}