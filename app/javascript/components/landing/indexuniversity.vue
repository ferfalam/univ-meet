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
      // console.log(this.user)
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
            url: "/universities/fields",
            count: this.data_dashboard.fields ? this.data_dashboard.fields.length : 0,
          },
          {
            name: "Demande(s)",
            color: "bg-warning",
            url: "/universities/requests" ,
            count: this.data_dashboard.requests ? this.data_dashboard.requests.length : 0,
          },
          {
            name: "Etudiants valide",
            color: "bg-info",
            url: "/universities/students" ,
            count: this.data_dashboard.students ? this.data_dashboard.students.filter((value) => (value.valid_account == true)).length : 0,
          },
          {
            name: "Etudiants Non valide",
            color: "bg-danger",
            url: "/universities/students" ,
            count: this.data_dashboard.students ? this.data_dashboard.students.filter((value) => (value.valid_account == false)).length : 0,
          }
        ]
      }
    }
  }
</script>

<style scoped>
footer{
  /* position: absolute;
  bottom: 0 */
}
</style>