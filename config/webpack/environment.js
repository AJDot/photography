const { environment } = require('@rails/webpacker');

const vue =  require('./loaders/vue');

const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery'
}));

const config = environment.toWebpackConfig();

config.resolve.alias = {
    jquery: "jquery/src/jquery"
};

environment.loaders.append('vue', vue);
module.exports = environment;
