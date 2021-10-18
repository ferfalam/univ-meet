<template>
    <div>
        <div class="card my-2">
            <div class="card-body">
                <h5 class="card-title">{{request.title}}</h5>
                <div class="card-text">
                    {{request.description}}
                </div>
            </div>
            <div class="card-footer text-muted">
                <p style="float: left" class="text-success" v-if="request.approve">Votre demande est approvée</p>
                <p style="float: left" class="text-danger" v-else-if="request.rejet">Votre demande est rejetée</p>
                <p style="float: left" class="text-warning" v-else>Votre demande est en attente</p>
                <button style="float: right"  v-on:click="$emit('delete_request', request)" class="btn btn-danger">Supprimer</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        request: Object
    },

    mounted() {
        //
    },

    methods: {
        //
    },

    data() {
        return {
            //
        }
    },
}
</script>

 <style scoped>
</style>