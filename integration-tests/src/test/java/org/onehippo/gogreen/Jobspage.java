/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package org.onehippo.gogreen;

import java.util.Calendar;

import org.testng.annotations.Test;

import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class Jobspage extends GoGreenTest {

    @Test
    public void testJobspage() throws Exception {
        selenium.setTimeout("60000");
		selenium.open("/site/jobs");
		assertTrue(selenium.isTextPresent(""));
		assertEquals("Hippo Go Green - Jobs", selenium.getTitle());
		assertTrue(selenium.isElementPresent("link=Home"));
		assertTrue(selenium.isElementPresent("link=News & Events"));
		assertTrue(selenium.isElementPresent("link=Jobs"));
		assertTrue(selenium.isElementPresent("link=Products"));
		assertTrue(selenium.isElementPresent("link=About"));
		assertTrue(selenium.isElementPresent("//div[@id='jobs-results']/ul[1]/li[3]"));
		assertTrue(selenium.isElementPresent("//ul[@id='filter']/li[2]/ul/li[6]/ul/li[11]"));
		assertTrue(selenium.isElementPresent("link=Terms & Conditions"));
		assertTrue(selenium.isTextPresent("Hippo © 2010-" + Calendar.getInstance().get(Calendar.YEAR)));
		assertEquals(selenium.getText("//div[@id='ft-nav']/div[1]/h3"), "SERVICE");
		assertTrue(selenium.isElementPresent("link=FAQ"));
		assertTrue(selenium.isElementPresent("link=RSS"));
		assertTrue(selenium.isElementPresent("link=Sitemap"));
		assertTrue(selenium.isElementPresent("link=API"));
		assertEquals(selenium.getText("//div[@id='ft-nav']/div[2]/h3"), "SECTIONS");
		assertTrue(selenium.isElementPresent("link=News & Events"));
		assertTrue(selenium.isElementPresent("link=Jobs"));
		assertTrue(selenium.isElementPresent("link=Products"));
		assertTrue(selenium.isElementPresent("link=About"));
		assertTrue(selenium.isElementPresent("link=Mobile"));
		assertTrue(selenium.isElementPresent("ft-disclaimer"));
	}
}
