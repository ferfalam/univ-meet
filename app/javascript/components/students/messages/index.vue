<template>
  <div id="app">
      <NavigationStudent :user="user" />
      <div class="main">
          <h1>Sera disponible très bientôt</h1>
      </div>
  </div>
</template>

<script>
import NavigationStudent from '../../partials/navigationstudent.vue'
export default {
    props:{
        user: Object
    },

    components:{
        NavigationStudent
    }
}
</script>

<style>
    #app{
        height: 100vh;
    }
    .main{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
    }
</style>