<template>
    <div>
        <button @click="refresh">Refresh</button>
        <li v-for="dayInfo in daysInfo" :key="dayInfo.date">
            {{ dayInfo.date }}: {{ dayInfo.summary }}
        </li>
    </div>
</template>
<script>
import axios from 'axios'
import env from '../env'

export default {
    data() {
        return {
            daysInfo: []
        }
    },
    methods: {
        refresh() {
            axios.get(`${env.serviceUrl}/api/WeatherForecast`)
            .then(r => {
                this.daysInfo = r.data
            })
        }
    }
}
</script>