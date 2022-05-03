import React, {ReactChild, useContext, useEffect, useMemo} from 'react';
import {BrComponent, BrPageContext} from '@bloomreach/react-sdk';
import {BrxHeader} from "../partials/BrxHeader";
import {BrxFooter} from "../partials/BrxFooter";
import {isEdgeBrowser, isSafariBrowser} from "../../utils";
import {MobileMenu} from "../partials/MobileMenu";
import {ApolloClient, createHttpLink, InMemoryCache} from "@apollo/client";
import {BrPropertyContext} from '../provider/BrPropertyProvider';
import {ApolloProvider} from "@apollo/react-hooks";
import {Helmet} from "react-helmet";

type Props = {
    children: ReactChild
}



export function BaseLayout(props: Props): JSX.Element | null {


    let scrollTop: Element | null;

    function scrollHandler() {
        if (window.pageYOffset >= 400) {
            scrollTop?.classList.add('show');
        } else {
            scrollTop?.classList.remove('show');
        }
    }

    useEffect(() => {
        scrollTop = document.querySelector('#scroll-top');
        window.addEventListener('scroll', scrollHandler, false);
    }, [])

    function hideMobileMenu() {
        document?.querySelector('body')?.classList.remove('mmenu-active');
    }

    function toScrollTop() {
        if (isSafariBrowser() || isEdgeBrowser()) {
            let pos = window.pageYOffset;
            let timerId = setInterval(() => {
                if (pos <= 0) clearInterval(timerId);
                window.scrollBy(0, -120);
                pos -= 120;
            }, 1);
        } else {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }
    }

    const {gqlUrl} = useContext(BrPropertyContext);

    const apolloClient = useMemo(() => new ApolloClient({
        ssrMode: true,
        cache: new InMemoryCache(),
        link: createHttpLink({
            uri: gqlUrl
        }),
    }), [gqlUrl]);

    return (
        <ApolloProvider client={apolloClient}>
            <div className="page-wrapper">
                <BrxHeader/>
                {props.children}
                <BrxFooter/>
            </div>
            <div className="mobile-menu-overlay" onClick={hideMobileMenu}></div>
            <button id="scroll-top" title="Back to top" onClick={toScrollTop}>
                <i className="icon-arrow-up"></i>
            </button>
            <BrComponent path="menu">
                <MobileMenu/>
            </BrComponent>
        </ApolloProvider>
    )

}
