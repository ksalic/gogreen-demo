import {AppProps} from 'next/app';
import '../public/scss/plugins/owl-carousel/owl.carousel.scss';
import "../public/scss/style.scss";
import './app.css';
import Head from 'next/head';

export default function App({Component, pageProps}: AppProps): JSX.Element {

    return (
        <>
            <Head>
                <meta charSet="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <link rel="shortcut icon" type="image/png" href="/favicon.png" sizes="64x64"/>

                <link rel="preload" href="/css/fonts/barlow/barlow-v5-latin-ext_latin-regular.woff2" as="font"
                      type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload" href="/css/fonts/barlow/barlow-v5-latin-ext_latin-italic.woff2" as="font"
                      type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload" href="/css/fonts/barlow/barlow-v5-latin-ext_latin-500.woff2" as="font"
                      type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload" href="/css/fonts/barlow/barlow-v5-latin-ext_latin-500italic.woff2"
                      as="font" type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload" href="/css/fonts/barlow/barlow-v5-latin-ext_latin-600.woff2"
                      as="font" type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload"
                      href="../assets/fonts/barlow/barlow-v5-latin-ext_latin-600italic.woff2"
                      as="font" type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload"
                      href="../assets/fonts/barlow/barlow-v5-latin-ext_latin-700.woff2"
                      as="font" type="font/woff2" crossOrigin="anonymous"/>
                <link rel="preload"
                      href="../assets/fonts/barlow/barlow-v5-latin-ext_latin-700italic.woff2"
                      as="font" type="font/woff2" crossOrigin="anonymous"/>
                <link rel="stylesheet"
                      href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700%7CPoppins:300,400,500,600,700"/>
                <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"/>
                <link rel="stylesheet" type="text/css" href="/css/fonts-molla.min.css"/>
                <link rel="stylesheet" type="text/css" href="/vendor/line-awesome/css/line-awesome.min.css"/>
                <script src="/js/exponea.js"></script>
            </Head>
            <Component {...pageProps} />
            <script src="/js/jquery.min.js"></script>
        </>
    );
}
