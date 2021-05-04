<template>
    <div>
        <button @click="refresh">Refresh Weather</button>
        <li v-for="dayInfo in daysInfo" :key="dayInfo.date">
            {{ dayInfo.date }}: {{ dayInfo.summary }}
        </li>
    </div>
</template>
<script>
import axios from 'axios'

export default {
    data() {
        return {
            daysInfo: []
        }
    },
    methods: {
        refresh() {
            axios.get('/vue-app/api/WeatherForecast')
            .then(r => {
                this.daysInfo = r.data
            })
        }
    }
}
</script>