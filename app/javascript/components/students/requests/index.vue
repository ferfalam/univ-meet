<template>
    <div id="app">
        <NavigationStudent :user="user" />
        <div class="container my-3 content">
            <div class="card my-4">
                <div class="card-body">
                    <h5 class="card-title">Nouvelle Demande</h5>
                    <div class="card-text">
                        <form action="">
                            <div class="form-group">
                                <input type="text" class="form-control" v-model="request_data.title" placeholder="Titre de la demande">
                                <ul v-if="errors.name" class="text-danger">
                                    <li v-for="error in errors.name" :key="error">
                                        <small>{{error}}</small>
                                    </li>
                                </ul>
                            </div>
                            <div class="form-group">
                                <textarea v-model="request_data.description" placeholder="Description de la demande" class="form-control" ></textarea>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    <button v-on:click="createrequest" class="btn btn-info">Faire la demande</button>
                </div>
            </div>

            <h1>Les demandes</h1>
            <div class="toast toast-danger text-light" :class="toast.color">
                <div class="toast-header">
                    {{toast.header}}
                </div>
                <div class="toast-body">
                    {{toast.body}}
                </div>
            </div>
            <RequestCard v-for="(request, index) in requests_init" :key="request.id" :request="request" v-on:delete_request="deleterequest(index, $event)"/>
        </div>
        <Footer />
    </div>
</template>

<script>
import axios from 'axios'
import NavigationStudent from '../../partials/navigationstudent.vue'
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
        createrequest: function (e) {
            e.preventDefault();
            let _this=this
            axios.post('/students/requests', this.request_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.errors = {
                                title: null,
                                description: null,
                            }
                    _this.toast = response.data.toast
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                    _this.requests_init = response.data.requests
                    _this.request_data = {
                                title: '',
                                description: '',
                            }
                }else{
                    _this.errors = response.data.errors
                }
            })
        },
        deleterequest: function (index, request) {
            let _this=this
            axios.delete('/students/requests/'+request.id, this.request_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.requests.splice(index, 1)
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
        NavigationStudent,
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
 .content{
     margin-top: 100px !important; 
 }
.toast{
    position: fixed;
    right: 5px;
    top: 5px;
    z-index: 1;
}
</style>