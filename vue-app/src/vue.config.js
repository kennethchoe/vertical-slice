module.exports = {
  devServer: {
    proxy: {
      '/api': {
        target: 'http://host.docker.internal:5000',
      },
    },
  },
  productionSourceMap: true,
};
