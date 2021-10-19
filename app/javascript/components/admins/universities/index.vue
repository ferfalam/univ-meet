<template>
    <div id="app">
        <NavigationAdmin :user="user" />
        <div class="container my-3">
            <div class="toast toast-danger text-light" :class="toast.color">
                <div class="toast-header">
                    {{toast.header}}
                </div>
                <div class="toast-body">
                    {{toast.body}}
                </div>
            </div>
            <div class="row">
                <div class="col col-sm-12 col-lg-4"><button class="btn btn-secondary w-100" v-on:click="validonly">Valid seul</button></div>
                <div class="col col-sm-12 col-lg-4"><button class="btn btn-secondary w-100" v-on:click="all">Tout</button></div>
                <div class="col col-sm-12 col-lg-4"><button class="btn btn-secondary w-100" v-on:click="unvalidonly">Invalid seul</button></div>
            </div>
            <UniversityCard v-for="(university, index) in universities_data" :key="university.id" :university="university" v-on:university_delete="deleteuniversity(index, $event)" v-on:university_valid="validuniversity(index)"/>
        </div>
        <Footer />
    </div>
</template>

<script>
import axios from 'axios'
import NavigationAdmin from '../../partials/navigationadmin.vue'
import Footer from '../../partials/footer.vue'
import UniversityCard from './universitycard.vue'
export default {
    props: {
        universities: Array,
        user: Object
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    methods:{
        validuniversity: function (index) {
            let _this=this
            axios.post('/admins/universities/valid', this.universities_data[index])
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                    _this.init_universities_data = response.data.universities
                    _this.universities_data = response.data.universities
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        },

        deleteuniversity: function (index, req) {
            let _this=this
            axios.delete('/admins/universities/'+req.university.id)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.init_universities_data.splice(index, 1)
                        _this.universities_data.splice(index, 1)
                    }
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                    axios.post("/admins/universities/destroymail", req.reason)
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        },

        validonly: function () {
            this.universities_data = this.init_universities_data.filter((university) => (university.valid_account == true))
        },

        unvalidonly: function () {
            this.universities_data = this.init_universities_data.filter((university) => (university.valid_account == false))
        },

        all: function () {
            this.universities_data = this.init_universities_data
        }
    },

    components: {
        NavigationAdmin,
        Footer,
        UniversityCard
    },

    data() {
        return {
            init_universities_data: this.universities,
            universities_data: this.universities,
            toast: {
                header: '',
                body: '',
                color: ''
            }
        }
    },
}
</script>

 <style scoped>
.toast{
    position: fixed;
    right: 5px;
    top: 5px;
    z-index: 1;
}
</style>