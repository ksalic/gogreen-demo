export interface ItemId {
    id: string;
    code: string;
}

export interface Link {
    href: string;
}

export interface Original {
    link: Link;
}

export interface ImageSet {
    original: Original;
}

export interface MoneyAmount {
    amount: number;
    currency?: any;
    displayValue: string;
}

export interface ListPrice {
    moneyAmounts: MoneyAmount[];
}

export interface Product {
    label?: string
    itemId: ItemId;
    displayName: string;
    description: string;
    imageSet: ImageSet;
    listPrice: ListPrice;
    slug?: string
    variants: any[];
}