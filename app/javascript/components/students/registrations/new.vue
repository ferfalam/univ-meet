// TODO Make the link beetween front and back
<template>
    <div>
        <div class="mw-100 vh-100 brand-student">
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6"></div>
                    <div class="col col-md-12 col-lg-6 bg-light vh-100 d-flex align-items-center justify-content-center">
                        <div>
                            <a href="/" ><img src="/images/icon.png" class="icon my-1"/></a>
                            <h2 class="my-1">Inscription Etudiant</h2>

                            <form action="/students" method="post">
                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" v-model="registration_data.firstname" id="firstname" placeholder="Prénom(s)" class= "form-control" />
                                            <div v-if="errors.firstname" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.firstname" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" v-model="registration_data.lastname" id="lastname" placeholder="Nom" class= "form-control" />
                                            <div v-if="errors.lastname" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.lastname" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" v-model="registration_data.phone_number" id="phone_number" placeholder="Numéro de téléphone" class= "form-control" />
                                            <div v-if="errors.phone_number" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.phone_number" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" v-model="registration_data.personal_number" id="personal_number" placeholder="Numéro matricule" class= "form-control" />
                                            <div v-if="errors.personal_number" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.personal_number" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <select v-on:change="onUniversityChange" v-model="registration_data.university_id" class="custom-select">
                                                <option v-for="university in universities" :key="university.id" :value="university.id"> {{university.acronym}} </option>
                                            </select>   
                                            <div v-if="errors.university" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.university" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>                                 
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <select v-model="registration_data.field_id" class="custom-select">
                                                <option v-for="field in fields_choice" :key="field.id" :value="field.id"> {{field.acronym}} </option>
                                            </select>   
                                            <div v-if="errors.field" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.field" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>                                     
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="card-image-label" for="card_image">Uploader votre carte d'étudiant</label>
                                    <input type="file" v-on:change="onFileChange" class="form-control-file card-image-input" id="card_image"/>
                                    <div v-if="file_error" class="text-danger">
                                        <ul class="text-danger">
                                            <li >
                                                <small>{{file_error}}</small>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <input type="email" v-model="registration_data.email" id="email" placeholder="Email" class= "form-control" />
                                    <div v-if="errors.email" class="text-danger">
                                        <ul class="text-danger">
                                            <li v-for="error in errors.email" :key="error">
                                                <small>{{error}}</small>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="password" v-model="registration_data.password" id="password" placeholder="Mot de passe" class= "form-control" />
                                            <div v-if="errors.password" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.password" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="password" v-model="registration_data.password_confirmation" id="password_confirmation" placeholder="Confirmer mot de passe" class= "form-control" />
                                            <div v-if="errors.password_confirmation" class="text-danger">
                                                <ul class="text-danger">
                                                    <li v-for="error in errors.password_confirmation" :key="error">
                                                        <small>{{error}}</small>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <input type="submit" v-on:click="registration" value="S'enregistrer" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>

                                <div class="row d-flex justify-content-around">
                                    <a class="btn btn-outline-secondary border-0" href="/students/sign_in"> Vous avez un compte ?</a>
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
    name: 'StudentSignUp',
    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    props: {
        universities: Array,
        fields: Array
    },

    data: () => {
        return {
            file_error: "Insérer une image",
            fields_choice: null,
            errors: {
                firstname: null,
                lastname: null,
                phone_number: null,
                personal_number: null,
                card_image: null,
                field: null,
                university: null,
                email: null,
                password: null,
                password_confirmation: null
            },
            registration_data : {
                firstname: null,
                lastname: null,
                phone_number: null,
                personal_number: null,
                card_image: null,
                email: null,
                password: null,
                password_confirmation: null,
                university_id: null,
                field_id: null
            }
        }
    },

    methods: {
        registration: function(e) {
            e.preventDefault();
            if (this.file_error) {
                this.file_error = "Extensions autorisées : .jpg, .jpeg, .png"
            }else{
                let _this = this
                axios.post('/students', this.registration_data)
                .then(function (res) {
                    if (res.data.status == 200) {
                        window.location =  res.data.url
                    } else {
                        _this.errors = res.data.errors
                    }
                })
            }
            
        },
        onUniversityChange: function (e) {
            let fields_for_select = this.fields.filter((field) => (field.university_id === this.registration_data.university_id))
            this.fields_choice = fields_for_select
        },

        onFileChange: function (e) {
            let files = e.target.files || e.dataTransfer.files;

            if (files.length) {
                let files_tab = files[0].name.split(".")
                let files_extension = files_tab[files_tab.length - 1]
                if (['jpeg', "jpg", 'png'].includes(files_extension)) {
                    this.createImage(files[0])
                    this.file_error = null
                }else{
                    this.file_error = "Le fichier doit être une image"
                }
            }else{
                this.file_error = "Le fichier doit être une image"
            }

        },
        createImage(file) {
            var image = new Image();
            var reader = new FileReader();
            var vm = this;

            reader.onload = (e) => {
                const formData = new FormData();
                const url = "https://api.cloudinary.com/v1_1/demo/image/upload";
                
                formData.append("file", e.target.result);
                formData.append("upload_preset", "docs_upload_example_us_preset");

                fetch(url, {
                method: "POST",
                body: formData
                })
                .then((response) => {
                    return response.text();
                })
                .then((data) => {
                    let data_json =  JSON.parse(data)
                    console.log("data", data_json)
                    vm.registration_data.card_image = data_json.url;
                });
            };
            reader.readAsDataURL(file);
        },
    },
}
</script>

<style>

</style>