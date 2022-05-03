import React from 'react';
import Link from 'next/link';
import {isMenu, Menu as BrMenu, MenuItem, TYPE_LINK_EXTERNAL} from '@bloomreach/spa-sdk';
import {BrComponentContext, BrManageMenuButton, BrPageContext} from '@bloomreach/react-sdk';
import {MenuModels} from "./declarations";

interface MenuLinkProps {
    item: MenuItem;
}

function MenuLink({item}: MenuLinkProps): JSX.Element {
    const url = item.getUrl();

    if (!url) {
        return <a href={'#'}>{item.getName()}</a>;
    }

    if (item.getLink()?.type === TYPE_LINK_EXTERNAL) {
        return (
            <a href={url} target={"_blank"}>
                {item.getName()}
            </a>
        );
    }

    return (
        <Link href={url}>
            <a>{item.getName()}</a>
        </Link>
    );
}

export function FooterMenu(): JSX.Element | null {
    const component = React.useContext(BrComponentContext);
    const page = React.useContext(BrPageContext);
    const menuRef = component?.getModels<MenuModels>()?.menu;
    const menu = menuRef && page?.getContent<BrMenu>(menuRef);

    if (!isMenu(menu)) {
        return null;
    }

    return (
        <>
            {page!.isPreview() &&
            <div className={`has-edit-button`}><BrManageMenuButton menu={menu}/></div>}
            {menu.getItems().map((item, index) => (
                <div className={`col-sm-6 col-lg-3 ${page!.isPreview() ? 'has-edit-button' : ''}`} key={index}>
                    <BrManageMenuButton menu={menu}/>
                    <div className="widget">
                        <h4 className="widget-title">{item.getName()}</h4>
                        {item.getChildren().length > 0 && (
                            <ul className={"widget-list"}>
                                {item.getChildren().map((childItem, index) => {
                                    return (
                                        <li key={`footermenu_item_${childItem.getName()}_${index}`}>
                                            <MenuLink item={childItem}/>
                                        </li>)
                                })}
                            </ul>)
                        }
                    </div>
                </div>
            ))}
        </>
    );
}
