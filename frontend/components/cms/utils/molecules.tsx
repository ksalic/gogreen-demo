import {BrxsfProps, getText, slugify} from "./utils";
import {brxsfBanner} from "../../types/content";
import {Cta} from "./atoms";
import React, {useContext} from "react";
import {Product} from "../../types/product";
import ALink from "../../features/alink";
import {LazyLoadImage} from "react-lazy-load-image-component";
import {BrPropertyContext} from "../../provider/BrPropertyProvider";


export function BannerContent({item, page}: BrxsfProps<brxsfBanner>): JSX.Element {
    const {subtitle, text, style, content, cta} = item;
    const styleClasses = style?.selectionValues[0].key === 'dark' ?
        {subtitle: '', title: 'text-dark', content: 'text-dark'} :
        {subtitle: 'text-primary', title: 'text-white', content: 'text-white'};

    return (
        <div className="banner-content">
            {subtitle && <h4 className={`banner-subtitle ${styleClasses.subtitle}`}>{subtitle}</h4>}
            {text &&
            <h3 dangerouslySetInnerHTML={{__html: getText(text)}} className={`banner-title ${styleClasses.title}`}/>}
            {content &&
            <div className={styleClasses.content} dangerouslySetInnerHTML={{__html: content.value}}/>
            }
            {cta?.map((ctaitem, index) => {
                return <Cta key={index} item={ctaitem} page={page}/>
            })}
        </div>
    )
}

export function ProductItem({item, page}: BrxsfProps<Product>): JSX.Element {

    const {translations} = useContext(BrPropertyContext);

    return (
        <div className="product product-4 text-center">
            <figure className="product-media">
                {item.label && <span className="product-label label-top">{item.label}</span>}
                <ALink
                    href={page.getUrl(`/p/${item.slug ? item.slug : slugify(item.displayName) + '/' + item.itemId.id}`)}>
                    <LazyLoadImage
                        // style={{height: '100%'}}
                        alt="product"
                        src={item.imageSet.original.link.href}
                        threshold={500}
                        effect={"black-and-white"}
                        wrapperClassName="product-image"
                    />
                </ALink>
                <div className="product-action">
                    <button className="btn-product btn-cart">
                        <span>{(translations && translations["add.to.cart"]) ?? 'add to cart'}</span>
                    </button>
                </div>
            </figure>
            <div className="product-body">
                <h3 className="product-title">
                    <ALink
                        href={page.getUrl(`/p/${item.slug ? item.slug : slugify(item.displayName) + '/' + item.itemId.id}`)}>
                        {item.displayName}</ALink>
                </h3>
                <div className="product-price">
                    ${item.listPrice.moneyAmounts[0].amount.toFixed(2)}
                </div>
            </div>
        </div>
    );
}