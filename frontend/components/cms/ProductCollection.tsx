import {BrManageContentButton, BrProps} from '@bloomreach/react-sdk';
import {ContainerItem, Content, ImageSet, Reference} from '@bloomreach/spa-sdk';
import ALink from "../features/alink";
import OwlCarousel from "../features/owl-carousel";
// @ts-ignore
import React from "react";
import {findItemsByCategory, findItemsByKeyword, ProductQueryResult} from "../../server/discoveryFunctions";


export interface ProductCollectionProperties {
    document: Reference
}

export interface Searchalgorithm {
    contentType: string;
}

export interface FindItemsByKeyword extends Searchalgorithm {
    limit: number;
    keyword: string;
    offset: number;
}

export interface FindItemsByCategory extends Searchalgorithm {
    category: string;
    limit: number;
    offset: number;
}

export interface FindItemsByProductIDs extends Searchalgorithm {
    products: string;
}

export interface FindItemsMoreLikeThis extends Searchalgorithm {
    product: string;
    limit: number;
    offset: number;
}

export interface ProductCollectionData {
    fullwidth: boolean;
    columns: string;
    title: string;
    style: string;
    searchalgorithm: Searchalgorithm[];
    contentType: string;
}


function getColumns(option: string): number {
    return Number(option);
}

function convertColumnSetting(option: any): string {
    const number = Number(option)
    return "col-" + (Number.isInteger(number) ? (12 / number) : number)
}

function getSearchAlgorithm(productCollectionData: ProductCollectionData): ProductQueryResult {

    const algorithm = getAlgorithm(productCollectionData);
    let productSearchResult: ProductQueryResult = {products: [], errorMessage: "algorithm type did not match registered types"};

    if (algorithm) {
        switch (algorithm.contentType) {
            case 'myproject:findItemsByKeyword':
                const itemsByKeyWord = algorithm as FindItemsByKeyword
                productSearchResult = findItemsByKeyword(itemsByKeyWord.keyword, itemsByKeyWord.offset, itemsByKeyWord.limit);
                break;
            // case 'brxsaas:bsfFindItemsByProductID':
            //     const itemsByProductIDs = productSearchAlgorithm as brxsfFindItemsByProductID
            //     const pids = itemsByProductIDs.products.map(product => {
            //         const [, id,] = product.productid.match(/id=([\w\d._=-]+[\w\d=]?)?;code=([\w\d._=/-]+[\w\d=]?)?/i) ?? [];
            //         return id;
            //     })
            //     productSearchResult = findItemsByProductIDs(pids, itemsByProductIDs.offset, itemsByProductIDs.limit);
            //     break;
            case 'brxsaas:bsfFindItemsByCategory':
                const itemsByKeyCategory = algorithm as FindItemsByCategory
                productSearchResult = findItemsByCategory(itemsByKeyCategory.category, itemsByKeyCategory.offset, itemsByKeyCategory.limit);
                break;
            // case 'brxsaas:bsfFindItemsMoreLikeThis':
            //     const itemsMoreLikeThis = productSearchAlgorithm as brxsfFindItemsMoreLikeThis
            //     const [, id,] = itemsMoreLikeThis.product.productid.match(/id=([\w\d._=-]+[\w\d=]?)?;code=([\w\d._=/-]+[\w\d=]?)?/i) ?? [];
            //     productSearchResult = findItemsMoreLikeThis(id, itemsMoreLikeThis.offset, itemsMoreLikeThis.limit);
            //     break;
            // case 'brxsaas:bsfCustomItems':
            //     const customItems = productSearchAlgorithm as brxsfCustomItems
            //     const products: Array<Product> = customItems.items.map(customItem => {
            //         return {
            //             displayName: customItem.displayname,
            //             listPrice: {moneyAmounts: [{amount: Number(customItem.price)}]},
            //             slug: toHref(customItem.cta.link[0]),
            //             imageSet: {original: {link: {href: page.getContent<ImageSet>(customItem.image)?.getOriginal()?.getUrl()}}},
            //             label: customItem.label,
            //         } as Product
            //     })
            //     productSearchResult = {products: products}
            //     break;

        }
    }
    return productSearchResult;
}


function getAlgorithm(productCollectionData: ProductCollectionData): Searchalgorithm | undefined {
    return (productCollectionData?.searchalgorithm?.length === 1) ? productCollectionData.searchalgorithm[0] : undefined
}


export function ProductCollection({component, page}: BrProps<ContainerItem>): JSX.Element | null {

    const productCollectionProperties = component.getParameters<ProductCollectionProperties>()

    const {document} = productCollectionProperties;

    if (!document && page.isPreview()) {

        return (
            <div className={"jumbotron"}>
                <h2 className={"position-relative"}>
                    {/*// @ts-ignore*/}
                    <BrManageContentButton relative={false} parameter={"document"} path={"products"}
                                           pickerSelectableNodeTypes={"myproject:productscollection"}
                                           documentTemplateQuery={"new-productscollection-document"}/>
                    Create create new product collection or choose existing:
                </h2>
            </div>
        )
    }

    const productCollection = page.getContent<Content>(document);

    const productCollectionData = productCollection?.getData<ProductCollectionData>();

    if (!productCollectionData) {
        return <div className="container alert alert-danger" role="alert">Error no data element found</div>;
    }

    const {fullwidth, columns, style} = productCollectionData;

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

    const {queryResult, products, errorMessage} = getSearchAlgorithm(productCollectionData);

    if (errorMessage) {
        return (
            <div className="container position-relative">
                <div className="alert alert-danger position-relative">
                    <BrManageContentButton content={productCollection}/>
                    error with the product search algorithm: {errorMessage}
                    <pre>{JSON.stringify(productCollectionData, null, 2)}</pre>
                </div>

            </div>)
    }

    return (
        <div className={`${containerClassName} my-4 position-relative`}>
            <pre>{JSON.stringify(queryResult?.error, null, 2)}</pre>
            {/*  // @ts-ignore*/}
            <BrManageContentButton content={productCollection}/>
            <div className="row">
                {style === 'carousel' ?
                    <OwlCarousel adClass={`owl-simple ${items === 1 ? 'owl-nav-inside' : ''}`} options={sliderSetting}>
                        {productCollectionData?.bannerentity && productCollectionData.bannerentity.map((product: any) => {
                            return (<div>{JSON.stringify(product, null, 2)}</div>)
                        })}
                    </OwlCarousel>
                    :
                    productCollectionData?.bannerentity && productCollectionData.bannerentity.map((product: any) => {
                        return (
                            <div className={columnClassName}>
                                {JSON.stringify(productCollectionData, null, 2)}
                            </div>)
                    })}
            </div>
        </div>
    )
}
