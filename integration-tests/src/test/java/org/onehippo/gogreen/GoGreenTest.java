/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package org.onehippo.gogreen;

import com.thoughtworks.selenium.Selenium;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverBackedSelenium;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Optional;
import org.testng.annotations.Parameters;

public abstract class GoGreenTest {

    protected static Selenium selenium;
    private static WebDriver driver;

    @BeforeSuite
    @Parameters("driver.url")
    public void startSelenium(@Optional("http://localhost:8080") String url) {
        FirefoxProfile profile = new FirefoxProfile();
        profile.setPreference("extensions.checkCompatibility.5.0", false);
        driver = new FirefoxDriver(profile);

        selenium = new WebDriverBackedSelenium(driver, url);
    }

    @AfterSuite
    public void stopSelenium() {
        driver.quit();
    }

}
