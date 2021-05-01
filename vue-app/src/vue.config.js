module.exports = {
  publicPath: '/vue-app',
  devServer: {
    proxy: {
      '/vue-app/api': {
        target: 'http://' + process.env.DOCKER_HOST_IP_ADDR + ':5000',
        pathRewrite: {
          '/vue-app/api': '/api'
        }
      },
    },
  },
  productionSourceMap: true,
};
