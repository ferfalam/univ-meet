<template>
    <div>
        <div class="card my-2">
            <div class="card-header">
                <div class="h3">{{field_data.name}}</div>
                <div class="text-muted">{{field_data.acronym}}</div>
            </div>
            <div class="card-body">
                <h5 class="card-title">Editer la filière</h5>
                <div class="card-text">
                    <form action="">
                        <div class="alert p-2 text-light" :class="message.color" v-if="message.text"> {{message.text}} </div>
                        <div class="row">
                            <div class="col col-sm-12 col-lg-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" v-model="field_data.name" placeholder="Modifier nom complet de la filière">
                                    <ul v-if="errors.name" class="text-danger">
                                            <li v-for="error in errors.name" :key="error">
                                                <small>{{error}}</small>
                                            </li>
                                        </ul>
                                </div>
                            </div>
                            <div class="col col-sm-12 col-lg-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" v-model="field_data.acronym" placeholder="Modifier diminutif de la filière">
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
                <button v-on:click="editfield(field)" class="btn btn-warning">Editer</button>
                <button  v-on:click="$emit('delete_field', field)" class="btn btn-danger">Supprimer</button>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    props: {
        field: Object
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    methods: {
        editfield: function (field) {
            let _this = this
            axios.put('/universities/fields/'+field.id, this.field_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.errors = {
                                name: null,
                                acronym: null,
                            }
                    _this.message = response.data.message
                    setTimeout(() => {
                        _this.message = {
                                    color: null,
                                    text: null
                                }
                    }, 2000);
                }else{
                    _this.errors = response.data.errors
                }
            })
        }
    },

    data() {
        return {
            field_data : {
                name: this.field.name,
                acronym: this.field.acronym
            },
            message : {
                color: null,
                text: null
            },
            errors: {
                name: null,
                acronym: null,
            },
        }
    },
}
</script>

 <style scoped>
</style>