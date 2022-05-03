export interface ProductCollectionProperties {
    "xs": number | string;
    "sm": number | string;
    mb: 0 | 1 | 2 | 3 | 4 | 5 | 'auto'
    mt: 0 | 1 | 2 | 3 | 4 | 5 | 'auto'
    "md": number | string;
    "lg": number | string;
    "xl": number | string;
}

export interface BannerProperties {
    layout?: string
    fullWidth: boolean
}