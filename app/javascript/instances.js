// Import components
import IndexUniversity from './components/landing/indexuniversity.vue'
import UniversityLogIn from './components/universities/sessions/new.vue'
import UniversitySignUp from './components/universities/registrations/new.vue'
import PasswordReset from './components/universities/passwords/new.vue'
import StudentLogIn from './components/students/sessions/new.vue'
import StudentSignUp from './components/students/registrations/new.vue'
import PasswordResetStudent from './components/students/passwords/new.vue'

//IndexUniversity
export const IndexUniversityInstance = {
    el: '.landing-page',
    component: IndexUniversity
}

//Universities
export const UniversityLogInInstance = {
    el: '.vue-university-login',
    component: UniversityLogIn
}

export const UniversitySignUpInstance = {
    el: '.vue-university-signup',
    component: UniversitySignUp
}

export const PasswordResetInstance = {
    el: '.vue-password-reset',
    component: PasswordReset
}

//Students
export const StudentLogInInstance = {
    el: '.vue-student-login',
    component: StudentLogIn
}

export const StudentSignUpInstance = {
    el: '.vue-student-signup',
    component: StudentSignUp
}

export const PasswordResetStudentInstance = {
    el: '.vue-password-reset-student',
    component: PasswordResetStudent
}