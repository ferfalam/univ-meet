<template>
    <nav class="navbar navbar-expand-lg navbar-dark ">
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
        <form class="d-flex">
            <a href="/admins/universities" class="btn btn-outline-info mx-2" v-if="user.admin">Administration</a>
            <a rel="nofollow" data-method="delete" href="/universities/sign_out" class="btn btn-outline-danger">Déconnexion</a>
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
                    text: "Tableau de bord",
                    path: "/universities/landing",
                    children_links: []
                },
                {
                    text: "Filières",
                    path: "/universities/fields",
                    children_links: []
                },
                {
                    text: "Demandes",
                    path: "/universities/requests",
                    children_links: []
                },
                {
                    text: "Etudiants",
                    path: "/universities/students",
                    children_links: []
                },
                {
                    text: this.user.name ? this.user.name : this.user.email,
                    path: "/universities/edit",
                    children_links: []
                }
            ]

        }
    },
}
</script>