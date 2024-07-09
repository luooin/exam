<template>
  <div id="app">
    <router-view v-if="isRouterAlive"/>
  </div>
</template>

<script>
export default {
  name: "App",
  provide() {
    //父组件中通过provide来提供变量，在子组件中通过inject来注入变量。
    return {
      reload: this.reload,
    };
  },
  data() {
    return {
      isRouterAlive: true, //控制视图是否显示的变量
    };
  },
  methods: {
    reload() {
      this.isRouterAlive = false; //先关闭，
      this.$nextTick(function () {
        this.isRouterAlive = true; //再打开
      });
    },
  },
};
</script>

<style lang="less">
#app {
  // font-family: Avenir, Helvetica, Arial, sans-serif;
  font-family: Helvetica, 'Hiragino Sans GB', 'Microsoft Yahei', '微软雅黑', Arial, sans-serif;


  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

html,
body {
  height: 100%;
  padding: 0;
  margin: 0;
  background: #f7f7f7;
}
#app {
  height: 100%;
  overflow: hidden;
  letter-spacing:1px
}
button{
  background: #fff;
  color: #333;
  border: 1px solid #333;
  border-radius: 2px;
  cursor: pointer;
}
button:focus{
  outline: none;
}
ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
.fl {
  float: left;
}
.fr {
  float: right;
}

a{
  color: #333;
  text-decoration: none;
}
//表格居中
.el-table{

    .cell{
        text-align: center;
    }
}
.page{
  margin: 16px 0 12px;
  padding: 6px 24px;
  padding-right: 48px;
  background: #fafafa;
  border-radius: 4px;
  text-align: right;
}
</style>
