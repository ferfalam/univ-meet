<template>
    <div>
        <div class="card my-4">
            <div class="card-body">
                <h5 class="card-title">{{university.name}}</h5>
                <div class="card-text">
                    <div class="row p-2">
                        <div class="col col-sm-12 col-lg-6">
                        </div>
                        <div class="col col-sm-12 col-lg-6 d-flex">
                            <table>
                                <tr>
                                    <td><strong><u>Nom</u> :</strong></td>
                                    <td><em> {{university.name}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Cigle</u> :</strong></td>
                                    <td><em> {{university.acronym}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Email</u> :</strong></td>
                                    <td><em> {{university.email}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Numéro de téléphone</u> :</strong></td>
                                    <td><em> {{university.phone_number}} </em></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div v-if="!university.valid_account" :id="'invalidate-reason-area-'+university.id" class="w-100" hidden>
                            <div class="alert alert-success" v-if="!university.valid_account" :id="'invalidate-success-'+university.id" hidden></div> 
                            <div class="form-group">
                                <textarea v-model="invalidate_cause" class="form-control" id="invalidate_cause" placeholder="Cause d'invalidation du compte"></textarea>
                                <small class="text-danger" :id="'invalidate-error-'+university.id" hidden>Veuillez entrez le motif d'invalidation</small>
                            </div>
                            <div class="form-group">
                                <button  v-on:click="confirmunvalidation" class="btn btn-danger">Confirmer l'invalidation du compte</button> 
                            </div>
                        </div>
                        <div v-if="!university.valid_account" :id="'delete-reason-area-'+university.id" class="w-100" hidden>
                            <div class="alert alert-success" v-if="!university.valid_account" :id="'delete-success-'+university.id" hidden></div> 
                            <div class="form-group">
                                <textarea v-model="delete_cause" class="form-control" id="delete_cause" placeholder="Cause de la suppression du compte"></textarea>
                                <small class="text-danger" :id="'delete-error-'+university.id" hidden>Veuillez entrez le motif de supression</small>
                            </div>
                            <div class="form-group">
                                <button v-on:click="$emit('university_delete', {university: university, reason: delete_cause})" class="btn btn-danger">Confirmer suppression du compte</button> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer text-muted">
                <p style="float: right" v-if="university.valid_account">Ce compte est valid</p>
                <div v-else>
                    <button  v-on:click="$emit('university_valid', university)" class="btn btn-outline-success">Valider le compte</button>
                    <button  v-on:click="unvaliduniversity" class="btn btn-outline-warning">Invalider le compte</button>
                    <button v-on:click="deleteuniversity" class="btn btn-outline-danger">Supprimer le compte</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    props: {
        university: Object,
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    methods: {

        deleteuniversity: function () {
            document.getElementById("invalidate-reason-area-"+this.university.id).hidden = true
            document.getElementById("delete-reason-area-"+this.university.id).hidden = false
        },

        unvaliduniversity: function () {
            document.getElementById("delete-reason-area-"+this.university.id).hidden = true
            document.getElementById("invalidate-reason-area-"+this.university.id).hidden = false
        },

        confirmunvalidation: function (e) {
            e.preventDefault();
            let _this=this
            if (this.invalidate_cause) {
                document.getElementById('invalidate-error-'+_this.university.id).hidden = true
                axios.post('/admins/universities/unvalid', {university: _this.university, reason: _this.invalidate_cause}).
                then(function (res) {
                    if (res.data.status === 200) {
                        document.getElementById('invalidate-success-'+_this.university.id).hidden = false
                        document.getElementById('invalidate-success-'+_this.university.id).innerHTML = res.data.message
                        setTimeout(() => {
                            document.getElementById('invalidate-reason-area-'+_this.university.id).hidden = true
                        }, 2000);
                    }
                })
            }else{
                document.getElementById('invalidate-error-'+_this.university.id).hidden = false
            }
        }
    },

    data() {
        return {
            invalidate_cause: null,
            delete_cause: null
        }
    },
}
</script>

 <style scoped>
</style>