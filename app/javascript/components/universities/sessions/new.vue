// TODO Make the link beetween front and back

<template>
    <div>
        <div class="mw-100 vh-100 brand">
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6"></div>
                    <div class="col col-md-12 col-lg-6 bg-light vh-100 d-flex align-items-center justify-content-center">
                        <div>
                            <a href="/" ><img src="/images/icon.png" class="icon my-1"/></a>
                            <h2 class="my-1">Connection Université</h2>

                            <form action="/universities/sign_in" method="post">
                                <div class="alert alert-danger p-2" v-if="error"> {{error}} </div>
                                <div class="form-group">
                                    <input type="email" v-model="login_data.email"  id="email" placeholder="Email" class= "form-control" />
                                </div>

                                <div class="form-group">
                                    <input type="password" v-model="login_data.password" id="password" placeholder="Mot de passe" class= "form-control" />
                                </div>

                                <div class="form-group">
                                    <input type="checkbox" v-model="login_data.remember_me" id="remember_me" class="form-check-input" />
                                    <label class="form-check-label" for="remember_me">
                                        Se souvenir de moi
                                    </label>
                                </div>

                                <div class="form-group">
                                    <input type="submit" v-on:click="login" value="Se connecter" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>

                                <div class="row d-flex justify-content-around">
                                    <a class="btn btn-outline-info border-0" href="/universities/password/new"> Mot de passe oublié ?</a>
                                    <a class="btn btn-outline-secondary border-0" href="/universities/sign_up"> Vous avez pas un compte ?</a>
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
    name: 'UniversityLogIn',
    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    data: () => {
        return {
            error: null,
            login_data : {
                email: null,
                password: null,
                remenber_me: null
            }
        }
    },
    methods: {
        login: function(e) {
            let _this = this
            e.preventDefault();
            axios.post('/universities/sign_in', this.login_data)
            .then(function (res) {
                if (res.data.url) {
                    // console.log(res.data)
                    window.location =  res.data.url
                } else {
                    _this.error = 'Information de connexion Incorrect'
                }
            })
        }
    },
}
</script>