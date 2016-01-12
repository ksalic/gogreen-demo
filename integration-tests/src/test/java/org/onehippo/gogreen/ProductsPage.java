/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package org.onehippo.gogreen;

import java.util.Calendar;

import org.testng.annotations.Test;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;

public class ProductsPage extends GoGreenTest {

	@Test
    public void testProductsPage() throws Exception {
        selenium.setTimeout("60000");
		selenium.open("/site/products");
		assertTrue(selenium.isTextPresent(""));
		assertEquals(selenium.getTitle(), "Hippo Go Green - Products");
		assertTrue(selenium.isElementPresent("link=Home"));
		assertTrue(selenium.isElementPresent("link=News & Events"));
		assertTrue(selenium.isElementPresent("link=Jobs"));
		assertTrue(selenium.isElementPresent("link=Products"));
		assertTrue(selenium.isElementPresent("link=About"));
		assertTrue(selenium.isElementPresent("//div[@id='left']/div/div[2]/ul"));
		assertTrue(selenium.isElementPresent("//div[@id='products']/ul[5]/li[5]"));
		assertTrue(selenium.isElementPresent("//div[@id='right']/ul[2]/li[2]/form/table/tbody/tr[3]/td[1]"));
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
