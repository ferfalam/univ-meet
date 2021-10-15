<template>
    <div class="w-100 my-2 favorite-card" >
        <div class="row align-items-center">
            <div class="col col-12">
                {{getContent()}}
                <a :href="url" v-if="sub">...Voir plus</a> 
                <a :href="url" v-else>Voir la publication</a> 
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        favorite: Object
    },

    methods: {
        getContent: function () {
            if (this.favorite.length > 150) {
                this.sub= true
                return this.favorite.content.substring(0, 150)
            } else {
                this.sub= false
                return this.favorite.content
            }
        }
    },

    data() {
        return {
            sub: false,
            url: '/students/posts/'+this.favorite.id
        }
    },
}
</script>

<style>

</style>