<template>
    <nav class="navbar navbar-expand-lg navbar-light bg-light nav-student">
    <a class="navbar-brand d-flex align-items-center" href="/"><img src="/images/icon.png" alt="" class="icon pr-2"> UnivMeet</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarScroll">
        <ul class="navbar-nav mr-auto my-2 my-lg-0 navbar-nav-scroll" >
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
        <form class="d-flex" >
            <a rel="nofollow" data-method="delete" href="/students/sign_out" class="btn btn-outline-danger">Déconnexion</a>
        </form>
    </div>
    </nav>
</template>

<script>
export default {
    props: {
        user: Object
    },

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
                {
                    text: "Acceuil",
                    path: "/students/landing",
                    children_links: []
                },
                {
                    text: "Mes posts",
                    path: "/students/posts",
                    children_links: []
                },
                {
                    text: "Messagerie",
                    path: "/students/messages",
                    children_links: []
                },
                {
                    text: "Faire une demande",
                    path: "/students/requests/",
                    children_links: []
                },
                {
                    text: this.user.name ? this.user.name : this.user.email,
                    path: "/students/edit",
                    children_links: []
                }
            ]

        }
    },
}
</script>

<style scoped>
nav{
    position: fixed;
    z-index: 1;
    width: 100vw;
    top: 0;
}
</style>