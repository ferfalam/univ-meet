<template>
  <div id="app">
      <NavigationUniversity :user="user" />
      <div class="container my-3">
        <div class="row">
          <Card v-for="data_info in data_infos" :key="data_info.name" :data="data_info"/>
        </div>
      </div>
      <Footer />
  </div>
</template>
<script>
  import NavigationUniversity from '../partials/navigationuniversity.vue'
  import Footer from '../partials/footer.vue'
  import Card from './dashcard.vue'
  export default {
    name: "IndexUniversity",

    mounted() {
      console.log(this.user)
    },
    
    props: {
      data_dashboard: Object,
      user: Object
    },

    components: {
      NavigationUniversity,
      Card,
      Footer
    },

    data: function () {
      return {
        data_infos:[
          {
            name: "Filière(s)",
            color: "bg-success",
            url: "#" ,
            count: this.data_dashboard.fields.length ,
          },
          {
            name: "Demande(s)",
            color: "bg-warning",
            url: "#" ,
            count: this.data_dashboard.requests.length ,
          },
          {
            name: "Etudiants valide",
            color: "bg-info",
            url: "#" ,
            count: this.data_dashboard.students.filter((value) => (value.valid_until.length != 0)).length ,
          },
          {
            name: "Etudiants Non valide",
            color: "bg-danger",
            url: "#" ,
            count: this.data_dashboard.students.filter((value) => (value.valid_until.length == 0)).length ,
          }
        ]
      }
    }
  }
</script>