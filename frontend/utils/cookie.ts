// Copyright 2021 Bloomreach. All rights reserved. (https://www.bloomreach.com/)

import cookie from 'cookie';

/**
 * Check if Window is available
 */
function isWindowAvailable(): boolean {
    return typeof window !== 'undefined';
}

/**
 * Set cookie
 * @param name Cookie name
 * @param value Cookie value
 * @param maxAge  Sets the cookie max-age in seconds
 */
export function setCookie(name: string, value: string, maxAge?: number): void {
    if (isWindowAvailable() && name && value) {
        document.cookie = cookie.serialize(name, value, {maxAge, sameSite: 'strict'} );
    }
}

/**
 * Retrieve data from cookie
 * @return Cookie object.
 */
export function getCookie(): Record<string, string> {
    return isWindowAvailable() ? cookie.parse(document.cookie ?? '') : {};
}

/**
 * Remove cookie by name
 * @param name Cookie name
 */
export function removeCookie(name: string): void {
    if (!isWindowAvailable()) return;

    document.cookie = cookie.serialize(name, '', {maxAge: 0});
}
