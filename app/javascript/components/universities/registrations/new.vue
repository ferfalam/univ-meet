// TODO Make the link beetween front and back

<template>
    <div>
        <div class="mw-100 min-vh-100 brand">
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6"></div>
                    <div class="col col-md-12 col-lg-6 bg-light min-vh-100 d-flex align-items-center justify-content-center p-3">
                        <div>
                            <a href="/" ><img src="/images/icon.png" class="icon my-1"/></a>
                            <h2 class="my-1">Inscription Université</h2>

                            <form action="#" method="post">
                                <div class="form-group">
                                    <input type="text" v-model="registration_data.name" id="name" placeholder="Nom de l'Uninversité" class= "form-control" />
                                    <div v-if="errors.name" class="text-danger">
                                        <ul class="text-danger">
                                            <li v-for="error in errors.name" :key="error">
                                                <small>{{error}}</small>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <input type="text" v-model="registration_data.acronym" id="acronym" placeholder="Sigle de l'Université" class= "form-control" />
                                    <ul v-if="errors.acronym" class="text-danger">
                                        <li v-for="error in errors.acronym" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="text" v-model="registration_data.phone_number" id="phone_number" placeholder="Numéro de téléphone" class= "form-control" />
                                    <ul v-if="errors.phone_number" class="text-danger">
                                        <li v-for="error in errors.phone_number" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>
                                
                                <div class="form-group">
                                    <input type="email" v-model="registration_data.email" id="email" placeholder="Email" class= "form-control" />
                                    <ul v-if="errors.email" class="text-danger">
                                        <li v-for="error in errors.email" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="password" v-model="registration_data.password" id="password" placeholder="Mot de passe" class= "form-control" />
                                    <ul v-if="errors.password" class="text-danger">
                                        <li v-for="error in errors.password" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="password" v-model="registration_data.password_confirmation" id="password_confirmation" placeholder="Confirmer mot de passe" class= "form-control" />
                                    <ul v-if="errors.password_confirmation" class="text-danger">
                                        <li v-for="error in errors.password_confirmation" :key="error">
                                            <small>{{error}}</small>
                                        </li>
                                    </ul>
                                </div>

                                <div class="form-group">
                                    <input type="submit" v-on:click="registration" value="S'enregistrer" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>

                                <div class="row d-flex justify-content-around">
                                    <a class="btn btn-outline-secondary border-0" href="/universities/sign_in"> Vous avez un compte ?</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name: 'UniversitySignUp',
    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    data: () => {
        return {
            errors: {
                name: null,
                acronym: null,
                phone_number: null,
                email: null,
                password: null,
                password_confirmation: null
            },
            registration_data : {
                name: null,
                acronym: null,
                phone_number: null,
                email: null,
                password: null,
                password_confirmation: null
            }
        }
    },
    methods: {
        registration: function(e) {
            let _this = this
            e.preventDefault();
            axios.post('/universities', this.registration_data)
            .then(function (res) {
                if (res.data.status == 200) {
                    window.location =  res.data.url
                } else {
                    _this.errors = res.data.errors
                }
            })
        }
    },
}
</script>