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
            <RequestCard v-for="(request, index) in requests" :key="request.id" :request="request" v-on:delete_request="deleterequest(index, $event)"/>
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
        deleterequest: function (index, request) {
            let _this=this
            axios.delete('/universities/requests/'+request.id, this.request_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.requests.splice(index, 1)
                    }
                    _this.toast = response.data.toast 
                    $('.toast').toast('show');
                }else{
                    _this.toast = response.data.toast 
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

<style>
.toast{
    position: fixed;
    right: 5px;
    top: 5px;
    z-index: 1;
}
</style>