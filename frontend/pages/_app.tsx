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
                <link rel="stylesheet"
                      href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700%7CPoppins:300,400,500,600,700"/>
                <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"/>
                <link rel="stylesheet" type="text/css" href="/css/fonts-molla.min.css"/>
                <link rel="stylesheet" type="text/css" href="/vendor/line-awesome/css/line-awesome.min.css"/>
            </Head>
            <Component {...pageProps} />
            <script src="/js/jquery.min.js"></script>
        </>
    );
}
