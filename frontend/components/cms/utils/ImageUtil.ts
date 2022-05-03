/*
 * Copyright 2022 Bloomreach (http://www.bloomreach.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * Image Utility
 */
import {ImageUrl} from '../components/global/CommonTypes';
import {ImageSet, Page} from '@bloomreach/spa-sdk';
import {isSaas} from './UrlUtils';

type ImageUrl = CmsLink & {
  type: 'internal' | 'external' | 'bynder' | 'unsplash'
};
/*
Bynder ImageJson

[{"id":"3DF5CE42-7EFA-4499-A0803E1D33424042","orientation":"square","archive":0,"type":"image","fileSize":2964364,"description":"","name":"Bedroom Storage","height":1400,"width":1400,"copyright":"","extension":["png"],"userCreated":"Demo User","datePublished":"2020-04-17T15:44:46Z","dateCreated":"2020-04-17T15:47:53Z","dateModified":"2020-07-14T18:13:41Z","watermarked":0,"limited":0,"isPublic":0,"brandId":"C1765522-8958-4A55-880A8A246ED58DE8","thumbnails":{"ForIntegrations":"https://d2csxpduxe849s.cloudfront.net/media/0BA0E5F0-0BAC-4AFF-82B70192957A43DD/3DF5CE42-7EFA-4499-A0803E1D33424042/393A385B-5D6E-411E-84BE9BFAFDD85094/ForIntegrations-balans.jpg","large":"https://d2csxpduxe849s.cloudfront.net/media/0BA0E5F0-0BAC-4AFF-82B70192957A43DD/3DF5CE42-7EFA-4499-A0803E1D33424042/393A385B-5D6E-411E-84BE9BFAFDD85094/large-balans.jpg","online":"https://d2csxpduxe849s.cloudfront.net/media/0BA0E5F0-0BAC-4AFF-82B70192957A43DD/3DF5CE42-7EFA-4499-A0803E1D33424042/393A385B-5D6E-411E-84BE9BFAFDD85094/online-balans.png","mini":"https://d2csxpduxe849s.cloudfront.net/media/0BA0E5F0-0BAC-4AFF-82B70192957A43DD/3DF5CE42-7EFA-4499-A0803E1D33424042/mini-6E4E11B8-D1DF-4814-AB2B5FA7CC91B3C5.png","webimage":"https://d2csxpduxe849s.cloudfront.net/media/0BA0E5F0-0BAC-4AFF-82B70192957A43DD/3DF5CE42-7EFA-4499-A0803E1D33424042/webimage-7352796F-FBE6-474B-BCE040A96B8FB999.png","thul":"https://d2csxpduxe849s.cloudfront.net/media/0BA0E5F0-0BAC-4AFF-82B70192957A43DD/3DF5CE42-7EFA-4499-A0803E1D33424042/thul-3411F1CA-F4DF-452E-9E3A6FEFEDDA5249.png"}}]

 */
const parseImageUrl = (url: string): ImageUrl => {
  let type: string = 'internal';
  try {
    let imageJson = JSON.parse(url);
    if (imageJson) {
      if (Array.isArray(imageJson)) {
        imageJson = imageJson[0];
      }
    }

    if (imageJson?.urls) {
      url = imageJson.urls["regular"] || imageJson.urls["full"] || imageJson.urls["raw"];
      type = "bynder";
    }

    if (imageJson?.thumbnails) {
      url = imageJson.thumbnails['webimage'] || imageJson.thumbnails['large'] || imageJson.thumbnails['online'];
      type = 'bynder';
    }
  } catch (e) {
    if (url.startsWith('/')) {
      const brBaseUrl: string = process.env.REACT_APP_BRXM_ENDPOINT!;
      url = brBaseUrl && (brBaseUrl.substring(0, brBaseUrl.indexOf('/site')) + (isSaas() ? '/resources' : '/site/binaries') + url);
    }
  }

  return {
    type,
    url
  } as ImageUrl;
};

const parseImageUrlDynamic = (page: Page, imageObject: any): ImageUrl | null => {
  const image = imageObject?.image?.[0];
  if (!image) {
    return null;
  }

  const imageType = image?.contentType?.split(':')?.[1];
  switch (imageType) {
    case 'unsplashImage':
    case 'demoUnsplashImage':
      try {
        const imageJson = JSON.parse(image?.unsplashImage);
        const imageUrl = imageJson.urls['regular'] || imageJson.urls['full'] || imageJson.urls['raw'];
        if (imageUrl) {
          return {
            type: 'unsplash',
            url: imageUrl
          } as ImageUrl;
        }
      } catch (e) {
      }
      break;
    case 'bynderImage':
    case 'demoBynderImage':
      try {
        const imageJson = JSON.parse(image?.bynderImage);
        const imageUrl = imageJson.urls['regular'] || imageJson.urls['full'] || imageJson.urls['raw'];
        if (imageUrl) {
          return {
            type: 'bynder',
            url: imageUrl
          } as ImageUrl;
        }
      } catch (e) {
      }
      break;
    case 'externalLink':
    case 'demoExternalLink':
      let externalLink = image?.externalLink;
      if (externalLink) {
        return {
          type: 'external',
          url: externalLink
        } as ImageUrl;
      }
      break;
    default:
      const imageDoc = page.getContent<ImageSet>(image);
      if (imageDoc) {
        if (imageDoc.getOriginal) {
          return {
            type: 'internal',
            url: imageDoc.getOriginal()?.getUrl()!
          } as ImageUrl;
        }
      }

      const imageContent = page.getContent(image) as any;
      if (imageContent) {
        if (imageContent.getUrl) {
          return {
            type: 'internal',
            url: imageContent.getUrl()!
          } as ImageUrl;
        }
      }

      /*
      const imageContent = page.getContent(image) as any;
      let imageUrl = imageContent?.links?.site?.href ?? (imageContent?.getOriginal ? imageContent?.getOriginal()?.getUrl() : imageContent?.getUrl());
      if (imageUrl) {
        return {
          type: 'internal',
          url: imageUrl
        } as ImageUrl;
      }

       */
      break;
  }
  return null;
};

const getBackgroundImageLink = (url: string) => {
  // TODO: workaround
  url = url?.replaceAll('starterstoreboot', 'pacific-home')
  const hasSpecialCharacters = /\(|\)/.test(url);
  return hasSpecialCharacters ? 'url("' + url! + '")' : 'url(' + url! + ')';
}

export {parseImageUrl, parseImageUrlDynamic, getBackgroundImageLink};
