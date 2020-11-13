const path = require('path');

module.exports = {
    entry: './src/static/index.js',
    output: {
        path: path.resolve(__dirname, 'dist'),
        publicPath: '/assets/',
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.elm$/,
                exclude:[/elm-stuff/, /node_modules/],
                use: {
                    loader: 'elm-webpack-loader',
                    options: {
                        verbose: true
                    }
                }
            }
        ]
    },
    resolve: {
        extensions: ['.js', '.elm']
    },
    devServer: {
        contentBase: path.join(__dirname, 'dist'),
        compress: true,
        port: 9000
      }
    
}