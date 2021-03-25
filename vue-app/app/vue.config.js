const port = process.env.VUE_APP_PORT || 5000;

module.exports = {
  devServer: {
    proxy: {
      '/api': {
        target: `http://192.168.1.137:${port}`,
        // target: 'https://localhost:44344',
      },
    },
    // https: true,
  },
};