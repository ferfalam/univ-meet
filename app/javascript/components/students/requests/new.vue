<template>
    <div id="app">
        <div class="mw-100 vh-100 brand-student">
            <NavigationStudent :user="user" />
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6"></div>
                    <div class="col col-md-12 col-lg-6 bg-light vh-100 d-flex align-items-center justify-content-center">
                        <div>
                            <h2 class="my-1">Faire une demande</h2>

                            <form >
                                <div class="form-group">
                                    <input type="text" v-model="request_data.title" id="title" placeholder="Titre de la demande" class= "form-control" />
                                    <div v-if="errors.title" class="text-danger">
                                        <ul class="text-danger">
                                            <li v-for="error in errors.title" :key="error">
                                                <small>{{error}}</small>
                                            </li>
                                        </ul>
                                    </div>    
                                </div>

                                <div class="form-group">
                                    <textarea v-model="request_data.description" id="description" placeholder="Description de la demande" class= "form-control" />
                                </div>

                                <div class="form-group">
                                    <input type="submit" v-on:click="createrequest" value="Enregister" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="toast toast-danger text-light" :class="toast.color">
            <div class="toast-header">
                {{toast.header}}
            </div>
            <div class="toast-body">
                {{toast.body}}
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import NavigationStudent from '../../partials/navigationstudent.vue'
export default {
    props: {
        user: Object
    },

    components: {
        NavigationStudent,
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
                    $('.toast').toast('show');
                    _this.request_data = {
                                title: '',
                                description: '',
                            }
                }else{
                    _this.errors = response.data.errors
                }
            })
        },
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    data() {
        return {
            request_data:{
                title: null,
                description: null
            },
            errors:{
                title : null,
                description: null,
            },
            toast:{
                header: null,
                color: null,
                body: null
            }
        }
    },

}
</script>

<style>

</style>