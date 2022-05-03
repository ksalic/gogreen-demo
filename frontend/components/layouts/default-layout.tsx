import React from 'react';
import {BrComponent} from '@bloomreach/react-sdk';
import {BaseLayout} from "./base";

export function DefaultLayout(): JSX.Element | null {

    return (
        <BaseLayout>
            <div className={`main`}>
                <h2>fallback... </h2>
                <BrComponent path={'container'}/>
            </div>
        </BaseLayout>
    );
}
