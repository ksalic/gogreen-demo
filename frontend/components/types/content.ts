import {Reference} from '@bloomreach/spa-sdk';
import {DocumentContent} from "../cms/declarations";

export interface SelectionValue {
    key: string;
    label: string;
}

export interface SelectableString {
    sourceName?: any;
    selectionValues: SelectionValue[];
}

export interface CategoryHighlight {
    title: string
    connectorid: SelectableString
    CommerceCategoryCompound: CommerceCategoryCompound[]
}

export interface CommerceCategoryCompound {
    categoryid: string
}

export interface CommerceProductCompound {
    productid: string
    variantid: string
}

export interface ProductHighlight {
    title: string
    connectorid: SelectableString
    CommerceProductCompound: CommerceProductCompound[]
}

export interface WidgetCompound {
    widgetalgo: SelectableString
    widgetid: string
}

export interface banner {
    title: string
    content: DocumentContent
    image: Reference
    cta: string
    link: Reference
}

export interface bannercarousel {
    banners: bannercompound[]
}

export interface bannercompound {
    title: string
    content: DocumentContent
    image: Reference
    cta: string
    link: Reference
}

export interface bannercta {
    title: string
    content: DocumentContent
    cta: string
    link: Reference
}

export interface bannergallery {
    title: string
    banners: bannercompound[]
}

export interface content {
    title: string
    introduction: string
    content: DocumentContent
    image: Reference
    date: Date
}

export interface pathways {
    WidgetCompound: WidgetCompound
    ProductCompound: CommerceProductCompound[]
    CategoryCompound: CommerceCategoryCompound
    keyword: string
}

export interface productgrid {
    title: string
    searchtype: SelectableString
    query: string
    category: CommerceCategoryCompound
}

export interface titleandtext {
    title: string
    text: string
}

export interface basepage {
    title: string
    description: string
}

export interface brxsfBanner {
    image: Reference
    subtitle: string
    text: string
    content: DocumentContent
    style: SelectableString
    cta: brxsfCta[]
}

export interface brxsfCta {
    link: Array<brxsfExternalLink | Reference>
    text: string
    type: SelectableString
}

export interface brxsfExternalLink extends typeAble {
    link: string
    target: string
}

export interface brxsfBannerCollection {
    title: string
    banners: brxsfBanner[]
}

export interface brxsfFindItemsByKeyword extends brxSearchAlgo {
    query: string
    pattern: string
    offset: number
    limit: number
}

export interface brxSearchAlgo {
    contentType: string
}

export interface typeAble {
    contentType: string
}

export interface brxsfFindItemsByCategory extends brxSearchAlgo {
    category: CommerceCategoryCompound
    pattern: string
    offset: number
    limit: number
}

export interface bsfProductsRecommendedForYou extends brxSearchAlgo{
    title: string
    cookie: string
    type: string
    prop: string
    offset: number
    limit: number
}

export interface bsfProductsQuoted extends brxSearchAlgo{
    title: string
    offset: number
    limit: number
}

export interface brxsfFindItemsMoreLikeThis extends brxSearchAlgo {
    product: CommerceProductCompound
    pattern: string
    offset: number
    limit: number
}

export interface brxsfProductSearch {
    title: string
    algorithm: any[]
}

export interface brxsfFindItemsByProductID extends brxSearchAlgo {
    products: CommerceProductCompound[]
    pattern: string
    offset: number
    limit: number
}

export interface brxsfVideo {
    videourl: string
    poster: Reference
    banner: brxsfBanner
}

export interface brxsfIntroSlider {
    slides: brxsfBanner[]
}

export interface brxsfCustomItem {
    label: string
    image: Reference
    displayname: string
    price: string
    cta: brxsfCta
}

export interface brxsfCustomItems extends brxSearchAlgo {
    items: brxsfCustomItem[]
}

export interface BasePage {
    description: string;
    title: string;
    localeString: string;
}

export interface XPage {
    ogtype: string;
    ogtitle: string;
    ogimage?: Reference;
    metadescription: string;
    metarobots: string;
    title: string;
    localeString: string;
    contentType: string;
    id: string;
}
