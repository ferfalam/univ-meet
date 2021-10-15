/* eslint no-console:0 */

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue'
import Cloudinary from "cloudinary-vue";

// Import all the macro components of the application
import * as instances from '../instances'

Vue.use(Cloudinary, {
  configuration: { 
    cloudName: "dv9jyxikh",
    secure: true }
});

Vue.use(TurbolinksAdapter)
    document.addEventListener('turbolinks:load', () => {
    // Initialize available instances
    Object.keys(instances).forEach((instanceName) => {
        const instance = instances[instanceName]
        const elements = document.querySelectorAll(instance.el)

        elements.forEach((element) => {
            const props = JSON.parse(element.getAttribute('data-props'))

            new Vue({
                el: element,
                render: (h) => h(instance.component, { props })
            })
        })
    })
})