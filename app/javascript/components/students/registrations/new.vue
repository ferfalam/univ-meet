// TODO Make the link beetween front and back
<template>
    <div>
        <div class="mw-100 vh-100 brand-student">
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6"></div>
                    <div class="col col-md-12 col-lg-6 bg-light vh-100 d-flex align-items-center justify-content-center">
                        <div>
                            <a href="/" ><img src="/images/icon.png" class="icon my-1"/></a>
                            <h2 class="my-1">Inscription Etudiant</h2>

                            <form action="/students" method="post">
                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" name="" id="firstname" placeholder="Prénom(s)" class= "form-control" />
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" name="" id="lastname" placeholder="Nom" class= "form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" name="" id="phone_number" placeholder="Numéro de téléphone" class= "form-control" />
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="text" name="" id="personal_number" placeholder="Numéro matricule" class= "form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="card-image-label" for="card_image">Uploader votre carte d'étudiant</label>
                                    <input type="file" name="" class="form-control-file card-image-input" id="card_image"/>
                                </div>

                                <div class="form-group">
                                    <input type="email" name="" id="email" placeholder="Email" class= "form-control" />
                                </div>

                                <div class="row justify-content-around">
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="password" name="" id="password" placeholder="Mot de passe" class= "form-control" />
                                        </div>
                                    </div>
                                    <div class="col col-md-12 col-lg-6">
                                        <div class="form-group">
                                            <input type="password" name="" id="password_confirmation" placeholder="Confirmer mot de passe" class= "form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <input type="submit" value="S'enregistrer" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>

                                <div class="row d-flex justify-content-around">
                                    <a class="btn btn-outline-secondary border-0" href="/students/sign_in"> Vous avez un compte ?</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'StudentSignUp',

}
</script>

<style>

</style>