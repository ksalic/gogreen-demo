import React, {ChangeEvent, ChangeEventHandler, FormEvent, useEffect, useState} from "react";
import {Product} from "../../../types/product";
import ALink from "../../../features/alink";
import {slugify} from "../../../cms/utils/utils";
import {BrPageContext} from "@bloomreach/react-sdk";
import {LazyLoadImage} from "react-lazy-load-image-component";
import {safeContent} from "../../../../utils";
import {findItemsByKeyword, findSuggestions, ProductQueryResult} from "../../../../server/discoveryFunctions";

export function HeaderSearch(): JSX.Element | null {

    const page = React.useContext(BrPageContext);
    const [searchTerm, setSearchTerm] = useState<string>("");
    const [terms, setTerms] = useState<Array<string>>([]);
    const [products, setProducts] = useState<Array<Product>>([]);
    const result: ProductQueryResult = findSuggestions(searchTerm)

    if (!page) {
        return null;
    }

    useEffect(() => {
        // @ts-ignore
        document.querySelector("body").addEventListener('click', closeSearchForm);

        return () => {
            // @ts-ignore
            document.querySelector("body").removeEventListener('click', closeSearchForm);
        }
    }, []);

    useEffect(() => {
        if (result && searchTerm.length > 2) {
            setProducts(result.products);
            result.terms && setTerms(result.terms)
            console.log(terms)
        }
    }, [result, searchTerm])

    function closeSearchForm(e: any) {
        if (!e.target.closest('.header-search')) {
            // @ts-ignore
            document
                .querySelector('.header .search-toggle')
                .classList.remove('active');
            // @ts-ignore
            document
                .querySelector('.header .header-search-wrapper')
                .classList.remove('show');
        }
    }

    //@ts-ignore
    function onSearchToggle(e) {
        e.stopPropagation();
        //@ts-ignore
        document
            .querySelector('.header .search-toggle')
            .classList.toggle('active');
        //@ts-ignore
        document
            .querySelector('.header .header-search-wrapper')
            .classList.toggle('show');
    }

    function onSubmitSearchForm(e: FormEvent<HTMLFormElement>) {
        e.preventDefault();

    }


    function showSearchForm(e: any) {
        e.stopPropagation();
        // @ts-ignore
        document
            .querySelector('.header .header-search')
            .classList.add('show');
    }

    function onSearchChange(e: ChangeEvent<HTMLInputElement>) {
        setSearchTerm(e.target.value);
    }

    function goProductPage() {
        setSearchTerm('');
        setProducts([]);
        setTerms([]);
    }


    function matchEmphasize(name: string) {
        let regExp = new RegExp(searchTerm, "i");
        return name.replace(
            regExp,
            (match) => "<strong>" + match + "</strong>"
        );
    }


    return (
        <div className="header-search">
            <button className="search-toggle" onClick={onSearchToggle}><i className="icon-search"></i></button>

            <form action="#" method="get" onSubmit={onSubmitSearchForm} onClick={showSearchForm}>
                <div className="header-search-wrapper">
                    <label htmlFor="q" className="sr-only">Search</label>
                    <input type="text" onChange={onSearchChange} value={searchTerm} className="form-control" name="q"
                           placeholder="Search product ..." required/>
                    <div className="live-search-list" >
                        {
                            (products && products.length > 0 && searchTerm.length > 2) ?
                                <div className="autocomplete-suggestions">
                                    <>
                                        {terms.slice(0, 3).map(value => {
                                            return (<span className="autocomplete-suggestion" onClick={event => {
                                                setSearchTerm(value)
                                            }}>
                                                <div className="search-name"
                                                    // @ts-ignore
                                                     dangerouslySetInnerHTML={safeContent(matchEmphasize(value))}></div>
                                            </span>)
                                        })}
                                        {
                                            searchTerm.length > 2 && products.map((product, index) => (
                                                <ALink onClick={goProductPage}
                                                    href={page.getUrl(`/p/${product.slug ? product.slug : slugify(product.displayName) + '/' + product.itemId.id}`)}
                                                    className="autocomplete-suggestion" key={`search-result-${index}`}>
                                                    <LazyLoadImage
                                                        src={product.imageSet.original.link.href}
                                                        width={40} height={40} alt="product"/>
                                                    <div className="search-name"
                                                        // @ts-ignore
                                                         dangerouslySetInnerHTML={safeContent(matchEmphasize(product.displayName))}></div>
                                                    <span className="search-price">
                                                                <div
                                                                    className="product-price mb-0"> ${product.listPrice.moneyAmounts[0].amount.toFixed(2)}</div>

                                                </span>
                                                </ALink>
                                            ))
                                        }
                                    </>
                                </div>
                                : ""
                        }
                    </div>
                </div>
            </form>
        </div>
    )
}