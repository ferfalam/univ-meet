// Import components
import TopPage from './components/top/index.vue'
import IndexUniversity from './components/landing/indexuniversity.vue'
import FieldsIndex from './components/universities/fields/index.vue'
import RequestsIndex from './components/universities/requests/index.vue'
import StudentsIndex from './components/universities/students/index.vue'
import AdminIndex from './components/admins/universities/index.vue'
import UniversityLogIn from './components/universities/sessions/new.vue'
import UniversitySignUp from './components/universities/registrations/new.vue'
import UniversityEdit from './components/universities/registrations/edit.vue'
import PasswordReset from './components/universities/passwords/new.vue'
import IndexStudent from './components/landing/indexstudent.vue'
import StudentLogIn from './components/students/sessions/new.vue'
import StudentSignUp from './components/students/registrations/new.vue'
import StudentEdit from './components/students/registrations/edit.vue'
import PasswordResetStudent from './components/students/passwords/new.vue'
import MessageIndex from './components/students/messages/index.vue'
import PostsIndex from './components/students/posts/index.vue'
import ShowIndex from './components/students/posts/show.vue'
import NewRequest from './components/students/requests/new.vue'

// TopPage
export const TopPageInstance = {
    el: '.top-page',
    component: TopPage
}

// Universities
export const IndexUniversityInstance = {
    el: '.landing-university',
    component: IndexUniversity
}

export const FieldsIndexInstance = {
    el: '.fields-index',
    component: FieldsIndex
}

export const RequestsIndexInstance = {
    el: '.requests-index',
    component: RequestsIndex
}

export const StudentsIndexInstance = {
    el: '.students-index',
    component: StudentsIndex
}

export const UniversityLogInInstance = {
    el: '.vue-university-login',
    component: UniversityLogIn
}

export const UniversitySignUpInstance = {
    el: '.vue-university-signup',
    component: UniversitySignUp
}

export const UniversityEditInstance = {
    el: '.vue-university-edit',
    component: UniversityEdit
}

export const PasswordResetInstance = {
    el: '.vue-password-reset',
    component: PasswordReset
}

//admin
export const AdminsIndexInstance = {
    el: '.admin-index',
    component: AdminIndex
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

export const IndexStudentInstance = {
    el: '.landing-student',
    component: IndexStudent
}

export const StudentEditInstance = {
    el: '.vue-student-edit',
    component: StudentEdit
}

export const MessageIndexInstance = {
    el: '.vue-message',
    component: MessageIndex
}

export const PostsIndexInstance = {
    el: '.vue-posts',
    component: PostsIndex
}

export const ShowIndexInstance = {
    el: '.vue-show',
    component: ShowIndex    
}

export const NewRequestInstance = {
    el: '.new-request',
    component: NewRequest
}