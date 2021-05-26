<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <h2>Web API server name: {{ serverName }}</h2>
    <br/>
    <Weather/>
    <br/>
    <FromSql/>
    <br/>
    <HeavyProcess/>
  </div>
</template>

<script>
import axios from 'axios'
import Weather from './components/Weather.vue'
import FromSql from './components/FromSql.vue'
import HeavyProcess from './components/HeavyProcess.vue'

export default {
  name: 'App',
  components: {
    Weather,
    FromSql,
    HeavyProcess
  },
  data() {
    return {
      serverName: ""
    }
  },
  mounted() {
    axios.get('/vue-app/api/serverInfo')
    .then(r => {
        this.serverName = r.data
    })
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
