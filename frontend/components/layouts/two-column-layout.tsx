import React from 'react';
import {BrComponent} from '@bloomreach/react-sdk';
import {BaseLayout} from "./base";

export function TwoColumnLayout(): JSX.Element | null {

    return (
        <BaseLayout>
            <div className={`main`}>
                <div className={'container'}>
                    <div className={"row"}>
                        <div className={"col-6"}>
                            <BrComponent path={'container/left'}/>
                        </div>
                        <div className={"col-6"}>
                            <BrComponent path={'container/right'}/>
                        </div>
                    </div>
                </div>
            </div>
        </BaseLayout>
    );
}
