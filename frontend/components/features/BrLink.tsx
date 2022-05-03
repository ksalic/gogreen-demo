import Link from "next/link";
import React, {CSSProperties} from "react";
import {LinkProps} from "next/dist/client/link";

interface BrLinkProps extends React.PropsWithChildren<LinkProps> {
    className?: string,
    style?: CSSProperties
}

export function BrLink({href, children, className = '', style = {}, ...props}: BrLinkProps) {

    function defaultFunction(event: React.MouseEvent<HTMLAnchorElement>) {
        if (href == '#') {
            event.preventDefault();
        }
    }

    return (
        <Link href={href} {...props}>
            <a className={className} style={style} onClick={event => defaultFunction(event)}>
                {children}
            </a>
        </Link>
    )
}