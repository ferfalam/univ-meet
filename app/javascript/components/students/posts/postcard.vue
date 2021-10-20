<template>
    <div>
        <div class="card my-2">
            <div class="card-body">
                <div class="card-text" v-if="!wantModify">
                    {{post_data_init.content}}
                    <div class="d-flex justify-content-center my-2" v-if="post.image">
                        <img :src="post_data_init.image" v-if="post_data_init.image" alt="Image Post">
                    </div>
                </div>
                <div v-else>
                    <div class="form-group">
                        <textarea v-model="post_data.content" placeholder="Modifier votre post" class="form-control content-post" ></textarea>
                    </div>
                    <div class="form-group">
                        <input type="file" v-on:change="onFileChange" class="form-control-file card-image-input" id="card_image"/>
                    </div>
                    <div class="form-group">
                            <button v-on:click="confirmmodify" class="btn btn-success mx-2">Confirmer</button> 
                            <button v-on:click="cancelmodify" class="btn btn-danger">Annuler</button> 
                    </div>
                </div>
            </div>
            <div class="card-footer text-muted">
                <p style="float: left" class="text-muted">Crée le {{post.created_at}} </p>
                <div style="float: right">
                    <button v-on:click="modifypost" class="btn btn-warning">Modifier</button> 
                    <button v-on:click="$emit('delete_post', post)" class="btn btn-danger">Supprimer</button> 
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    props: {
        post: Object
    },

    data() {
        return {
            wantModify: false,
            file_error: null,
            post_data_init: this.post,
            post_data: {
                content: null,
                image: null,
            },
            errors: {
                content: null,
                image: null,
            },
        }
    },

    methods:{
        modifypost: function () {
            this.post_data.content = this.post_data_init.content
            this.wantModify = true  
        },

        cancelmodify: function () {
            this.wantModify = false  
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
                    vm.post_data.image = data_json.url;
                });
            };
            reader.readAsDataURL(file);
        },

        confirmmodify: function () {
            let _this = this
            axios.put('/students/posts/'+ this.post_data_init.id, this.post_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.post_data_init = response.data.post
                    _this.wantModify = false
                }else{
                    _this.errors = response.data.errors
                }
            })
        }

    }
}
</script>

 <style scoped>

</style>