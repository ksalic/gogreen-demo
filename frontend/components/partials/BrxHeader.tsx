import {BrComponent, BrPageContext} from "@bloomreach/react-sdk";
import React, {useContext, useState} from "react";
import ALink from "../features/alink";
import CartMenu from "./header/partials/cart-menu";
import StickyHeader from "../features/sticky-header";
import {MainMenu} from "../cms/MainMenu";
import {HeaderSearch} from "./header/partials/HeaderSearch";
import {Document} from "@bloomreach/spa-sdk";
import {XPage} from "../types/content";
import {BrPropertyContext} from "../provider/BrPropertyProvider";

export function BrxHeader(): JSX.Element | null {

    const [containerClass, setContainerClass] = useState('container');

    function openMobileMenu() {
        document?.querySelector('body')?.classList.add('mmenu-active');
    }

    const {binariesUrl} = useContext(BrPropertyContext);

    return (
        <header className="header header-2 header-intro-clearance">
            <StickyHeader>
                <div className="header-middle">
                    <div className={containerClass}>
                        <div className="header-left">
                            <button className="mobile-menu-toggler" onClick={openMobileMenu}>
                                <span className="sr-only">Toggle mobile menu</span>
                                <i className="icon-bars"></i>
                            </button>
                            <BrPageContext.Consumer>
                                {page => {
                                    return (
                                        <ALink href={page?.getUrl("/")} className="logo" >
                                            <img
                                                src={`${binariesUrl}${page?.getChannelParameters()?.logo}`}
                                                 alt="Bloomreach Storefront"
                                                className="bg-transparent"
                                                width="130"
                                                height="30"/>
                                        </ALink>
                                    )
                                }}
                            </BrPageContext.Consumer>
                        </div>
                        <div className="header-center">
                            <BrComponent path="menu">
                                <MainMenu/>
                            </BrComponent>
                        </div>
                        <div className="header-right">
                        </div>
                    </div>
                </div>
            </StickyHeader>
        </header>
    );
}