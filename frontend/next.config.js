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
}