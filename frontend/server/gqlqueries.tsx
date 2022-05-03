import gql from 'graphql-tag';

export const FIND_CATEGORIES = gql`
  query Categories {
    findCategories {
      id
      parentId
      displayName
      path
      slug
      key
    }
  }
`;

export const FIND_CATEGORY_BY_ID = gql`
  query Category($id: String!) {
    findCategoryById(id: $id) {
      id
      parentId
      displayName
      path
      slug
      key
    }
  }
`;

export const itemQueryFragment = `
fragment ItemFragment on Item {
  itemId {
    id
    code
  }
  displayName
  description
  slug
  imageSet {
    original {
      link {
        href
      }
    }
  }
  listPrice {
    moneyAmounts {
      amount
      currency
      displayValue
    }
  }
}`

export const findItemsByKeywordQuery = gql`
query Items($query: String!, $offset: Int, $limit: Int, $queryHint: QueryHintInput, $sortFields: String) {
  findItemsByKeyword(text: $query, offset: $offset, limit: $limit, queryHint:$queryHint, sortFields:$sortFields) {
    offset
    limit
    count
    total
    items {
      ...ItemFragment
    }
  }
}
${itemQueryFragment}
`

export const FIND_SUGGESTIONS_QUERY = gql`
query Items($query: String!, $queryHint: QueryHintInput) {
  findSuggestions(text: $query, queryHint:$queryHint) {
    terms
    items {
      ...ItemFragment
    }
  }
}
${itemQueryFragment}
`

export const findItemsJustForMeQuery = gql`
query Items($offset: Int, $limit: Int, $queryHint: QueryHintInput, $sortFields: String) {
  findItemsJustForMe(
    offset: $offset
    limit: $limit
    queryHint: $queryHint
    sortFields: $sortFields
  ) {
    offset
    limit
    count
    items {
      ...ItemFragment
    }
  }
}
${itemQueryFragment}
`

export const findItemsMoreLikeThisQuery = gql`
query Items($query: String!, $offset: Int, $limit: Int, $queryHint: QueryHintInput, $sortFields: String) {
  findMoreLikeThisItems(
    mltPid: $query
    offset: $offset
    limit: $limit
    queryHint: $queryHint
    sortFields: $sortFields
  ) {
    offset
    limit
    count
    total
    items {
      ...ItemFragment
    }
  }
}
${itemQueryFragment}
`

export const findItemsByCategoryQuery = gql`
query Items($query: String!, $offset: Int, $limit: Int, $queryHint: QueryHintInput, $sortFields: String) {
  findItemsByCategory(categoryId: $query, offset: $offset, limit: $limit, queryHint:$queryHint, sortFields:$sortFields) {
    offset
    limit
    count
    total
    items {
      ...ItemFragment
    }
    facetResult{
      fields{
        id
        name
        values{
          id
          parentId
          name
          count
        }
      }
    }
  }
}
${itemQueryFragment}
`