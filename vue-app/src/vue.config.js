module.exports = {
  publicPath: '/vue-app',
  devServer: {
    proxy: {
      '/vue-app/api': {
        target: 'http://host.docker.internal:5000',
        pathRewrite: {
          '/vue-app/api': '/api'
        }
      },
    },
  },
  productionSourceMap: true,
};
