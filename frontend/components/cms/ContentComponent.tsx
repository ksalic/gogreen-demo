import {BrManageContentButton, BrPageContext} from '@bloomreach/react-sdk';
import React from "react";
import PageHeader from "../features/page-header";
import {Content} from "@bloomreach/spa-sdk";
import {Html} from "./BannerCollection";

export interface PageContent {
    name: string;
    displayName: string;
    content: Html;
    title: string;
    subtitle: string;
    metarobots: string;
    metadescription: string;
    ogtitle: string;
    ogtype: string;
    ogimage: null;
    createdBy: string;
    creationDate: number;
    lastModifiedBy: string;
    lastModificationDate: number;
    publicationDate: number;
    localeString: string;
    contentType: string;
    id: string;
}

export function ContentComponent(): JSX.Element | null {

    const page = React.useContext(BrPageContext);
    const content = page?.getDocument<Content>();
    if (!content) {
        return <h1>non existing document</h1>
    }
    const {title, subtitle, content: html} = content.getData<PageContent>();

    return (
        <>
            <PageHeader title={title} subTitle={subtitle}/>
            <div className="page-content my-5 position-relative">
                <BrManageContentButton content={content}/>
                <div className="container">
                    <div dangerouslySetInnerHTML={{__html: html.value}}/>
                </div>
            </div>
        </>
    )
}
