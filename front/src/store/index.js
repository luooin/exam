import Vue from 'vue'
import Vuex from 'vuex'
import api from '@/api/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    activeName: 'Home',// 导航栏激活名称

    tchNav: [
      {
        i:"el-icon-s-home",
        title:"首页",
        path:"/main/home",
        name:"Home",
      },
      {
        i:"el-icon-s-grid",
        title:"班级信息",
        path:"/main/classes/classesList",
        name:["Classes","ClassesList","ClassesSpace"]
      },
      {
        i:"el-icon-s-check",
        title:"考试科目",
        path:"/main/subjectList",
        name:"SubjectList"
      },
      {
        i:"el-icon-document-copy",
        title:"试卷管理",
        path:"/main/myTest",
        name:"MyTest"
      },
      {
        i:"el-icon-tickets",
        title:"用户管理",
        path:"/main/topic",
        name:"Topic"
      },
      {
        i:"el-icon-user",
        title:"个人中心",
        path:"/main/me",
        name:"Me"
      },
    ],
    stuNav: [
      {
        i:"el-icon-s-home",
        title:"首页",
        path:"/main/home",
        name:"Home"
      },
      {
        i:"el-icon-s-grid",
        title:"我的班级",
        path:"/main/classes/classesList",
        name:["Classes","ClassesList","ClassesSpace"]
      },
      {
        i:"el-icon-edit-outline",
        title:"我考过的试卷",
        path:"/main/MyFinishTest",
        name:"MyFinishTest"
      },
      {
        i:"el-icon-user",
        title:"个人中心",
        path:"/main/me",
        name:"Me"
      },
    ],
    userName: '',
    userPhoto: '',
    userRole: 'student',
  },
  mutations: {
    setActiveName(state,data){
      state.activeName = data
    },

    setUserName(state,data){
      state.userName = data
    },

    setUserRole(state,data){
      state.userRole = data
    },

    setUserPhoto(state,data){
      if(data){
        state.userPhoto = Vue.prototype.$imageBaseUrl + data
      }else{
        state.userPhoto = null
      }
    },
    setTestData(state,data){
      state.testData = data
    }

  },
  actions: {
    async getRole({commit ,state}){
      const res = await api.get("/getUserById")
      commit('setUserRole', res.data.role)
      commit('setUserName', res.data.userName)
      commit('setUserPhoto',  res.data.photo)
      return res.data;
    }
  },
  modules: {
  }
})
