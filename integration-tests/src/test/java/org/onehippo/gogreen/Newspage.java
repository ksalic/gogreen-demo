/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package org.onehippo.gogreen;

import java.util.Calendar;

import org.testng.annotations.Test;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;

public class Newspage extends GoGreenTest {

	@Test
    public void testNewspage() throws Exception {
        selenium.setTimeout("60000");
		selenium.open("/site/news");
		assertTrue(selenium.isTextPresent(""));
		assertEquals(selenium.getTitle(), "Hippo Go Green - News Overview");
		assertTrue(selenium.isElementPresent("link=Home"));
		assertTrue(selenium.isElementPresent("link=News & Events"));
		assertTrue(selenium.isElementPresent("link=Jobs"));
		assertTrue(selenium.isElementPresent("link=Products"));
		assertTrue(selenium.isElementPresent("link=About"));
		assertTrue(selenium.isElementPresent("//div[@id='news']/ul[4]/li[5]"));
		assertTrue(selenium.isElementPresent("//div[@id='left']/div/div[2]/ul/li[3]"));
		assertEquals(selenium.getText("//ul[@id='tagcloud']/li[2]"), "Turbines Climate Green Energy Tesla CO2");
		assertTrue(selenium.isElementPresent("//ul[@id='tagcloud']/li[2]"));
		assertEquals(selenium.getText("link=Next"), "Next");
		assertEquals(selenium.getText("text-size"), "Text size: A A A");
		assertTrue(selenium.isTextPresent("Text size: A A A \n \n \n Edition: United States France Nederland Home News & Events Jobs Products About"));
		assertTrue(selenium.isElementPresent("//img[@alt='onehippo.com']"));
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
