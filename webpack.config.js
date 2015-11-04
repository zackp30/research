var webpack = require("webpack");
var path = require("path");
module.exports = {
    entry: "./source/javascripts/main.es6.js",
    output: {
        path: __dirname,
        filename: "build/javascripts/bundle.js"
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style!css" },
            { test: /\.es6\.jsx?$/, loader: "babel" },
            { test: /jquery\/src\/selector\.js$/, loader: "amd-define-factory-patcher-loader" }
        ]
    },
    resolve: {
        root: [path.join(__dirname, "bower_components")]
    },
    plugins: [
        new webpack.ResolverPlugin(new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])),

        new webpack.ProvidePlugin({
            $: "jquery/src/jquery.js",
            jQuery: "jquery/src/jquery.js",
            "window.jQuery": "jquery/src/jquery.js",
            "root.jQuery": "jquery/src/jquery.js"
        })
    ]
};
