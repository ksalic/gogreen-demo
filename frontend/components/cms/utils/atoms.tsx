import {BrxsfProps, toHref} from "./utils";
import {brxsfCta} from "../../types/content";
import ALink from "../../features/alink";

export function Cta({item, page}: BrxsfProps<brxsfCta>): JSX.Element {
    const link = item.link[0];
    const key = item.type.selectionValues[0].key;
    const type = key ?? 'link'
    const className = type === 'button' ? 'btn btn-primary btn-rounded' : 'banner-link';
    const isButton = type === 'button';
    const href: string = toHref(link, page);
    return (<ALink href={page.getUrl(href)} className={className}>
        <span>{item.text}</span>
        {isButton && <i className="icon-long-arrow-right"></i>}
    </ALink>);
}