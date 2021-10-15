<template>
  <div>
      <div class="row my-2" style="border-bottom: 1px solid #808080">
          <p class="h3">{{comment.student.lastname}} {{comment.student.firstname}}</p>
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
    }
}
</script>

<style scoped>
    .row{
        flex-direction: column;
    }
</style>