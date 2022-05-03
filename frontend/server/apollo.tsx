import {InMemoryCache,} from "@apollo/client";
import {ApolloCache} from "@apollo/client/cache/core/cache";
import {NormalizedCacheObject} from "@apollo/client/cache/inmemory/types";

export const inMemoryCache: ApolloCache<NormalizedCacheObject> = new InMemoryCache();

