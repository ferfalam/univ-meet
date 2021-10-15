<template>
    <div id="app">
        <NavigationUniversity :user="user" />
        <div class="container my-3">
            <h1>Les filières</h1>
            <div class="card my-2">
                <div class="card-body">
                    <h5 class="card-title">Nouvelle filière</h5>
                    <div class="card-text">
                        <form action="">
                            <div class="row">
                                <div class="col col-sm-12 col-lg-6">
                                    <div class="form-group">
                                        <input type="text" class="form-control" v-model="field_data.name" placeholder="Nom complet de la filière">
                                        <ul v-if="errors.name" class="text-danger">
                                            <li v-for="error in errors.name" :key="error">
                                                <small>{{error}}</small>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col col-sm-12 col-lg-6">
                                    <div class="form-group">
                                        <input type="text" class="form-control" v-model="field_data.acronym" placeholder="Dimunitif de la filière">
                                        <ul v-if="errors.acronym" class="text-danger">
                                            <li v-for="error in errors.acronym" :key="error">
                                                <small>{{error}}</small>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    <button v-on:click="createfield" class="btn btn-info">Créer une filière</button>
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
            <FieldCard v-for="(field, index) in fields" :key="field.id" :field="field" v-on:delete_field="deletefield(index, $event)" v-on:edit_field="editfield(index, $event)"/>
        </div>
        <Footer />
    </div>
</template>

<script>
import axios from 'axios'
import NavigationUniversity from '../../partials/navigationuniversity.vue'
import Footer from '../../partials/footer.vue'
import FieldCard from './fieldscard.vue'
export default {
    props: {
        fields: Array,
        user: Object
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    methods:{
        createfield: function () {
            let _this=this
            axios.post('/universities/fields', this.field_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.errors = {
                                name: null,
                                acronym: null,
                            }
                    _this.toast = response.data.toast
                    _this.fields.push(response.data.field)
                    $('.toast').toast('show');
                    _this.field_data = {
                                name: '',
                                acronym: '',
                            }
                }else{
                    _this.errors = response.data.errors
                }
            })
        },
        deletefield: function (index, field) {
            let _this=this
            axios.delete('/universities/fields/'+field.id, this.field_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.fields.splice(index, 1)
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
        FieldCard
    },

    data() {
        return {
            errors: {
                name: null,
                acronym: null,
            },
            field_data: {
                name: '',
                acronym: ''
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