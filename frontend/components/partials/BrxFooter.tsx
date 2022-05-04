import {Document} from "@bloomreach/spa-sdk";
import {BrPageContext} from "@bloomreach/react-sdk";
import React, {useContext} from "react";
import ALink from "../features/alink";
import {XPage} from "../types/content";
import {BrPropertyContext} from "../provider/BrPropertyProvider";

// import {FooterMenu} from "../cms/FooterMenu";

export function BrxFooter(): JSX.Element | null {

    const {binariesUrl} = useContext(BrPropertyContext);

    return (
        <footer className="footer footer-dark">
            <div className="footer-middle">
                <div className={'container'}>
                    <div className="row">
                        <div className="col-sm-6 col-lg-3">
                            <div className="widget widget-about">
                                <BrPageContext.Consumer>
                                    {page => {
                                        const documentData = page?.getDocument<Document>()?.getData<XPage>();
                                        return (
                                            <>
                                                <ALink href={page?.getUrl("/")}>
                                                    <img
                                                        src={`${binariesUrl}${page?.getChannelParameters()?.logo}`}
                                                        alt="Bloomreach Storefront"
                                                        className="footer-logo"
                                                        width="130"
                                                        height="30"/>
                                                </ALink>
                                                <p>{documentData?.metadescription}</p>
                                            </>
                                        )
                                    }}
                                </BrPageContext.Consumer>
                            </div>
                        </div>
                        {/*<BrComponent path="footer-menu">*/}
                        {/*    <FooterMenu/>*/}
                        {/*</BrComponent>*/}
                    </div>
                </div>
            </div>
            <div className="footer-bottom">
                <div className={'container'}>
                    <p className="footer-copyright">Copyright © {(new Date()).getFullYear()} Bloomreach
                        Storefront. All Rights
                        Reserved.</p>
                    <figure onClick={() => {
                        // @ts-ignore
                        exponea.identify('lucy.reid@bloomreach.com');
                        alert("Hello ...");
                    }} id="make-lucy" className="footer-payments">
                        <img src="/images/payments.png" alt="Payment methods" width="272" height="20"/>
                    </figure>
                </div>
            </div>
        </footer>
    );
}