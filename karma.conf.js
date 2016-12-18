let webpackconfig = require('./webpack.config.js')

delete webpackconfig.entry
delete webpackconfig.output

module.exports = function(config) {
    config.set({
        frameworks: ['mocha', 'chai'],
        plugins: [
            'karma-mocha',
            'karma-mocha-reporter',
            'karma-chai',
            'karma-phantomjs-launcher',
            'karma-webpack'
        ],
        files: [
            'test/**/*.js'
        ],
        preprocessors: {
            'test/**/*.js': ['webpack']
        },
        webpack: webpackconfig,
        webpackMiddleware: {
          noInfo: true
        },
        browsers: ['PhantomJS'],
        reporters: ['mocha']
    })
}
