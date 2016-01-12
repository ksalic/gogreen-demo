/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package org.onehippo.gogreen;

import org.testng.annotations.Test;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;

public class SimpleTest extends GoGreenTest {

	@Test
    public void testSimple() throws Exception {
        selenium.setTimeout("60000");
		selenium.open("/site/");
		assertTrue(selenium.isTextPresent(""));
		selenium.click("link=News & Events");
		selenium.waitForPageToLoad("300000");
		assertEquals(selenium.getTitle(), "Hippo Go Green - News Overview");
		assertTrue(selenium.isTextPresent("SERVICE"));
		assertTrue(selenium.isTextPresent("Contact"));
		assertTrue(selenium.isTextPresent("FAQ"));
		assertTrue(selenium.isTextPresent("RSS"));
		assertTrue(selenium.isTextPresent("Sitemap"));
		assertTrue(selenium.isTextPresent("API"));
		assertEquals(selenium.getText("link=Sitemap"), "Sitemap");
		assertEquals(selenium.getText("link=Contact"), "Contact");
		assertEquals(selenium.getText("link=FAQ"), "FAQ");
		assertEquals(selenium.getText("link=RSS"), "RSS");
		assertEquals(selenium.getText("link=API"), "API");
	}
}
