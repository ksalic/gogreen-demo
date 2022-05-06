import {BrComponent, BrPageContext} from "@bloomreach/react-sdk";
import React, {useContext, useState} from "react";
import ALink from "../features/alink";
import StickyHeader from "../features/sticky-header";
import {MainMenu} from "../cms/MainMenu";
import {BrPropertyContext} from "../provider/BrPropertyProvider";
import CartMenu from "./header/partials/cart-menu";

export function BrxHeader(): JSX.Element | null {

    const [containerClass, setContainerClass] = useState('container');

    function openMobileMenu() {
        document?.querySelector('body')?.classList.add('mmenu-active');
    }

    const {binariesUrl} = useContext(BrPropertyContext);

    return (
        <header className="header header-2 header-intro-clearance">
            <div className="header-middle">
                <div className={ containerClass }>
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
                    </div>
                    <div className="header-right">
                        <CartMenu/>
                    </div>
                </div>
            </div>
            <StickyHeader>
                <div className="header-top sticky-header">
                    <div className={containerClass}>
                        {/*<div className="header-left">*/}
                            <BrComponent path="menu">
                                <MainMenu/>
                            </BrComponent>
                        {/*</div>*/}
                    </div>
                </div>
            </StickyHeader>
        </header>
    );
}