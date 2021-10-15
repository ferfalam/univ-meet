<template>
    <div>
        <NavigationStudent :user="user" />
        <div class="container my-2 content-page">
            <div class="row post">
                <p class="h2 text-center"> {{owner.lastname}} {{owner.firstname}} </p>
                <div class="sep"></div>
                <p> {{post_data.content}} </p>
                <div class="text-center"><img :src="post_data.image" alt=""></div>
                <div class="sep"></div>
                <div class="col col-12 my-2">
                    <textarea v-model="commentaire" class="form-control"></textarea>
                    <button v-on:click="comment" class="btn btn-success my-2">Commenter</button> 
                </div>
                <div class="sep"></div>
                <CommentCard v-for="(comment, index) in comments_data" :key="comment.comment.id" :comment="comment" v-on:delete_comment="deletecomment(index, $event)" :user="user" />
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import NavigationStudent from '../../partials/navigationstudent.vue'
import CommentCard from './commentcard.vue'
export default {
    props:{
        user: Object,
        owner: Object,
        post: Object,
        comments: Array,
        students: Array,    
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        this.getcomments()
    },

    components: {
        NavigationStudent,
        CommentCard
    },

    data() {
        return {
            post_data:this.post,
            comments_init: this.comments,
            commentaire: null,
            comments_data: [],
            toast: null
        }
    },

    methods: {
        deletecomment: function (index, comment) {
            let _this=this
            axios.delete('/students/comments/'+comment.comment.id)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.comments_init.splice(index, 1)
                    }
                    _this.comments_data = []
                    _this.getcomments()
                    _this.toast = response.data.toast 
                    $('.toast').toast('show');
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast('show');
                }
            })
        },

        getcomments: function () {
            this.comments_init.forEach(comment => {
                let temp = {
                    comment: comment,
                    student: null
                }
                this.students.forEach(student => {
                    if (comment.student_id == student.id) {
                        temp.student = student
                    }
                });
                this.comments_data.push(temp)
            });
        },

        comment: function (){
            let _this=this
            axios.post('/students/comments',{context: this.commentaire, post_id: this.post_data.id, student_id: this.user.id})
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.errors = {
                        content: null
                    }
                    _this.toast = response.data.toast
                    _this.comments_init.push(response.data.comment)
                    $('.toast').toast('show');
                    _this.comments_data = []
                    _this.getcomments()
                    _this.commentaire = null
                }else{
                    _this.errors = response.data.errors
                }
            })
        }
    },

}
</script>

 <style scoped>
    .content-page{
        margin-top: 100px !important
    }

    .post{
        flex-direction: column;
    }

    .sep{
        border-bottom: 2px solid rgb(81, 81, 81)
    }
</style>