import React from 'react';
import {BrManageContentButton, BrProps} from '@bloomreach/react-sdk';
import {ContainerItem, Content, ImageSet, Reference} from '@bloomreach/spa-sdk';
import ALink from "../features/alink";
import OwlCarousel from "../features/owl-carousel";


export interface BannerItemCta {
    text: string;
    link: Reference;
    style: string;
    contentType: string;
}

export interface Html {
    contentType: string;
    value: string;
}

export interface BannerEntity {
    banneritemcta: BannerItemCta;
    subtitle: string;
    title: string;
    theme: string;
    content: Html;
    contentType: string;
    image: Reference
    bynderimage: string
}

export interface BannerCollection {
    columns: string;
    style: string;
    fullwidth: boolean;
    bannerentity: BannerEntity[];
    localeString: string;
}

export interface BannerCollectionProperties {
    document: Reference
}

export function getColumns(option: any): number {
    let opt = option;
    if (option === 'single') {
        opt = 1;
    }
    const number = Number(opt)
    return number;
}

export function convertColumnSetting(option: any): string {
    let opt = option;
    if (option === 'single') {
        opt = 1;
    }
    const number = Number(opt)
    return "col-" + (Number.isInteger(number) ? (12 / number) : opt)
}


export function BannerCollection({component, page}: BrProps<ContainerItem>): JSX.Element | null {

    const bannerCollectionProperties = component.getParameters<BannerCollectionProperties>()

    const docReference = bannerCollectionProperties.document;

    if (!docReference && page.isPreview()) {
        return (
            <div className={"jumbotron"}>
                <h2 className={"position-relative"}>
                    <BrManageContentButton relative={false} parameter={"document"} path={"banners"}
                                           pickerSelectableNodeTypes={"myproject:bannercollection"}
                                           documentTemplateQuery={"new-bannercollection-document"}/>
                    Create create new banner or choose existing:
                </h2>
            </div>
        )
    }

    const bannerCollection = page.getContent<Content>(docReference);

    const bannerCollectionData = bannerCollection?.getData<BannerCollection>();

    if (!bannerCollectionData) {
        return <div>test123</div>;
    }

    const {fullwidth, columns, style} = bannerCollectionData;

    const containerClassName = fullwidth ? 'container-fluid' : 'container';
    const columnClassName = convertColumnSetting(columns);
    const items = getColumns(columns)

    const sliderSetting = {
        nav: false,
        dots: false,
        margin: 20,
        loop: false,
        responsive: {
            0: {
                items: items
            },
            992: {
                nav: items > 1,
                items: items,
                dots: items === 1,
                // loop: items > 1
            }
        }
    }


    return (
        <div className={`${containerClassName} my-4 position-relative`}>
            <BrManageContentButton content={bannerCollection}/>
            <div className="row">
                {style === 'carousel' ?
                    <OwlCarousel adClass={`owl-simple ${items === 1 ? 'owl-nav-inside' : ''}`} options={sliderSetting}>
                        {bannerCollectionData?.bannerentity && bannerCollectionData.bannerentity.map(banner => {
                            const {subtitle, title, content, banneritemcta, theme, bynderimage} = banner
                            const repoImageLink = banner?.image && page.getContent<ImageSet>(banner.image)?.getOriginal()?.getUrl();
                            const bynderImg = bynderimage ? JSON.parse(bynderimage)[0]?.derivatives?.webImage : undefined
                            const imageLink = bynderImg ?? repoImageLink;
                            const {text: ctaText, link: ctaLink, style: ctaStyle} = banneritemcta;
                            const link = ctaLink && page.getContent<Content>(ctaLink)?.getUrl();
                            return (
                                <div style={{minHeight: 200}} className={`banner ${items === 1 ? 'banner-big' : ''}`}>
                                    {imageLink && <ALink href={link ?? '#'}>
                                        <img src={imageLink} alt={'banner'}/>
                                    </ALink>}
                                    <div className="banner-content">
                                        <h4 className={`banner-subtitle ${theme === 'light' ? 'text-primary' : ''}`}>{subtitle}</h4>
                                        <h3 className={`banner-title ${theme === 'light' ? 'text-white' : ''}`}>{title}</h3>
                                        {content?.value.length > 0 && <div className="d-none d-lg-block"
                                                                           dangerouslySetInnerHTML={{__html: content.value}}/>}
                                        <ALink href={link ?? '#'}
                                               className={`${ctaStyle === 'link' ? "banner-link" : "btn btn-primary btn-rounded"}`}>{ctaText}</ALink>
                                    </div>
                                </div>)
                        })}
                    </OwlCarousel>
                    :
                    bannerCollectionData?.bannerentity && bannerCollectionData.bannerentity.map(banner => {
                        const {subtitle, title, content, banneritemcta, theme, bynderimage} = banner
                        const repoImageLink = banner?.image && page.getContent<ImageSet>(banner.image)?.getOriginal()?.getUrl();
                        const bynderImg = bynderimage ? JSON.parse(bynderimage)[0]?.derivatives?.webImage : undefined
                        const imageLink = bynderImg ?? repoImageLink
                        const {text: ctaText, link: ctaLink, style: ctaStyle} = banneritemcta;
                        const link = ctaLink && page.getContent<Content>(ctaLink)?.getUrl();
                        return (
                            <div className={columnClassName}>
                                <div style={{minHeight: 200}} className={`banner ${style === 'large' ? "banner-big" : ""}`}>
                                    {imageLink && <ALink href={link ?? '#'}>
                                        <img src={imageLink} alt={'banner'}/>
                                    </ALink>}

                                    <div className="banner-content">
                                        <h4 className={`banner-subtitle ${theme === 'light' ? 'text-primary' : ''}`}>{subtitle}</h4>
                                        <h3 className={`banner-title ${theme === 'light' ? 'text-white' : ''}`}>{title}</h3>
                                        {content?.value.length > 0 &&
                                        <div className={`d-none d-lg-block ${theme === 'light' ? 'content-white' : ''}`}
                                             dangerouslySetInnerHTML={{__html: content.value}}/>}
                                        <ALink href={link ?? '#'}
                                               className={`${ctaStyle === 'link' ? "banner-link" : "btn btn-primary btn-rounded"}`}>{ctaText}</ALink>
                                    </div>
                                </div>
                            </div>)
                    })}
            </div>
        </div>
    )
}
