import * as React from "react";

export interface BrPropertyProps {
    [x: string]: any
}

export const BrPropertyContext = React.createContext<BrPropertyProps>({});