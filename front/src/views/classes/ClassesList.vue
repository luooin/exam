<template>
  <div class="classesList">

    <div class="list-header" :class="isFixed?'isFixed':''" :style="topic_nav_style">
      <el-button type="primary" size="medium" icon="el-icon-plus" v-if="$role('teacher')" @click="createClasses()"
                 class="createClasses">创建班级
      </el-button>
      <div class="enterClasses">
        <el-input v-model="classesKeyword" size="small" placeholder="请输入班级编号或者班级名称"
                  prefix-icon="el-icon-search"></el-input>
        <el-button type="primary" size="small" @click="getClasses(classesKeyword)">查询</el-button>
      </div>
    </div>

    <div class="class-list" v-loading="loading">
      <h4 v-if="classesList.length === 0">
        暂无班级,快联系教师加入吧
      </h4>
      <div class="class-box" v-for="(item,index) in classesList" :key="index">
        <div class="title">
          <div class="className">班级名称: {{ item.classesName }}</div>
        </div>
        <div class="info">
          <div class="info-row">
            <div v-if="$role('student')" class="info-item">加入时间 : {{ item.enterDate }}</div>
            <div v-else class="info-item">创建时间 : {{ item.createDate }}</div>
          </div>
          <div class="info-item">班级人数 : {{ item.peopleNum }} 人</div>
          <div class="info-item">班级简介 : <p>{{ item.introduction }}</p>
          </div>
        </div>
        <div class="title-but">
          <el-button size="medium" type="primary" @click="openPaper(item.classesId,item.classesName)">进入班级
          </el-button>
          <el-button size="medium" type="info" @click="editClasses(item)" plain v-if="$role('teacher')">编辑</el-button>
          <el-button
              v-if="$role('teacher')"
              size="medium"
              type="danger"
              plain
              @click="outClasses(item.classesId)">
            删除班级
          </el-button>
        </div>

      </div>
    </div>

    <div class="page">
      <el-pagination
          background layout="total, prev, pager, next,jumper"
          @current-change="currentChange"
          :total="total"
          :page-size="pageSize"/>
    </div>

    <!-- 创建班级对话框 -->
    <CreateClasses ref="createClasses" @success="getClasses()"/>


    <!-- 修改班级对话框 -->
    <EditClasses ref="EditClasses" @success="getClasses()"/>
  </div>
</template>

<script>
import "@/assets/less/main/classeslist.less";
import CreateClasses from './components/CreateClasses'
import EditClasses from './components/EditClasses'
import {mapState} from "vuex";

export default {
  name: "ClassesList",
  components: {CreateClasses, EditClasses},
  computed: {
    ...mapState(['userRole'])
  },
  data() {
    return {
      // 班级列表
      classesList: [],

      // 查询班级列表keyword
      classesKeyword: "",

      //侧导航栏是否悬浮
      isFixed: false,
      topic_nav_style: "top:0px",

      //分页
      currentPage: 1,
      pageSize: 4,
      total: null,

      loading: false,
    };
  },

  created() {
    this.getClasses();
  },

  mounted() {
    // 监听滚动事件，然后用handleScroll这个方法进行相应的处理
    // document.getElementsByClassName('tab-item')[0]
    document
        .getElementsByClassName("tab-item")[0]
        .addEventListener("scroll", this.handleScroll);
  },

  methods: {
    //获取用户的班级列表
    getClasses() {
      this.loading = true
      let params = {
        pageSize: this.pageSize,
        currentPage: this.currentPage,
        keyword: this.classesKeyword
      }
      setTimeout(() => {
        this.$http.get('/queryClassesList', {params}).then(res => {
          this.classesList = res.data.content;
          this.total = res.data.total
          this.loading = false

          if (!this.classesList && this.userRole === 'student') {
            // 学生直接进入班级
            const classes = this.classesList[0];
            this.openPaper(classes.classesId, classes.classesName);
          }

        })
      }, 500);

    },

    //进入班级空间
    openPaper(id, title) {
      this.$emit("openPaper", id, title);
    },

    // 创建班级
    createClasses() {
      this.$refs.createClasses.dialog = true
    },

    // 修改班级
    editClasses(val) {
      this.$refs.EditClasses.dialog = true
      this.$refs.EditClasses.editClassesData = JSON.parse(JSON.stringify(val))
    },

    //退出班级
    outClasses(c_id) {
      // 代表是教师角色,要删除掉班级信息
      this.$confirm(" 这将会删除所有与班级有关的信息", "确定要删除班级?", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
      }).then(() => {
        // 处理post请求参数
        const params = {
          id: c_id,
        };
        this.$http.delete('/deleteClasses', {params}).then(res => {
          if (res.code === 200) {
            this.$message.success(res.msg)
            this.getClasses();
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
      });
      // 代表是学生角色,退出当前班级
    },

    //切换分页时触发
    currentChange(val) {
      this.currentPage = val
      this.getClasses()
    },

    //滚动事件
    handleScroll() {
      // 滚动条偏移量
      // let scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
      let scrollTop = document.getElementsByClassName("tab-item")[0].scrollTop;

      if (scrollTop > 1) {
        this.topic_nav_style = "top:" + (scrollTop + 10) + "px";
        this.isFixed = true;
      } else {
        this.isFixed = false;
        this.topic_nav_style = "top: 0px";
      }
    },
  },
};
</script>

<style lang="less" scoped>

</style>
