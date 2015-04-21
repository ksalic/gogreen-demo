/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *         http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.onehippo.hgge.targeting;

import java.util.Map;

import com.onehippo.cms7.targeting.Scorer;
import com.onehippo.cms7.targeting.data.TargetingData;

import org.apache.commons.jexl2.Expression;
import org.apache.commons.jexl2.JexlContext;
import org.apache.commons.jexl2.JexlEngine;
import org.apache.commons.jexl2.MapContext;
import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class AbstractJexlScorer<T extends TargetingData> implements Scorer<T> {

    private static Logger log = LoggerFactory.getLogger(AbstractJexlScorer.class);

    private JexlEngine jexlEngine = new JexlEngine();

    protected JexlEngine getJexlEngine() {
        return jexlEngine;
    }

    protected double evaluateExpression(final String expression, final Map<String, Object> vars) {
        try {
            Expression e = jexlEngine.createExpression(expression);
            JexlContext context = new MapContext(vars);
            Object o = e.evaluate(context);

            if (o == null) {
                return 0.0;
            }

            if (o instanceof Boolean) {
                if (((Boolean) o).booleanValue()) {
                    return 1.0;
                } else {
                    return 0.0;
                }
            } else if (o instanceof Double) {
                double value = ((Double) o).doubleValue();

                if (value >= 0.0 && value <= 1.0) {
                    return value;
                } else {
                    log.warn("Invalid value from the expression evaluation: {}. Returning 0.0 instead.", value);
                    return 0.0;
                }
            } else {
                double value = NumberUtils.toDouble(o.toString(), 0.0);

                if (value >= 0.0 && value <= 1.0) {
                    return value;
                } else {
                    log.warn("Invalid value from the expression evaluation: {}. Returning 0.0 instead.", value);
                    return 0.0;
                }
            }
        } catch (Exception e) {
            log.warn("Failed to evaluate expression: {}", expression, e);
        }

        return 0.0;
    }

}
