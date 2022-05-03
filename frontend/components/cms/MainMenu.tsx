import React, {useEffect} from 'react';
import {isMenu, Menu as BrMenu, MenuItem, TYPE_LINK_EXTERNAL} from '@bloomreach/spa-sdk';
import {BrComponentContext, BrManageMenuButton, BrPageContext} from '@bloomreach/react-sdk';
import {MenuModels} from "./declarations";

interface MenuLinkProps {
    item: MenuItem;
}

function MenuLink({item}: MenuLinkProps): JSX.Element {
    const url = item.getUrl();

    if (!url) {
        return <a href={'#'} className="sf-with-ul disabled">{item.getName()}</a>;
    }

    if (item.getLink()?.type === TYPE_LINK_EXTERNAL) {
        return (
            <a className="sf-with-ul" href={url}>
                {item.getName()}
            </a>
        );
    }

    return (
        <a href={url}>
            <a className="sf-with-ul">{item.getName()}</a>
        </a>
    );
}

export function MainMenu(): JSX.Element | null {
    const component = React.useContext(BrComponentContext);
    const page = React.useContext(BrPageContext);
    const menuRef = component?.getModels<MenuModels>()?.menu;
    const menu = menuRef && page?.getContent<BrMenu>(menuRef);

    useEffect(() => {
        // @ts-ignore
        if (page.model.store?.visitor_id) {
            // @ts-ignore
            window.exponea.identify(page.model.store?.visitor_id)
        }
    }, [page])

    if (!isMenu(menu)) {
        return null;
    }

    return (

        <nav className="main-nav">
            <ul className={`menu ${page!.isPreview() ? 'has-edit-button' : ''}`}>
                <BrManageMenuButton menu={menu}/>
                {menu.getItems().map((item, index) => (
                    <li key={index} className={`${item.isExpanded() ? 'active' : ''}`}>
                        <MenuLink item={item}/>
                        {item.getChildren().length > 0 && (
                            <ul>
                                {item.getChildren().map((childItem, index) => {
                                    return (
                                        <li key={`childItem_${childItem.getName()}_${index}`}
                                            className={childItem.isExpanded() ? 'active' : ''}>
                                            <MenuLink item={childItem}/>
                                        </li>)
                                })}
                            </ul>)
                        }
                    </li>
                ))}
            </ul>
        </nav>
    );
}
