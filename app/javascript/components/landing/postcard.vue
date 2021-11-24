<template>
    <div>
        <div class="toast toast-danger text-light" :class="toast.color">
            <div class="toast-header">
                {{toast.header}}
            </div>
            <div class="toast-body">
                {{toast.body}}
            </div>
        </div>
        <div class="card my-4">
            <div class="card-header">
                <div class="h3"> {{owner.lastname}} {{owner.firstname}} </div>
                <div class="h6"> Crée le {{formartDate(post.created_at)}}</div>
            </div>
            <div class="card-body">
                <div class="card-text">
                    {{getContent()}}
                    <a :href="url" v-if="sub">...Voir plus</a> 
                    <a :href="url" v-else>Voir la publication</a> 
                    <div class="d-flex justify-content-center my-2" v-if="post.image">
                        <img class="w-100" :src="post.image" v-if="post.image" alt="Image Post">
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <div class="form-group row">
                    <div class="col col-3">
                        <div v-if="user.id != owner.id">
                            <button v-on:click="unfavorite" class="btn" v-if="favorite"> <img src="/images/like/2.png" alt=""> </button> 
                            <button v-on:click="favorite_m" class="btn" v-if="!favorite"> <img src="/images/like/1.png" alt=""> </button> 
                        </div>
                    </div>
                    <div class="col col-9">
                        <p class="text-mute" style="float: right;"><a :href="url"> {{numberComment}} commentaire{{numberComment > 1 ? 's':''}} </a></p>
                        <textarea v-model="commentaire" placeholder="Commentaire" class="form-control"></textarea>
                        <button v-on:click="comment" class="btn btn-success my-2">Commenter</button> 
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
            numberComment: this.elmt.comment,
            file_error: null,
            errors: {
                content: null,
                image: null,
            },
            sub:false,
            commentaire: null,
            url: '/students/posts/'+this.elmt.post.id,
            toast: {
                header: '',
                body: '',
                color: ''
            },
            date: null
        }
    },

    methods:{
        formartDate: function (date) {
            const month = ["Janvier", "Février", "Mars", "Avril", 
                "Mai", "Juin", "Juillet", "Août", 
                "Septembre", "Octobre", "Novembre",
                "Septembre", "Octobre", "Novembre", "Décembre"
            ]
            const temp = new Date(date)

            const day= temp.getDate() < 10 ? "0"+temp.getDate() : temp.getDate()  
            const hour= temp.getHours() < 10 ? "0"+temp.getHours() : temp.getHours()  
            const minutes= temp.getMinutes() < 10 ? "0"+temp.getMinutes() : temp.getMinutes()  

            return day+" "+month[temp.getMonth()]+" "+temp.getFullYear()+" à "+hour+":"+minutes
        },
        comment: function () {
            let _this=this
            axios.post('/students/comments',{context: this.commentaire, post_id: this.post.id, student_id: this.user.id})
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.errors = {
                        content: null
                    }
                    _this.toast = response.data.toast
                    $('.toast').toast({delay: 3000});
                    $('.toast').toast('show');
                    _this.commentaire = null
                    _this.numberComment += 1
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

.toast{
    position: fixed;
    right: 5px;
    top: 5px;
    z-index: 1;
}

</style>