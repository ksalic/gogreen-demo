import React, {ChangeEvent} from "react";
// @ts-ignore
import SlideToggle from "react-slide-toggle";
import {useRouter} from "next/router";
import {slugify} from "../cms/utils/utils";
import {FacetField} from "../../server/discoveryFunctions";

export type FacetProp = {
    facet: FacetField
}

export function GenericMultiSelectFacet({facet}: FacetProp): JSX.Element | null {

    const router = useRouter();
    const query = {...router.query}
    delete query.route;
    const layout = router.query.layout ?? '4cols';
    const path = router.query.route && `/${(router.query.route as [string]).join("/")}`;

    function containsAttrInUrl(type: string, value: string) {
        const currentQueries = query[type] ? (query[type] as string).split(',') : [];
        return currentQueries && currentQueries.includes(value);
    }

    function getUrlForAttrs(type: string, value: string) {
        let currentQueries = query[type] ? (query[type] as string).split(',') : [];
        currentQueries = containsAttrInUrl(type, value) ? currentQueries.filter(item => item !== value) : [...currentQueries, value];
        const rnt = {
            query: {
                ...query,
                page: 1,
                [type]: currentQueries.join(',')
            }
        }
        return rnt;
    }

    function onAttrClick(e: ChangeEvent, attr: string, value: string) {
        const urlForAttrs = getUrlForAttrs(attr, value);
        if (urlForAttrs) {
            let queryObject = urlForAttrs.query;
            let url = path + '?';
            for (let key in queryObject) {
                url += key + '=' + queryObject[key] + '&';
            }
            router.push(url);
        }
    }

    return (
        <SlideToggle collapsed={false}>
            {({onToggle, setCollapsibleElement, toggleState}: any) => (
                <div className="widget widget-collapsible">
                    <h3 className="widget-title mb-2">
                        <a href={`#${slugify(facet.name)}`}
                           className={`${toggleState.toLowerCase() == 'collapsed' ? 'collapsed' : ''}`}
                           onClick={(e) => {
                               onToggle(e);
                               e.preventDefault()
                           }}>{facet.name}</a>
                    </h3>
                    <div ref={setCollapsibleElement}>
                        <div className="widget-body pt-0">
                            <div className="filter-items filter-items-count">
                                {facet.values.map((value, index) => {
                                    return (
                                        <div className="filter-item" key={index}>
                                            <div className="custom-control custom-checkbox">
                                                <input type="checkbox"
                                                       className="custom-control-input"
                                                       id={`${facet.name}-${index + 1}`}
                                                       onChange={e => onAttrClick(e, facet.name, value.id)}
                                                       checked={containsAttrInUrl(facet.name, value.id) ? true : false}
                                                />
                                                <label className="custom-control-label"
                                                       htmlFor={`${facet.name}-${index + 1}`}>{value.name}</label><span
                                                className="item-count">{value.count}</span>
                                            </div>
                                        </div>
                                    )
                                })}
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </SlideToggle>
    );
}