import ALink from '../features/alink';
import {findCategories, TreeCategory} from "../../server/discoveryFunctions";
import React from "react";
import {sliceIntoChunks, slugify} from "../cms/utils/utils";
import {BrComponentContext, BrPageContext} from "@bloomreach/react-sdk";

function CategoryMenu(): JSX.Element | null {

    const component = React.useContext(BrComponentContext);
    const page = React.useContext(BrPageContext);

    const categoryQueryResult = findCategories();

    const {queryResult, categoryTree} = categoryQueryResult;
    const {loading, error} = queryResult ?? {error: undefined, loading: false};

    if (error) {
        return (
            <div className="dropdown category-dropdown">
                <div className="container alert alert-danger" role="alert">
                    {error.message}
                </div>
            </div>)
    }


    return (
        <div className="dropdown category-dropdown">
            <a href="#" className="dropdown-toggle" title="Browse Categories">
                Browse Categories
            </a>
            <div className="dropdown-menu">
                <nav className="side-nav">
                    {
                        !loading ?
                            <ul className="menu-vertical sf-arrows sf-js-enabled" style={{touchAction: 'pan-y'}}>
                                {categoryTree && categoryTree.map(treeItem => {
                                    const href: string = page?.getUrl(`/c/${slugify(treeItem.displayName)}/${treeItem.id}`) ?? '#';
                                    return (
                                        <li className="megamenu-container">
                                            <a className="sf-with-ul text-dark"
                                               href={href}>
                                                {treeItem.displayName}</a>
                                            <div className="megamenu">
                                                <div className="row ">
                                                    <div className="col-md-8">
                                                        <div className="menu-col">
                                                            <div className="row">
                                                                {(treeItem.children.length > 0 && treeItem.children.length < 3) &&
                                                                <div className="col-md-12">
                                                                    {treeItem.children.map(treeChildItem => {
                                                                        return <>
                                                                            <div className="menu-title">
                                                                                <a
                                                                                    href={page?.getUrl(`/c/${slugify(treeItem.displayName)}/${treeItem.id}`)}>{treeChildItem.displayName}</a>
                                                                            </div>
                                                                            <ul>
                                                                                {treeChildItem.children.length > 0 && treeChildItem.children.map((subItem, index) => {
                                                                                    return (
                                                                                        <li key={`subitem_${subItem.id}_${index}`}>
                                                                                            <a
                                                                                                href={page?.getUrl(`/c/${slugify(subItem.displayName)}/${subItem.id}`)}>{subItem.displayName}</a>
                                                                                        </li>
                                                                                    )
                                                                                })}
                                                                            </ul>
                                                                        </>
                                                                    })}
                                                                </div>
                                                                }
                                                                {(treeItem.children.length > 0 && treeItem.children.length > 3) && sliceIntoChunks(treeItem.children, 2).map((chunk, index) => {
                                                                    return (
                                                                        <div key={`chunk_${index}`}
                                                                             className="col-md-6">
                                                                            {chunk.map(treeChildItem => {
                                                                                return <>
                                                                                    <div className="menu-title">
                                                                                        <a href={page?.getUrl(`/c/${slugify(treeItem.displayName)}/${treeItem.id}`)}>{treeChildItem.displayName}</a>
                                                                                    </div>
                                                                                    <ul>
                                                                                        {treeChildItem.children.length > 0 && treeChildItem.children.map((subItem: TreeCategory) => {
                                                                                            return (
                                                                                                <li key={`sub_${subItem.id}`}>
                                                                                                    <a href={page?.getUrl(`/c/${slugify(subItem.displayName)}/${subItem.id}`)}>{subItem.displayName}</a>
                                                                                                </li>
                                                                                            )
                                                                                        })}
                                                                                    </ul>
                                                                                </>
                                                                            })}
                                                                        </div>)
                                                                })}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div className="col-md-4">
                                                        <div className="banner banner-overlay h-100 w-100">
                                                            <ALink href={'#'} className="banner banner-menu w-100"
                                                                   style={{background: 'no-repeat 22%/cover url(https://d-themes.com/react/molla/demo-22/images/home/menu/banner-1.jpg)'}}>todo</ALink>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    )
                                })}
                            </ul> : ''
                    }
                </nav>
            </div>
        </div>

    )
        ;
}


export default CategoryMenu;