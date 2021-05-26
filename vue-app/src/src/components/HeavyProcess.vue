<template>
    <div>
        <input v-model="milliSeconds" placeholder="milliSeconds"/> <br/>
        <button @click="run('Cpu')">Run CPU-Heavy Process</button><br/>
        <button @click="run('Sql')">Run SQL Process</button>
        <div>
            {{ result }}
        </div>
    </div>
</template>
<script>
import axios from 'axios'

export default {
    data() {
        return {
            milliSeconds: 1000,
            result: ""
        }
    },
    methods: {
        run(type) {
            axios.get(`/vue-app/api/HeavyProcess/WorkHard${type}?milliSeconds=${this.milliSeconds}`)
            .then(r => {
                this.result = r.data
            })
        }
    }
}
</script>