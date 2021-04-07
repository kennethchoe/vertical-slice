<template>
  <div id="app">
    <Weather/>
    <br/>
    <FromSql/>
  </div>
</template>

<script>
import Weather from './components/Weather.vue'
import FromSql from './components/FromSql.vue'

export default {
  name: 'App',
  components: {
    Weather,
    FromSql
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
