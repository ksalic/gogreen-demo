/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.onehippo.cms7.targeting.data.RequestLogEntry;

import java.io.*;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class RequestLogReader implements Closeable, Iterable<RequestLogEntry> {

    private final BufferedReader reader;
    private final ObjectMapper mapper = new ObjectMapper();
    private final Iterator<RequestLogEntry> iterator;

    public RequestLogReader(InputStream inputStream) throws IOException {
        if (inputStream == null) {
            throw new IOException("request data not found");
        }
        this.reader = new BufferedReader(new InputStreamReader(inputStream));
        this.iterator = new Iterator<RequestLogEntry>() {
            private RequestLogEntry next = null;
            private boolean done = false;

            private void fetchNext() {
                if (done || next != null) {
                    return;
                }

                String line;
                try {
                    while ((line = reader.readLine()) != null) {
                        if (line.indexOf(':') < 0) {
                            continue;
                        }
                        String requestLogAsString = line.substring(line.indexOf(':') + 1);
                        next = mapper.readValue(requestLogAsString, RequestLogEntry.class);
                        break;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                if (next == null) {
                    done = true;
                }
            }

            @Override
            public boolean hasNext() {
                fetchNext();
                return !done;
            }

            @Override
            public RequestLogEntry next() {
                fetchNext();
                if (done) {
                    throw new NoSuchElementException();
                }
                RequestLogEntry result = next;
                next = null;
                return result;
            }
        };
    }

    @Override
    public void close() throws IOException {
        reader.close();
    }

    @Override
    public Iterator<RequestLogEntry> iterator() {
        return iterator;
    }
}
