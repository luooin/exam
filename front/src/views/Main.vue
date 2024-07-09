<template>
  <div class="main">
    <div class="header">
      <div class="logo" style="margin: 0;" @click="goRouter('/main/home','Home')">
        线上考试系统
      </div>
      <div class="person">
        <div class="img">
          <template>
            <img :src="$store.state.userPhoto || defaultPhoto" alt=""/>
          </template>
        </div>
        <div class="name">{{ $store.state.userName }}</div>
        <div class="dropdown">
          <div class="item" @click="loginOut">退出登录</div>
        </div>
      </div>

    </div>

    <div class="main">
      <div class="aside" ref="aside">
        <div class="menu" @mouseenter="menuEnter" @mouseleave="menuOut">
          <div class="menu-item" v-for="(item ,index) in menu"
               :key="index"
               ref="menu_item"
               @click="goRouter(item.path,item.name)"
               :class="activeName === item.name ? 'active':''">
            <i :class="item.i"></i>
            <span v-if="isSpread || isMenuHover">{{ item.title }}</span>
          </div>

        </div>
        <div class="spread">
          <i :class="isSpread? 'el-icon-download isPackup':'el-icon-upload2 isSpread'" @click="spread"></i>
        </div>

      </div>


      <div class="main-content" ref="content">
        <router-view/>
      </div>


    </div>
  </div>
</template>

<script>
import "../assets/font/iconfont.css"
import "../assets/less/main.less"
import defaultSrc from '../assets/images/defaultPhoto.png'
import {mapMutations, mapState} from 'vuex';

export default {
  name: "Main",
  inject: ['reload'],
  data() {
    return {

      userData: [],//用户数据

      menu: [],//侧导航栏数据

      isSpread: true,//侧栏是否为展开状态

      isMenuHover: false,//鼠标是否移入侧栏

      defaultPhoto: defaultSrc,
    };
  },
  computed: {
    ...mapState(['activeName', 'tchNav', 'stuNav', 'userName', 'userRole'])
  },

  async created() {
    if (this.userRole === "teacher") {
      this.menu = this.tchNav;
    } else if (this.userRole === "student") {
      this.menu = this.stuNav;
    } else {
      this.$router.push("/Login")
    }

    // 渲染侧导航栏
    for (let i = 0; i < this.menu.length; i++) {
      if (this.menu[i].name.indexOf(this.$route.name) > -1) {
        // console.log(this.menu[i].name);
        this.setActiveName(this.menu[i].name)
        break;
      }
    }

  },

  methods: {
    ...mapMutations(['setActiveName']),

    //路由跳转
    goRouter(path, name) {
      if (this.activeName === name) {
        return
      }
      this.setActiveName(name)
      this.$router.push(path)

    },

    //退出登录
    loginOut() {
      localStorage.removeItem("_token")
      sessionStorage.removeItem("openClassesSpace")

      this.$router.push({name: "Login"})
    },

    /* 侧栏收起与展开事件 start*/
    spread() {
      if (this.isSpread) {
        this.packupStyle();
      } else {
        this.spreadStyle();
      }
      this.isSpread = !this.isSpread;

    },
    spreadStyle() {
      this.$refs.aside.style.width = "200px";
      this.$refs.menu_item.map(v => {
        v.style.paddingLeft = "20px"
      })
      this.$refs.content.style.width = "calc(100% - 200px)"
    },
    packupStyle() {
      this.$refs.aside.style.width = "44px";
      this.$refs.menu_item.map(v => {
        v.style.paddingLeft = "10px"
      })
      this.$refs.content.style.width = "calc(100% - 44px)"
    },
    menuEnter() {
      if (this.isSpread) {
        return
      }
      this.isMenuHover = true;
      this.$refs.aside.style.width = "200px"
    },
    menuOut() {
      if (this.isSpread) {
        return
      }
      this.isMenuHover = false;
      if (this.isSpread === false && this.isMenuHover === false) {
        this.$refs.aside.style.width = "44px"
      }
    },
    /* 侧栏收起与展开事件  end */

  },


};
</script>
