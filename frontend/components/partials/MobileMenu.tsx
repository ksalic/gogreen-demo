import {useRouter} from 'next/router';
import React, {useContext, useEffect, useState} from 'react';
import {Tab, TabList, TabPanel, Tabs} from 'react-tabs';
// @ts-ignore
import SlideToggle from 'react-slide-toggle';

import ALink from '../features/alink';
import {BrComponentContext, BrPageContext} from "@bloomreach/react-sdk";
import {MenuModels} from "../cms/declarations";
import {isMenu, Menu as BrMenu, MenuItem, TYPE_LINK_EXTERNAL} from "@bloomreach/spa-sdk";
import Link from "next/link";
import {findCategories} from "../../server/discoveryFunctions";
import {slugify} from "../cms/utils/utils";
import {BrPropertyContext} from "../provider/BrPropertyProvider";

export function MobileMenu() {

    const component = React.useContext(BrComponentContext);
    const page = React.useContext(BrPageContext);
    const menuRef = component?.getModels<MenuModels>()?.menu;
    const menu = menuRef && page?.getContent<BrMenu>(menuRef);

    const {gqlUrl} = useContext(BrPropertyContext);


    const categoryQueryResult = gqlUrl ? findCategories() : {categoryTree: [], categories:[], queryResult: {loading: false}};

    if (!isMenu(menu)) {
        return null;
    }

    const router = useRouter();
    const [searchTerm, setSearchTerm] = useState("");

    useEffect(() => {
        router.events.on('routeChangeComplete', hideMobileMenu);
    }, [])

    function hideMobileMenu() {
        (document.querySelector('body') as HTMLElement).classList.remove('mmenu-active');
    }

    function onSearchChange(e: React.ChangeEvent<HTMLInputElement>) {
        setSearchTerm(e.target.value);
    }

    function onSubmitSearchForm(e: React.FormEvent<HTMLFormElement>) {
        e.preventDefault();
    }

    function MenuLink({item, onToggle}: MenuLinkProps): JSX.Element {
        const url = item.getUrl();
        const hasSubItems = item.getChildren().length > 0 ?? false

        if (!url) {
            return <a href={'#'} onClick={(e) => {
                onToggle(e);
                e.preventDefault()
            }}>{item.getName()}
                {hasSubItems && <span className="mmenu-btn"></span>}
            </a>;
        }

        if (item.getLink()?.type === TYPE_LINK_EXTERNAL) {
            return (
                <a href={url}>
                    <>
                        {item.getName()}
                        {hasSubItems && <span className="mmenu-btn" onClick={(e) => {
                            onToggle(e);
                            e.preventDefault()
                        }}></span>}
                    </>
                </a>
            );
        }

        return (
            <Link href={url}>
                <a>{item.getName()}{hasSubItems && <span className="mmenu-btn" onClick={(e) => {
                    onToggle(e);
                    e.preventDefault()
                }}></span>}</a>
            </Link>
        );
    }

    const {binariesUrl} = useContext(BrPropertyContext);


    return (
        <div className="mobile-menu-container mobile-menu-light">
            <div className="mobile-menu-wrapper">
                <span className="mobile-menu-close" onClick={hideMobileMenu}><i className="icon-close"></i></span>
                <BrPageContext.Consumer>
                    {page => {
                        return (
                            <ALink href={page?.getUrl("/")} className="logo" style={{margin: '0 auto'}}>
                                <img
                                    src={`${binariesUrl}${page?.getChannelParameters()?.logo}`}
                                    style={{margin: '0 auto'}} alt="Bloomreach Storefront"
                                    className="bg-transparent"
                                    width="130"
                                    height="30"/>
                            </ALink>
                        )
                    }}
                </BrPageContext.Consumer>
                <form action="#" method="get" onSubmit={event => onSubmitSearchForm(event)} className="mobile-search">
                    <label htmlFor="mobile-search" className="sr-only">Search</label>
                    <input type="text" className="form-control" value={searchTerm}
                           onChange={event => onSearchChange(event)}
                           name="mobile-search" id="mobile-search" placeholder="Search product ..." required/>
                    <button className="btn btn-primary" type="submit"><i className="icon-search"></i></button>
                </form>
                <Tabs defaultIndex={0} selectedTabClassName="show">
                    <TabList className="nav nav-pills-mobile" role="tablist">
                        <Tab className="nav-item text-center">
                            <span className="nav-link">Menu</span>
                        </Tab>

                        <Tab className="nav-item text-center">
                            <span className="nav-link">Categories</span>
                        </Tab>
                    </TabList>
                    <div className="tab-content">
                        <TabPanel>
                            <nav className="mobile-nav">
                                <ul className={`mobile-menu ${page!.isPreview() ? 'has-edit-button' : ''}`}>
                                    {menu.getItems().map((item, index) => (
                                        <SlideToggle key={index} collapsed={true}>
                                            {({onToggle, setCollapsibleElement, toggleState}: any) => (
                                                <li key={index}
                                                    className={toggleState.toLowerCase() == 'expanded' ? 'open' : ''}>
                                                    <MenuLink item={item} onToggle={onToggle}/>
                                                    <ul ref={setCollapsibleElement}>
                                                        {item.getChildren().map((subItem, index) => {
                                                            return (
                                                                <li key={index}>
                                                                    <ALink
                                                                        href={page?.getUrl(subItem.getLink())}>{subItem.getName()}</ALink>
                                                                </li>)
                                                        })}
                                                    </ul>
                                                </li>
                                            )}
                                        </SlideToggle>
                                    ))}
                                </ul>
                            </nav>
                        </TabPanel>
                        <TabPanel>
                            <nav className="mobile-cats-nav">
                                <ul className="mobile-cats-menu">
                                    {categoryQueryResult && categoryQueryResult.categoryTree.map(category => {
                                        const href: string = page?.getUrl(`/c/${slugify(category.displayName)}/${category.id}`) ?? '#';
                                        return (
                                            <React.Fragment key={category.id}>
                                                <li key={category.id} className="item-cats-lead"><ALink
                                                    href={href}>{category.displayName}</ALink>
                                                </li>
                                                {category.children.map(subCategory => {
                                                    const href: string = page?.getUrl(`/c/${slugify(subCategory.displayName)}/${subCategory.id}`) ?? '#';
                                                    return (
                                                        <li key={subCategory.id}><ALink
                                                            href={href}>&nbsp;&nbsp;{subCategory.displayName}</ALink>
                                                        </li>);
                                                })}
                                            </React.Fragment>);
                                    })}
                                </ul>
                            </nav>
                        </TabPanel>
                    </div>
                </Tabs>
            </div>
        </div>
    )
}

interface MenuLinkProps {
    item: MenuItem;
    onToggle: (e: React.MouseEvent<HTMLSpanElement>) => void;
}
