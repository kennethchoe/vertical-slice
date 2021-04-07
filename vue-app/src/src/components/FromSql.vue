<template>
    <div>
        <button @click="refresh">Refresh From Sql</button>
        <li v-for="rec in recs" :key="rec.Id">
            {{ rec.id }}: {{ rec.createdDateUtc }}
        </li>
    </div>
</template>
<script>
import axios from 'axios'

export default {
    data() {
        return {
            recs: []
        }
    },
    methods: {
        refresh() {
            axios.get('/api/FromSql')
            .then(r => {
                this.recs = r.data
            })
        }
    }
}
</script>