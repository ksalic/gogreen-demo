/*
 * Copyright 2022-2022 Bloomreach
 */
package com.onehippo.gogreen.components;

import java.util.Optional;
import java.util.stream.Stream;

import javax.servlet.ServletRequestWrapper;

import org.apache.commons.lang3.StringUtils;
import org.hippoecm.hst.component.support.bean.dynamic.DocumentQueryDynamicComponent;
import org.hippoecm.hst.component.support.bean.info.dynamic.DocumentQueryDynamicComponentInfo;
import org.hippoecm.hst.content.beans.query.builder.Constraint;
import org.hippoecm.hst.content.beans.query.builder.ConstraintBuilder;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.util.SearchInputParsingUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.hippoecm.hst.content.beans.query.builder.ConstraintBuilder.and;
import static org.hippoecm.hst.content.beans.query.builder.ConstraintBuilder.constraint;

/**
 * An HST component implementation that provides searching behaviour on top of the {@link
 * DocumentQueryDynamicComponent}.
 *
 * <p>
 * Any subclass of this class must include the annotation {@link ParametersInfo}, which must specify the interface
 * {@link DocumentSimpleSearchComponentInfo} or an extension of it as its {@link ParametersInfo#type()}.
 * </p>
 * <p>
 * The component inherits the behaviour of its parent {@link DocumentQueryDynamicComponent} (echoing all parameters) and
 * additionally allows for querying, and searching, via the following parameters:
 * </p>
 * <p>
 * Results from the query are set in attribute as model, with key "pagination".
 * Pagination can be controlled via (namespaced) request parameter "page".
 * If there is no query parameter in the request, the message "missing-search-term" is returned, instead of the
 * pagination object.
 * </p>
 *
 * @version $Id$
 */
@ParametersInfo(type = DocumentSimpleSearchComponentInfo.class)
public class DocumentSimpleSearchComponent extends DocumentQueryDynamicComponent {

    private static final Logger log = LoggerFactory.getLogger(DocumentSimpleSearchComponent.class);

    protected static final String DEFAULT_QUERY_PARAMETER_NAME = "q";
    protected static final String SEARCH_TERM_ATTRIBUTE = "searchTerm";
    protected static final String MESSAGE_MODEL_KEY = "message";
    protected static final String MISSING_SEARCH_TERM_MESSAGE = "missing-search-term";

    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) throws HstComponentException {
        Optional<String> term = getSearchTerm(request);
        if (term.isPresent()) {
            term.ifPresent(
                    searchTerm -> {
                        request.setAttribute(SEARCH_TERM_ATTRIBUTE, searchTerm);
                        super.doBeforeRender(request, response);
                    });
        } else {
            request.setModel(MESSAGE_MODEL_KEY, MISSING_SEARCH_TERM_MESSAGE);
        }
    }

    /**
     * Create a (composite, AND-ed) constraint to be used for filtering the query
     *
     * @param request current HST request. Unused, available when overriding
     * @param info    instance of {@link DocumentQueryDynamicComponentInfo}
     * @return a {@link Constraint} to be used in the query
     */
    @Override
    protected Constraint getConstraint(final HstRequest request, final DocumentQueryDynamicComponentInfo info) {

        final Constraint baseConstraint = super.getConstraint(request, info);

        DocumentSimpleSearchComponentInfo simpleSearchInfo = (DocumentSimpleSearchComponentInfo) info;

        return Optional.ofNullable(request.getAttribute(SEARCH_TERM_ATTRIBUTE))
                .filter(attr -> attr instanceof String)
                .map(attr -> (String) attr)
                .map(searchTerm -> {
                    Constraint searchTermConstraint = Stream.of(parseCommaSeparatedValue(simpleSearchInfo.getSearchFields()))
                            .map(simpleField -> toFullyQualifiedName(simpleField, "myproject"))
                            .map(field -> constraint(field).contains(searchTerm))
                            .reduce(ConstraintBuilder::or)
                            .orElse(constraint(".").contains(searchTerm));

                    return and(baseConstraint, searchTermConstraint);
                })
                .orElse(baseConstraint);
    }

    protected String toFullyQualifiedName(final String simpleField, final String defaultNamespace) {
        if (simpleField.contains(":")) {
            return simpleField;
        } else {
            return String.join(":", defaultNamespace, simpleField);
        }
    }

    protected Optional<String> getSearchTerm(final HstRequest request) {
        DocumentSimpleSearchComponentInfo documentSimpleSearchComponentInfo = getComponentParametersInfo(request);
        return Optional.of(request)
                .filter(req -> req instanceof ServletRequestWrapper)
                .map(req -> ((ServletRequestWrapper) request).getRequest())
                .map(req -> {
                    final String queryParamName =
                            Optional.ofNullable(documentSimpleSearchComponentInfo.getSearchTermRequestParameter())
                                    .orElse(DEFAULT_QUERY_PARAMETER_NAME);
                    return req.getParameter(queryParamName);
                })
                .map(searchTerm -> SearchInputParsingUtils.parse(searchTerm, true))
                .filter(StringUtils::isNotBlank);
    }

}
