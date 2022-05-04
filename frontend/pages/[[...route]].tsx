import React from 'react';
import axios from 'axios';
import {GetServerSideProps, InferGetServerSidePropsType} from 'next';
import {BrPage} from '@bloomreach/react-sdk';
import {Document, ImageSet, initialize} from '@bloomreach/spa-sdk';
import {relevance} from '@bloomreach/spa-sdk/lib/express';
import {OneColumnLayout} from "../components/layouts/one-column-layout";
import {BannerCollection} from "../components/cms/BannerCollection";
import {BrLayout} from "../components/partials/BrLayout";
import {BrPropertyContext} from '../components/provider/BrPropertyProvider';
import Head from 'next/head';
import {XPage} from "../components/types/content";
import useScript from "../components/cms/utils/UseScript";
import {TwoColumnLayout} from "../components/layouts/two-column-layout";

export const getServerSideProps: GetServerSideProps = async ({
                                                                 req: request,
                                                                 res: response,
                                                                 resolvedUrl: path,
                                                                 query
                                                             }) => {
    relevance(request, response);

    const endpoint = query.endpoint

    const axiosConfig = request?.headers?.cookie ? {
        headers: {
            cookie:
            request?.headers?.cookie
        }
    } : {}

    const configuration = {
        path,
        endpoint: endpoint ?? process.env.BRXM_ENDPOINT,
        endpointQueryParameter: 'endpoint',
    };
    const page = await initialize({...configuration, request, httpClient: axios.create(axiosConfig)});

    return {
        props: {
            configuration,
            page: page.toJSON(),
            binariesUrl: process.env.BRXM_BINARIES
            // gqlUrl: page.getChannelParameters().gqlUrl ?? process.env.BRXM_GQLURL,
        }
    };
};


const components = {
    BannerCollection,
};

const layouts = {
    'one-column': OneColumnLayout,
    'two-column': TwoColumnLayout
};

export default function Index({
                                  configuration,
                                  page,
                                  binariesUrl
                                  // gqlUrl,
                              }: InferGetServerSidePropsType<typeof getServerSideProps>): JSX.Element {


    const pageModel = initialize(configuration, page);

    const documentData = pageModel?.getDocument<Document>()?.getData<XPage>();
    const ogImageLink: string | undefined = documentData?.ogimage && pageModel?.getContent<ImageSet>(documentData.ogimage)?.getOriginal()?.getUrl();

    pageModel.getChannelParameters()?.additionalJs && useScript(binariesUrl + pageModel.getChannelParameters().additionalJs);

    return (
        <>
            {documentData && (
                <Head>
                    <title>{pageModel.getChannelParameters().pageTitlePrefix + " - " + documentData.title}</title>
                    <meta name="description"
                          content={documentData.metadescription}/>
                    <meta name="robots" content={documentData.metarobots}/>
                    <meta property="og:title"
                          content={documentData.ogtitle}/>
                    <meta property="og:type" content={documentData.ogtype}/>
                    <meta property="og:url"
                          content={pageModel?.getDocument<Document>()?.getUrl()}/>
                    {ogImageLink &&
                    <meta property="og:image" content={ogImageLink}/>}
                    {pageModel.getChannelParameters()?.themeCss &&
                    <link rel="stylesheet" type="text/css"
                          href={binariesUrl + pageModel.getChannelParameters().themeCss}/>}
                </Head>)
            }
            <BrPage configuration={{...configuration, httpClient: axios}} mapping={components} page={page}>
                <BrPropertyContext.Provider value={{binariesUrl: binariesUrl}}>
                    <BrLayout layouts={layouts}/>
                </BrPropertyContext.Provider>
            </BrPage>
        </>
    );
}
