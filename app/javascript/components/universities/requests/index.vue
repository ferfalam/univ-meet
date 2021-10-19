<template>
    <div id="app">
        <NavigationUniversity :user="user" />
        <div class="container my-3">
            <h1>Les demandes</h1>
            <div class="toast toast-danger text-light" :class="toast.color">
                <div class="toast-header">
                    {{toast.header}}
                </div>
                <div class="toast-body">
                    {{toast.body}}
                </div>
            </div>
            <RequestCard v-for="(request, index) in requests_init" :key="request.id" :request="request" v-on:approve="approve(index, $event)" v-on:rejet="rejet(index, $event)" v-on:delete_request="deleterequest(index, $event)"/>
        </div>
        <Footer />
    </div>
</template>

<script>
import axios from 'axios'
import NavigationUniversity from '../../partials/navigationuniversity.vue'
import Footer from '../../partials/footer.vue'
import RequestCard from './requestcard.vue'
export default {
    props: {
        requests: Array,
        user: Object
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    methods:{
        approve: function (index, request) {
            let _this=this
            axios.post('/universities/requests/approve/'+request.id)
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.requests_init = response.data.requests
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        },
        rejet: function (index, request) {
            let _this=this
            axios.post('/universities/requests/rejet/'+request.id)
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.requests_init = response.data.requests
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        },
        deleterequest: function (index, request) {
            let _this=this
            axios.delete('/universities/requests/'+request.id)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.requests_init.splice(index, 1)
                    }
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        }
    },

    components: {
        NavigationUniversity,
        Footer,
        RequestCard
    },

    data() {
        return {
            requests_init: this.requests,
            errors: {
                title: null,
                acronym: null,
            },
            request_data: {
                title: '',
                description: ''
            },
            toast: {
                header: '',
                body: '',
                color: ''
            }
        }
    },
}
</script>

 <style scoped>
.toast{
    position: fixed;
    right: 5px;
    top: 5px;
    z-index: 1;
}
</style>