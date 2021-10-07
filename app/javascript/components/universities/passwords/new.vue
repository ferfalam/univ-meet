// TODO Make the link beetween front and back


<template>
    <div>
        <div class="mw-100 vh-100 brand">
            <div class="container mw-100">
                <div class="row text-center">
                    <div class="col col-md-12 col-lg-6"></div>
                    <div class="col col-md-12 col-lg-6 bg-light vh-100 d-flex align-items-center justify-content-center">
                        <div>
                            <a href="/" ><img src="/images/icon.png" class="icon my-1"/></a>
                            <h2 class="my-1">Mot de passe oublié ?</h2>

                            <form action="/universities/password" method="post">
                                <div class="form-group">
                                    <input type="email" name="" id="email" placeholder="Email" class= "form-control" />
                                </div>

                                <div class="form-group">
                                    <input type="submit" value="Envoyer le lien de réinitialisation" class="btn btn-lg btn-primary rounded-sm"/>
                                </div>

                                <div class="row d-flex justify-content-around">
                                    <a class="btn btn-outline-secondary border-0" href="/universities/sign_up"> Vous avez pas un compte ?</a>
                                    <a class="btn btn-outline-secondary border-0" href="/universities/sign_in"> Vous avez un compte ?</a>
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
    name: 'PasswordRest',

}
</script>

<style>

</style>