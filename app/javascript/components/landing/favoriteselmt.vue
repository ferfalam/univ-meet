<template>
    <div class="w-100 my-2 favorite-card" >
        <div class="row align-items-center">
            <div class="col col-12">
                {{getContent()}}... <a href="#">voir plus</a>
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
                return this.favorite.content
            } else {
                return this.favorite.content.substring(0, 150)
            }
        }
    },
}
</script>

<style>

</style>