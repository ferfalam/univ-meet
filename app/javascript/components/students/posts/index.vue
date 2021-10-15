<template>
  <div id="app">
      <NavigationStudent :user="user" />
      <div class="container my-3">
            <h1>Mes posts</h1>
            <PostCard v-for="(post, index) in posts_data" v-on:delete_post="deletepost(index, $event)" :key="post.id" :post="post" />
            <div class="toast toast-danger text-light" :class="toast.color">
                <div class="toast-header">
                    {{toast.header}}
                </div>
                <div class="toast-body">
                    {{toast.body}}
                </div>
            </div>
      </div>
  </div>
</template>

<script>
import axios from 'axios'
import NavigationStudent from '../../partials/navigationstudent.vue'
import PostCard from './postcard.vue'
export default {
    props: {
        user: Object,
        posts: Array
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    components: {
        PostCard,
        NavigationStudent
    },

    methods:{
        deletepost: function (index, post) {
            let _this=this
            axios.delete('/students/posts/'+ post.id, this.post_data)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.posts_data.splice(index, 1)
                    }
                    _this.toast = response.data.toast 
                    $('.toast').toast('show');
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast('show');
                }
            })
        }
    },

    data() {
        return {
            posts_data: this.posts,
            toast: {
                header: '',
                body: '',
                color: ''
            }
        }
    },
}
</script>

 <style scoped>
#app{
  margin-top: 100px !important
}
</style>