import {BrPageContext} from "@bloomreach/react-sdk";
import React, {useEffect} from "react";
import {DefaultLayout} from "../layouts/default-layout";
import {Page} from "@bloomreach/spa-sdk";
import {ApolloConsumer} from "@apollo/react-hooks";

type Props = {
    layouts: Record<string, React.ComponentType>
    fallBack?: React.ComponentType
}

export function BrLayout({layouts, fallBack = DefaultLayout}: Props): JSX.Element | null {

    return (
        <BrPageContext.Consumer>
            {page => {
                const type = page?.getComponent().getName();
                const layout = (type && layouts[type] !== undefined) ? layouts[type] : fallBack;
                return React.createElement(layout);
            }}
        </BrPageContext.Consumer>
    );
}