import React from 'react';
import {BrComponent} from '@bloomreach/react-sdk';
import {BaseLayout} from "./base";
import {ContentComponent} from "../cms/ContentComponent";

export function ContentLayout(): JSX.Element | null {

    return (
        <BaseLayout>
            <div className={`main`}>
                <BrComponent path={'main'}>
                    <ContentComponent/>
                </BrComponent>
                <div>
                    <BrComponent path={'container'}/>
                </div>
            </div>
        </BaseLayout>
    );
}
