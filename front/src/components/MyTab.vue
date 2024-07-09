<template>
  <div class="content-bg">
    <div class="tab-title">
      <div class="tabTitle-item" v-for="(item,index) in menu" :key="index" :class="activeId==item.id?'active':''"
           @click="goRouter(item)" :title="item.title">
        <div class="title">{{ item.title }}</div>
        <span v-if="index!=0" class="el-icon-close" @click.stop="removePaper(item.id)"></span>
      </div>
    </div>

    <div class="tab-item">
      <router-view @openPaper="openPaper"/>
    </div>

  </div>
</template>

<script>
import "../assets/less/my_tab.less";

export default {
  inject: ['reload'],
  name: "MyTab",
  props: ["menu", "openFinishTestId", "paperName", "listName"],
  data() {
    return {
      activeId: "-1",
      enterClasses_id: "",//申请加入班级的id
      //参加班级的数据
      enterClassesData: {
        classes: {
          number: "",
          name: "",
          create_data: "",
          people_num: "",
          introduction: "",
        },
      },
      menu: [
      ]
    };
  },

  created() {
    //查询sessionStorage记录 , 生成用户已经打开过的页面
    if (sessionStorage[this.openFinishTestId] != null) {
      const openCheckTestId = JSON.parse(
          sessionStorage.getItem(this.openFinishTestId)
      );

      this.menu.push({
        title: openCheckTestId.title,
        name: this.paperName,
        id: openCheckTestId.id,
      });

    }

    if (this.$route.params.id === undefined) {
      this.activeId = "-1";
      // console.log(this.$route);
    } else {
      this.activeId = this.$route.params.id;
    }
  },
  methods: {
    //路由跳转
    goRouter(item) {
      if (this.activeId === item.id) {
        return;
      }
      this.activeId = item.id;
      this.$router.push({
        name: item.name,
        params: {id: item.id},
      });
    },

    //打开新的试卷
    openPaper(id, title) {
      //sessionStorage存储   刷新后依旧有效
      let openCheckTestId;
//如果openCheckTestId不存在,初始化openCheckTestId
      if (sessionStorage[this.openFinishTestId] == null) {
        openCheckTestId = {
          title: title,
          id: id,
        };
        sessionStorage.setItem(
            this.openFinishTestId,
            JSON.stringify(openCheckTestId)
        );

        //把页面添加到menu
        this.menu.push({
          title,
          name: this.paperName,
          id: id,
        });
      } else {
        openCheckTestId = JSON.parse(
            sessionStorage.getItem(this.openFinishTestId)
        );

        //如果该页面没有记录到sessionStorage里
        if (openCheckTestId.id != id) {
          openCheckTestId.id = id;
          openCheckTestId.title = title;
          sessionStorage.setItem(
              this.openFinishTestId,
              JSON.stringify(openCheckTestId)
          );

          //把页面添加到menu
          this.menu[1] = {
            title,
            name: this.paperName,
            id: id,
          };
        }
      }

      // 跳转到该页面
      this.activeId = id;
      this.$router.push({
        name: this.paperName,
        params: {id: id},
      });
    },

    //关闭页面
    removePaper(id) {
      //删除当前页面
      for (let i = 0; i < this.menu.length; i++) {
        if (this.menu[i].id == id) {
          this.menu.splice(i, 1);
          break;
        }
      }
      sessionStorage.removeItem(this.openFinishTestId);
      //跳转回主页面
      this.activeId = "-1";
      this.$router.push({
        name: this.listName,
      });
    },
  },
};
</script>

