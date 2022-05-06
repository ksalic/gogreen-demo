import {QueryResult, useQuery} from "@apollo/react-hooks";
import {
    FIND_CATEGORIES,
    FIND_CATEGORY_BY_ID, FIND_SUGGESTIONS_QUERY,
    findItemsByCategoryQuery,
    findItemsByKeywordQuery,
    findItemsJustForMeQuery,
    findItemsMoreLikeThisQuery
} from "./gqlqueries";
import {Product} from "../components/types/product";


export interface FacetValue {
    id: string;
    parentId: string;
    name: string;
    count: number;
}

export interface FacetField {
    id: string;
    name: string;
    values: FacetValue[];
}

export interface FacetResult {
    fields: FacetField[];
}

export interface FacetFieldFilterInput {
    id: string
    values: [string]
}

interface ParamInput {
    name: string
    values: [string]
}

export interface QueryHintInput {
    brUid2?: string
    accountId?: string
    domainKey?: string
    authKey?: string
    viewId?: string
    catalogViews?: string
    facetFieldFilters?: FacetFieldFilterInput[]
    cursor?: string
    params?: [ParamInput]
    customAttrFields?: [string]
    customVariantAttrFields?: [string]
    widgetType?: string
    widgetId?: string
    customVariantListPriceField?: string
    customVariantPurchasePriceField?: string
    storeKey?: string
}

export interface Category {
    id: string;
    parentId: string;
    displayName: string;
    path: string | null;
    key: string | null;
    slug: string | null;
}

export interface TreeCategory extends Category {
    children: Array<TreeCategory>
}


export interface ProductQueryResult {
    queryResult?: QueryResult
    products: Array<Product>
    facetResult?: FacetResult
    terms?: Array<string>
    total?: number
    errorMessage?: string
}

export interface CategoryQueryResult {
    queryResult?: QueryResult
    categoryTree: Array<TreeCategory>
    categories: Array<Category>
}

export function convertQueryToQueryHint(query: { [p: string]: string | string[] | undefined }): QueryHintInput {
    const tempQuery = {...query};
    delete tempQuery.page;
    delete tempQuery.layout;
    delete tempQuery.token;
    delete tempQuery.endpoint;
    delete tempQuery['server-id'];
    const facetFieldFilters: FacetFieldFilterInput[] = Object.entries(tempQuery).map(entry => {
        const key: string = entry[0]
        const value: string[] = entry[1] ? (entry[1] as string).split(',') : []
        return {id: key, values: value} as FacetFieldFilterInput
    })
    return {facetFieldFilters: facetFieldFilters};
}

export function createDataTree(dataset: Array<Category>): Array<TreeCategory> {
    if (dataset !== undefined) {
        const hashTable = Object.create(null);
        dataset.forEach(aData => hashTable[aData.id] = {...aData, children: []});
        const dataTree: Array<TreeCategory> = [];
        dataset.forEach(aData => {
            if (aData.parentId) hashTable[aData.parentId].children.push(hashTable[aData.id])
            else dataTree.push(hashTable[aData.id])
        });
        return dataTree;
    }
    return []

}

export function findCategories(queryHint?: QueryHintInput): CategoryQueryResult {
    const result = useQuery(FIND_CATEGORIES, {
        variables: {
            "queryHint": queryHint,
        }
    });
    const categories = result?.data?.findCategories;
    return {queryResult: result, categories, categoryTree: createDataTree(categories)};
}

export function findCategoryByID(cid: string = "", queryHint?: QueryHintInput): CategoryQueryResult {
    const result = useQuery(FIND_CATEGORY_BY_ID, {
        variables: {
            "id": cid,
            "queryHint": queryHint,
        }
    });
    const categories = result?.data?.findCategories
    return {queryResult: result, categories, categoryTree: createDataTree(categories)};
}

export function findItemsByKeyword(query: string = "", offset: number = 0, limit: number = 10, queryHint?: QueryHintInput, sortField?: string): ProductQueryResult {
    const result = useQuery(findItemsByKeywordQuery, {
        variables: {
            "query": query,
            "offset": offset,
            "limit": limit,
            "queryHint": queryHint,
            "sortField": sortField
        }
    });
    return {queryResult: result, products: result?.data?.findItemsByKeyword?.items, errorMessage: result.error?.message}
}

export function findSuggestions(query: string = "", queryHint?: QueryHintInput): ProductQueryResult {
    const result = useQuery(FIND_SUGGESTIONS_QUERY, {
        variables: {
            "query": query,
            "queryHint": queryHint,
        }
    });
    return {
        queryResult: result,
        terms: result?.data?.findSuggestions?.terms,
        products: result?.data?.findSuggestions?.items
    }
}

export function findItemsJustForMe(offset: number = 0, limit: number = 10, queryHint?: QueryHintInput, sortField?: string): ProductQueryResult {
    const result = useQuery(findItemsJustForMeQuery, {
        variables: {
            "offset": offset,
            "limit": limit,
            "queryHint": queryHint,
            "sortField": sortField
        }
    });
    return {queryResult: result, products: result?.data?.findItemsJustForMe?.items}
}

export function findItemsByCategory(categoryId: string = "", offset: number = 0, limit: number = 10, includeFacets: boolean = false, queryHint?: QueryHintInput, sortField?: string): ProductQueryResult {
    const result = useQuery(findItemsByCategoryQuery, {
        variables: {
            "query": categoryId,
            "offset": offset,
            "limit": limit,
            "queryHint": queryHint,
            "sortField": sortField
        }
    });
    return {
        queryResult: result,
        products: result?.data?.findItemsByCategory?.items,
        total: result?.data?.findItemsByCategory?.total,
        facetResult: result?.data?.findItemsByCategory?.facetResult,
        errorMessage: result.error?.message
    }
}

export function findItemsMoreLikeThis(query: string, offset: number = 0, limit: number = 10, queryHint?: QueryHintInput, sortField?: string): ProductQueryResult {
    const result = useQuery(findItemsMoreLikeThisQuery, {
        variables: {
            "query": query,
            "offset": offset,
            "limit": limit,
            "queryHint": queryHint,
            "sortField": sortField
        }
    });
    return {queryResult: result, products: result?.data?.findMoreLikeThisItems?.items}
}

export function findItemsByProductIDs(productIDs: string[], offset: number = 0, limit: number = 10, queryHint?: QueryHintInput, sortField?: string): ProductQueryResult {
    const result = useQuery(findItemsByKeywordQuery, {
        variables: {
            "query": '',
            "offset": offset,
            "limit": limit,
            "queryHint": {...queryHint, facetFieldFilters: [{id: "pid", values: productIDs}]},
            "sortField": sortField
        }
    });
    return {queryResult: result, products: result?.data?.findItemsByKeyword?.items}
}
