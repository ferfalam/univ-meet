<template>
    <div>
        <div class="card my-2">
            <div class="card-header">
                <div class="h3"> {{owner.lastname}} {{owner.firstname}} </div>
                <div class="h6"> Crée le {{post.created_at}}</div>
            </div>
            <div class="card-body">
                <div class="card-text">
                    {{post.content}}
                    <div class="d-flex justify-content-center my-2" v-if="post.image">
                        <img :src="post.image" v-if="post.image" alt="Image Post">
                    </div>
                </div>
                <div class="card-footer">
                    <div class="form-group row">
                        <div class="col col-3" v-if="user.id != owner.id">
                            <button v-on:click="unfavorite" class="btn" v-if="favorite"> <img src="/images/like/2.png" alt=""> </button> 
                            <button v-on:click="favorite_m" class="btn" v-if="!favorite"> <img src="/images/like/1.png" alt=""> </button> 
                        </div>
                        <div class="col col-9">
                            <textarea v-model="commentaire" class="form-control"></textarea>
                            <button v-on:click="comment" class="btn btn-success mx-2">Commenter</button> 
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

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    props: {
        user: Object,
        elmt: Object
    },

    data() {
        return {
            favorite: this.elmt.favorite,
            post: this.elmt.post,
            owner: this.elmt.owner,
            file_error: null,
            errors: {
                content: null,
                image: null,
            },

            commentaire: null
        }
    },

    methods:{
        comment: function () {
            console.log("Comment")
        },

        favorite_m: function () {
           axios.post( "/students/posts/favorite/"+ this.post.id,).
           then((res) => {
               if (res.data.status === 200) {
                   this.favorite = true
               }
           })
        },

        unfavorite: function () {
            axios.post( "/students/posts/unfavorite/"+ this.post.id,).
           then((res) => {
               if (res.data.status === 200) {
                   this.favorite = false
               }
           })
        },
    }
}
</script>

<style>

</style>