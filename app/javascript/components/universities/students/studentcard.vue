<template>
    <div>
        <div class="card my-4">
            <div class="card-body">
                <h5 class="card-title">{{student.lastname+' '+student.firstname}}</h5>
                <div class="card-text">
                    <div class="row p-2">
                        <div class="col col-sm-12 col-lg-6">
                            <img :src="student.card_image" alt="Carte d'étudiant">
                        </div>
                        <div class="col col-sm-12 col-lg-6 d-flex">
                            <table>
                                <tr>
                                    <td><strong><u>Nom</u> :</strong></td>
                                    <td><em> {{student.lastname}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Prénom(s)</u> :</strong></td>
                                    <td><em> {{student.firstname}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Email</u> :</strong></td>
                                    <td><em> {{student.email}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Numéro de téléphone</u> :</strong></td>
                                    <td><em> {{student.phone_number}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Numéro matricule</u> :</strong></td>
                                    <td><em> {{student.personal_number}} </em></td>
                                </tr>
                                <tr>
                                    <td><strong><u>Filière</u> :</strong></td>
                                    <td :title="field ? field.title : ''"><em> {{field ? field.acronym : ''}} </em></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div v-if="!student.valid_account" :id="'invalidate-reason-area-'+student.id" class="w-100" hidden>
                            <div class="alert alert-success" v-if="!student.valid_account" :id="'invalidate-success-'+student.id" hidden></div> 
                            <div class="form-group">
                                <textarea v-model="invalidate_cause" class="form-control" id="invalidate_cause" placeholder="Cause d'invalidation du compte"></textarea>
                                <small class="text-danger" :id="'invalidate-error-'+student.id" hidden>Veuillez entrez le motif d'invalidation</small>
                            </div>
                            <div class="form-group">
                                <button  v-on:click="confirmunvalidation" class="btn btn-danger">Confirmer l'invalidation du compte</button> 
                            </div>
                        </div>
                        <div v-if="!student.valid_account" :id="'delete-reason-area-'+student.id" class="w-100" hidden>
                            <div class="alert alert-success" v-if="!student.valid_account" :id="'delete-success-'+student.id" hidden></div> 
                            <div class="form-group">
                                <textarea v-model="delete_cause" class="form-control" id="delete_cause" placeholder="Cause de la suppression du compte"></textarea>
                                <small class="text-danger" :id="'delete-error-'+student.id" hidden>Veuillez entrez le motif de supression</small>
                            </div>
                            <div class="form-group">
                                <button v-on:click="$emit('student_delete', {student: student, reason: delete_cause})" class="btn btn-danger">Confirmer suppression du compte</button> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer text-muted">
                <p style="float: right" v-if="student.valid_account">Ce compte est valid jusqu'au {{student.valid_until}}</p>
                <div v-else>
                    <button  v-on:click="$emit('student_valid', student)" class="btn btn-outline-success">Valider le compte</button>
                    <button  v-on:click="unvalidstudent" class="btn btn-outline-warning">Invalider le compte</button>
                    <button v-on:click="deletestudent" class="btn btn-outline-danger">Supprimer le compte</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    props: {
        student: Object,
        fields: Array,
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        this.getField(this.student)
    },

    methods: {
        getField: function (student) {
            this.fields.forEach(field => {
                if (field.id === student.field_id) {
                    this.field = field
                }
            });
        },

        deletestudent: function () {
            document.getElementById("invalidate-reason-area-"+this.student.id).hidden = true
            document.getElementById("delete-reason-area-"+this.student.id).hidden = false
        },

        unvalidstudent: function () {
            document.getElementById("delete-reason-area-"+this.student.id).hidden = true
            document.getElementById("invalidate-reason-area-"+this.student.id).hidden = false
        },

        confirmunvalidation: function (e) {
            e.preventDefault();
            let _this=this
            if (this.invalidate_cause) {
                document.getElementById('invalidate-error-'+_this.student.id).hidden = true
                axios.post('/universities/students/unvalid', {student: _this.student, reason: _this.invalidate_cause}).
                then(function (res) {
                    if (res.data.status === 200) {
                        document.getElementById('invalidate-success-'+_this.student.id).hidden = false
                        document.getElementById('invalidate-success-'+_this.student.id).innerHTML = res.data.message
                        setTimeout(() => {
                            document.getElementById('invalidate-reason-area-'+_this.student.id).hidden = true
                        }, 2000);
                    }
                })
            }else{
                document.getElementById('invalidate-error-'+_this.student.id).hidden = false
            }
        }
    },

    data() {
        return {
            invalidate_cause: null,
            delete_cause: null,
            field: null
        }
    },
}
</script>

 <style scoped>
</style>