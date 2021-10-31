<template>
  <div id="app">
      <NavigationStudent :user="user" />
      <div class="container my-3">
            <h1>Mes Favoris</h1>
            <PostCard v-for="(post) in posts_data" :key="post.id" :post="post" :user="user"/>
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
 .toast{
    position: fixed;
    right: 5px;
    top: 5px;
    z-index: 1;
}

#app{
  margin-top: 100px !important
}
</style>