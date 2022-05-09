module.exports = {
    typescript: {
        // !! WARN !!
        // Dangerously allow production builds to successfully complete even if
        // your project has type errors.
        // !! WARN !!
        ignoreBuildErrors: true,
    },
    i18n: {
        locales: ['en-nl', 'nl-nl'],
        defaultLocale: 'nl-nl',
    },
    async rewrites() {
        return [
            {
                source: '/en-nl/sitemap.xml',
                destination: 'http://sitemap.boels.bloomreach.works/site/en-nl/sitemap.xml',
                locale: false
            },
            {
                source: '/sitemap.xml',
                destination: 'http://sitemap.boels.bloomreach.works/site/sitemap.xml',
            },

        ]
    },
}