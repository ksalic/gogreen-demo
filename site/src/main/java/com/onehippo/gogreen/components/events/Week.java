/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.events;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class Week {

    private int weekOfMonth;
    private int weekOfYear;


    /**
     * The ordered list of day of this month. The days start at {@link com.onehippo.gogreen.components.events.EventCalendarMonth#FIRST_DAY_OF_WEEK}. If the first of last
     * week has days that are not part of the current month, the Day is still added as a {@link NoopDay}, to make rendering view as
     * easy as possible
     */
    private List<Day> days = new ArrayList<Day>();

    public Week(Calendar cal) {
        this.weekOfMonth = cal.get(Calendar.WEEK_OF_MONTH);
        this.weekOfYear = cal.get(Calendar.WEEK_OF_YEAR);
    }

    public void addDay(Day day) {
        days.add(day);
    }

    public int getWeekOfMonth() {
        return weekOfMonth;
    }

    public int getWeekOfYear() {
        return weekOfYear;
    }

    public List<Day> getDays() {
        return days;
    }

}