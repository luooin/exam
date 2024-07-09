import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import http from './api/axios'
import api from '@/utils/api.js'
import {role} from '@/utils/role'
import filters from '@/filters'


Vue.use(ElementUI);
Object.keys(filters).forEach(key => Vue.filter(key, filters[key]))

Vue.prototype.$http = http;
Vue.prototype.$role = role;
Vue.prototype.$api = api;

//全局前置守卫
router.beforeEach(async (to, from, next) => {
    if (to.name === "Login") {
        next()
    } else {
        const token = localStorage.getItem("_token");
        if (!token) {
            ElementUI.Message("您还未登录，请先登录")
            next("/login")

        } else {
            //获得权限
            await store.dispatch('getRole')
            next();
        }
    }
})


Vue.config.productionTip = false;
new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app')
