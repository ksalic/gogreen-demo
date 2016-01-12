/**
 * Copyright 2010-2014 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.exceptions;

/**
 * This exception can be thrown when, for example, a hippo bean cannot be found. 
 * The PageErrorHandler can react upon this exception.
 */
public class BeanNotFoundException extends ContentRelatedException {

    private static final long serialVersionUID = 1L;

    /**
     * Constructs a new BeanNotFoundException exception with the given message. 
     *
     * @param   message
     *          the exception message
     */
    public BeanNotFoundException(String message) {
        super(message);
    }

}
