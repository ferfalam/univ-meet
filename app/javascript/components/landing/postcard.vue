<template>
    <div>
        <div class="card my-2">
            <div class="card-header">
                <div class="h3"> {{owner.lastname}} {{owner.firstname}} </div>
                <div class="h6"> Crée le {{post.created_at}}</div>
            </div>
            <div class="card-body">
                <div class="card-text">
                    {{getContent()}}
                    <a :href="url" v-if="sub">...Voir plus</a> 
                    <a :href="url" v-else>Voir la publication</a> 
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
                            <button v-on:click="comment" class="btn btn-success my-2">Commenter</button> 
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
            sub:false,
            commentaire: null,
            url: '/students/posts/'+this.elmt.post.id
        }
    },

    methods:{
        comment: function () {
            let _this=this
            axios.post('/students/comments',{context: this.commentaire, post_id: this.post.id, student_id: this.user.id})
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.errors = {
                        content: null
                    }
                    _this.toast = response.data.toast
                    $('.toast').toast('show');
                    _this.commentaire = null
                }else{
                    _this.errors = response.data.errors
                }
            })
        },

        getContent: function () {
            if (this.post.length > 300) {
                this.sub = true
                return this.post.content.substring(0, 300)
            } else {
                this.sub = false
                return this.post.content
            }
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

 <style scoped>

</style>