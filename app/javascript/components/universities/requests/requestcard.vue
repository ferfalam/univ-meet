<template>
    <div>
        <div class="card my-4">
            <div class="card-body">
                <h5 class="card-title">{{request.title}}</h5>
                <div class="card-text">
                    {{request.description}}
                </div>
            </div>

            <div class="card-footer text-muted">
                <div style="float: left" v-if="!request.approve && !request.rejet">
                    <button  v-on:click="$emit('approve', request)" class="btn btn-success">Approuvée</button>
                    <button  v-on:click="$emit('rejet', request)" class="btn btn-danger">Rejetée</button>
                </div>
                <div style="float: left" v-else>
                    <p  class="text-success" style="float: left" v-if="request.approve">Vous aviez approuvé cette demande</p>
                    <p  class="text-danger" v-else-if="request.rejet">Vous aviez rejeté cette demande</p>
                </div>
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