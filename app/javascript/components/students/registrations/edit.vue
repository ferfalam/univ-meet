// TODO Make the link beetween front and back

<template>
    <div>
        <div class="mw-100 min-vh-100">
            <Navigation :user=user />
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6 d-flex align-items-center justify-content-center">
                        <div class="">
                            <img :src="user.card_image" alt="Carte d'étudiant">
                        </div>
                    </div>
                    <div class="col col-md-12 col-lg-6 bg-light min-vh-100 d-flex align-items-center justify-content-center p-3">
                        <div>
                            <a href="/" ><img src="/images/icon.png" class="icon my-1"/></a>
                            <h2 class="my-1">Profil de {{user.name ? user.name : user.email}}</h2>

                            <form action="#" method="post">
                                <div class="alert alert-success my-2" v-if="success_message">
                                    {{success_message}}
                                </div>
                                <div class="alert alert-info my-2" v-if="notice">
                                    {{notice}}
                                </div>
                                <div class="form-group">
                                    <div class="h3"> <strong><em> {{user.lastname}} {{user.firstname}} </em></strong></div>
                                </div>

                                <div class="form-group">
                                    <p class="h5"> {{user_info.university.name}} </p>
                                    <p class="h5"> {{user_info.field.name}} </p>
                                </div>

                                <div class="form-group">
                                    <p class="h5"> {{user.personal_number}} </p>
                                </div>
                                
                                <div class="form-group">
                                    <input type="email" v-model="edit_data.email" id="email" placeholder="Email" class= "form-control" />
                                    <ul v-if="errors.email" class="text-danger">
                                        <li v-for="error in errors.email" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="text" v-model="edit_data.phone_number" id="phone_number" placeholder="Numéro de téléphone" class= "form-control" />
                                    <ul v-if="errors.phone_number" class="text-danger">
                                        <li v-for="error in errors.phone_number" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="password" v-model="edit_data.last_password" id="last_password" placeholder=" Ancien mot de passe" class= "form-control" />
                                    <div v-if="last_password_error" class="text-danger">
                                        <small>{{last_password_error}}</small>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <input type="password" v-model="edit_data.password" id="password" placeholder="Mot de passe" class= "form-control" />
                                    <ul v-if="errors.password" class="text-danger">
                                        <li v-for="error in errors.password" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="password" v-model="edit_data.password_confirmation" id="password_confirmation" placeholder="Confirmer mot de passe" class= "form-control" />
                                    <ul v-if="errors.password_confirmation" class="text-danger">
                                        <li v-for="error in errors.password_confirmation" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="submit" v-on:click="editprofil" value="Modifier mes informations" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>

                                <div class="row d-flex justify-content-around">
                                    <a rel="nofollow" data-method="delete" href="/students" class="btn btn-outline-danger">Supprimer ce compte</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import Navigation from '../../partials/navigationstudent.vue'
import Footer from '../../partials/footer.vue'
export default {
    name: 'StudentEdit',

    props: {
        user: Object,
        user_info: Object,
        notice: String
    },
    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        this.edit_data.phone_number = this.user.phone_number
        this.edit_data.email = this.user.email
    },

    components: {
        Navigation,
        Footer
    },

    data: () => {
        return {
            errors: {
                email: null,
                password: null,
                password_confirmation: null
            },
            edit_data : {
                email: null,
                last_password: null,
                password: null,
                password_confirmation: null
            },
            last_password_error: null,
            success_message: null
        }
    },
    methods: {
        editprofil: function(e) {
            let _this = this
            e.preventDefault();
            axios.put('/students', this.edit_data)
            .then(function (res) {
                if (res.data.status == 200) {
                    _this.last_password_error = null
                    _this.error = {
                        email: null,
                        password: null,
                        password_confirmation: null
                    }
                    _this.user = res.data.user
                    _this.success_message = res.data.message
                    setTimeout(() => {
                        _this.success_message = null
                    }, 2000);
                } else {
                    if (res.data.errors) {
                        _this.errors = res.data.errors
                    } else {
                        _this.last_password_error = res.data.last_password_error
                    }
                }
            })
        }
    },
}
</script>

<style scoped>
    .container{
        margin-top: 100px
    }
</style>