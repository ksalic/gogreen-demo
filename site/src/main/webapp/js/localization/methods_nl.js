/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

/*
 * Localized default methods for the jQuery validation plugin.
 * Locale: NL
 */
jQuery.extend(jQuery.validator.methods, {
	date: function(value, element) {
		return this.optional(element) || /^\d\d?[\.\/-]\d\d?[\.\/-]\d\d\d?\d?$/.test(value);
	}
});