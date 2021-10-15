<template>
    <div id="app">
        <NavigationTopPage />
        <div class="modal fade" id="loginmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Choisissez votre role</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row text-center">
                            <div class="col col-sm-12 col-lg-6 my-sm-2">
                                <a href="/universities/sign_in" class="btn btn-primary">Université ou Admin</a>    
                            </div>
                            <div class="col col-sm-12 col-lg-6 my-sm-2">
                                <a href="/students/sign_in" class="btn btn-primary">Etudiant</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="registermodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Choisissez votre role</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row text-center">
                            <div class="col col-sm-12 col-lg-6 my-sm-2">
                                <a href="/universities/sign_up" class="btn btn-primary">Université ou Admin</a>    
                            </div>
                            <div class="col col-sm-12 col-lg-6 my-sm-2">
                                <a href="/students/sign_up" class="btn btn-primary">Etudiant</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container my-3">
            <div id="carouselExampleCaptions" class="carousel slide vh-50" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
                    <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="/images/top/1.jpg" class="d-block w-100" alt="...">
                        <div class="carousel-caption d-block bg-primary ">
                            <h3>UnivMeet</h3>
                            <p>Université ou Administrateur, vous pouvez contôler qui a le droit de seconnecter ou pas à ce réseau social en validant ou en invalidant les comptes après inscription.</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="/images/top/2.jpg" class="d-block w-100" alt="...">
                        <div class="carousel-caption d-block bg-primary">
                            <h3>UnivMeet</h3>
                            <p>Etudiants, discutez et partagez vos expériences entre vous, ce réseau étant destiné qu'aux étudiants de cette patrie vous ne serez pas distrait par des comptes factices.</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="/images/top/3.jpg" class="d-block" alt="...">
                        <div class="carousel-caption d-block bg-primary">
                            <h3>UnivMeet</h3>
                            <p>Etudiant, en toute anonymat n'hésiter pas à faire des demandes ou des plaintes à votre université. Universtité, soyez à l'écoute des demandes des étudiants pour le bon fonctionnement de votre établissement.</p>
                        </div>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>

        <Footer />
    </div>
</template>

<script>
import NavigationTopPage from '../partials/navigationtoppage.vue'
import Footer from '../partials/footer.vue'
export default {
    mounted() {
    },
    components: {
        NavigationTopPage,
        Footer
    }
}
</script>

<style scoped>
    #app{
        min-height: 100vh;
        flex-direction: column;
        justify-content: space-between;
        display: flex;
    }

    .carousel-item img{
        max-width: 100vh;
        max-height: 70vh;
    }

    @media (min-width: 1180px) {
        .carousel-caption{
            max-width: 70vh;
            display: flex !important;
            flex-direction: column;
            position: static;
            align-content: center;
            justify-content: center;
        }
    }

    .carousel-caption p{
        font-size: 10px;
        font-weight: 300;
    }

    .carousel-item.active, .carousel-item-next, .carousel-item-prev {
        display: flex;
        justify-content: center;
    }
</style>