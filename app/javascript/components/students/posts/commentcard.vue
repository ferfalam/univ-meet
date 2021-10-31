<template>
  <div>
      <div class="row my-2 w-100 mx-0" style="border-bottom: 1px solid #808080">
          <p class="h3">{{comment.student.lastname}} {{comment.student.firstname}}</p>
          <p class="text-muted"> {{formartDate(comment.comment.created_at)}} </p>
          <p class="text-justify">
              {{comment.comment.context}}
          </p>
          <div class="my-1" v-if="user.id == comment.student.id">
                <button  v-on:click="$emit('delete_comment', comment)" class="btn btn-danger">Supprimer</button>
          </div>
      </div>
  </div>
</template>

<script>
export default {
    props:{
        user: Object,
        comment: Object
    },

    methods: {

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
    }
}
</script>

<style scoped>
    .row{
        flex-direction: column;
    }
</style>