<template>
    <div id="app">
        <NavigationUniversity :user="user" />
        <div class="container my-3">
            <h1>Les Etudiants</h1>
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
            <StudentCard v-for="(student, index) in students_data" :key="student.id" :student="student" :fields="fields" v-on:student_delete="deletestudent(index, $event)" v-on:student_valid="validstudent(index)"/>
        </div>
        <Footer />
    </div>
</template>

<script>
import axios from 'axios'
import NavigationUniversity from '../../partials/navigationuniversity.vue'
import Footer from '../../partials/footer.vue'
import StudentCard from './studentcard.vue'
export default {
    props: {
        students: Array,
        fields: Array,
        user: Object
    },

    mounted() {
        axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },

    methods:{
        validstudent: function (index) {
            let _this=this
            axios.post('/universities/students/valid', this.students_data[index])
            .then(function (response) {
                if (response.data.status == 200) {
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                    _this.init_students_data = response.data.students
                    _this.students_data = response.data.students
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        },

        deletestudent: function (index, req) {
            let _this=this
            axios.delete('/universities/students/'+req.student.id)
            .then(function (response) {
                if (response.data.status == 200) {
                    if (index > -1) {
                        _this.init_students_data.splice(index, 1)
                        _this.students_data.splice(index, 1)
                    }
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                    axios.post("/universities/students/destroymail", req.reason)
                }else{
                    _this.toast = response.data.toast 
                    $('.toast').toast({delay: 3000});
    $('.toast').toast('show');
                }
            })
        },

        validonly: function () {
            this.students_data = this.init_students_data.filter((student) => (student.valid_account == true))
        },

        unvalidonly: function () {
            this.students_data = this.init_students_data.filter((student) => (student.valid_account == false))
        },

        all: function () {
            this.students_data = this.init_students_data
        }
    },

    components: {
        NavigationUniversity,
        Footer,
        StudentCard
    },

    data() {
        return {
            init_students_data: this.students,
            students_data: this.students,
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