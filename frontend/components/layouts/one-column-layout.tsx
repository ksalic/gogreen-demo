import React from 'react';
import {BrComponent} from '@bloomreach/react-sdk';
import {BaseLayout} from "./base";

export function OneColumnLayout(): JSX.Element | null {

    return (
        <BaseLayout>
            <div className={`main`}>
                <BrComponent path={'container'}/>
            </div>
        </BaseLayout>
    );
}
