import {brxSearchAlgo, brxsfExternalLink} from "../../types/content";
import {Content, Document, isDocument, Page, Reference} from "@bloomreach/spa-sdk";
import {TreeCategory} from "../../../server/discoveryFunctions";

export function sliceIntoChunks(arr: TreeCategory[], chunkSize: number) {
    const res = [];
    for (let i = 0; i < arr.length; i += chunkSize) {
        const chunk = arr.slice(i, i + chunkSize);
        res.push(chunk);
    }
    return res;
}

export function createComponentMarginClassName(properties: any) {
    return `${properties['mb'] ? "mb-" + properties['mb'] : ''}
     ${properties['mt'] ? "mt-" + properties['mt'] : ''}
     `.replace(/\s{2,}/g, ' ');
}

export function createItemsInViewportClassName(properties: any) {
    return `${properties.xs ? "col-" + convertColumnSetting(properties.xs) : ''}
     ${properties.sm ? "col-sm-" + convertColumnSetting(properties.sm) : ''}
     ${properties.md ? "col-md-" + convertColumnSetting(properties.md) : ''} 
     ${properties.lg ? "col-lg-" + convertColumnSetting(properties.lg) : ''} 
     ${properties.xl ? "col-xl-" + convertColumnSetting(properties.xl) : ''}`.replace(/\s{2,}/g, ' ');
}

export function convertColumnSetting(option: any): string {
    const number = Number(option)
    return Number.isInteger(number) ? (12 / number) : option
}

export function slugify(str: string) {
    str = str.replace(/^\s+|\s+$/g, ''); // trim
    str = str.toLowerCase();

    // remove accents, swap ñ for n, etc
    var from = "àáäâèéëêìíïîòóöôùúüûñç·/_,:;";
    var to = "aaaaeeeeiiiioooouuuunc------";
    for (var i = 0, l = from.length; i < l; i++) {
        str = str.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
    }

    str = str.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
        .replace(/\s+/g, '-') // collapse whitespace and replace by -
        .replace(/-+/g, '-'); // collapse dashes

    return str;
}


export function toHref(ctaLink: brxsfExternalLink | Reference, page?: Page): string {
    if (ctaLink && Object.prototype.hasOwnProperty.call(ctaLink, 'contentType')) {
        return (ctaLink as brxsfExternalLink).link
    } else if (ctaLink && Object.prototype.hasOwnProperty.call(ctaLink, '$ref')) {
        const reference = ctaLink as Reference;
        const content: Object | Content | undefined = page?.getContent(reference);
        if (content && isDocument(content)) {
            return (content as Document).getUrl() as string;
        } else {
            const unknown = content as { type: string, data: any };
            if (unknown && unknown.type === 'asset') {
                return unknown.data.asset.links.site.href as string;
            }
        }
    }
    return '#'
}

export function getAlgorithm(algorithm?: Array<brxSearchAlgo>): brxSearchAlgo | undefined {
    return algorithm && algorithm[0]
}

export interface BrxsfProps<T> {
    item: T;
    page: Page;
}

export function getText(text: string): string {
    return text.replace('\n', '<br/>')
}

