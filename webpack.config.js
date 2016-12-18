const webpack = require('webpack')
const path = require('path')

module.exports = {
    entry: './app/main.js',
    output: {
        path: '/public',
        publicPath: '/public/',
        filename: 'bundle.js'
    },
    devtool: 'eval-source-map',
    plugins: [
        new webpack.optimize.OccurenceOrderPlugin(),
        new webpack.ProvidePlugin({ riot: 'riot' })
    ],

    module: {
        preLoaders: [
            {test: /\.tag$/, exclude: /node_modules/, loader: path.resolve(__dirname, 'riotjs-loader')},
        ],
        loaders: [
            { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=10000&minetype=application/font-woff" },
            { test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" },
            {test: /\.css$/, loader: 'style!css'},
            {test: /\.scss$/, loader: 'style!css!autoprefixer!sass'},
            {
                test: /\.js|\.tag$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {
                    presets: ['es2015'],
                    plugins: [
                        ['babel-root-import', {rootPathSuffix: 'app'}]
                    ]
                }
            }
        ]
    }
}
