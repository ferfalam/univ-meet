<template>
    <nav class="navbar navbar-expand-lg navbar-dark ">
    <a class="navbar-brand d-flex align-items-center" href="/"><img src="/images/icon.png" alt="" class="icon pr-2"> UnivMeet</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarScroll">
        <ul class="navbar-nav ml-auto my-2 my-lg-0 navbar-nav-scroll" >
            <div v-for="navbar_link in navbar_links" :key="navbar_link.text">
                <li class="nav-item" :class="active_link(navbar_link)" v-if="navbar_link.children_links == 0">
                    <a class="nav-link" :href="navbar_link.path">{{navbar_link.text}}</a>
                </li>
                <li class="nav-item dropdown" :class="active_link(navbar_link)" v-else>
                    <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
                    {{navbar_link.text}}
                    </a>    
                    <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                    <li><a class="dropdown-item" v-for="children_link in  navbar_link.children_links" :key="children_link.text" :href="children_link.path">{{children_link.text}}</a></li>
                    </ul>
                </li>
            </div>
        </ul>
        <form class="">
            <a href="/guest/admin" class="btn btn-outline-light mx-2">Admin Invité</a>
            <a href="/guest/university" class="btn btn-outline-light mx-2">Université Invité</a>
            <a href="/guest/student" class="btn btn-outline-light mx-2">Etudiant Invité</a>
            <button type="button" class="btn btn-outline-light mx-2" data-toggle="modal" data-target="#loginmodal">
                Se connecter
            </button>
            <button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#registermodal">
                S'inscrire
            </button>
        </form>
    </div>
    </nav>
</template>

<script>
export default {
    mounted() {
        // console.log(this.navbar_links)
    },

    methods: {
        active_link: function (link) {
            return {
                active: window.location.pathname == link.path,
            }
        }
    },

    data() {
        return {
            navbar_links: [
            ]

        }
    },
}
</script>

<style scoped>
@media (max-width: 991px) {
    form{
        display: flex;
        align-items: end;
        flex-direction: column;        
    }
    form a, form button{
        margin: 5px 5px;
        width: 170px;
        display: block;
    }
}
</style>