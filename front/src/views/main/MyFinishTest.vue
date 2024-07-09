<template>
  <div class="FinishTest">
    <TopTab title="我考过的试卷">
      <div class="tab-content">
        <div class="list-header">
          <span class="list-title">我考过的试卷</span>
          <div class="query">
            <el-input v-model="keyword" size="small" placeholder="请输入试卷编号或者试卷名称" prefix-icon="el-icon-search"></el-input>
            <el-button type="primary" size="small" @click="getTestPaperList(keyword)">查询</el-button>
          </div>
        </div>

        <div class="table">
          <el-table :data="finishExamList" style="width: 100%" v-loading="loading">
            <el-table-column label="试卷编号" width="110">
              <template slot-scope="scope">E{{scope.row.examId}} </template>
            </el-table-column>
            <el-table-column prop="examName" label="试卷名称" />
            <el-table-column label="班级编号" width="110">
              <template slot-scope="scope">C{{scope.row.classesId}} </template>
            </el-table-column>
            <el-table-column prop="classesName" label="班级名称" />
            <el-table-column prop="answerDate" label="答题时间" width="210" />
            <el-table-column prop="grade" label="分数" width="110" />
            <el-table-column label="试卷状态" width="110">
              <template slot-scope="scope">{{scope.row.markStatus === 1 ? '批改完成':'待批改'}} </template>
            </el-table-column>
            <el-table-column label="操作" width="240">
              <template slot-scope="scope">
                <el-button type="primary" size="mini" plain @click="goExam(scope.row.examId, scope.row.classesId)">查看试卷</el-button>
                 <el-button type="primary" size="mini" plain @click="goClasses(scope.row.classesId,scope.row.classesName)">进入班级</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>

        <div class="page">
          <el-pagination background layout="total, prev, pager, next,jumper" :total="total" :page-size="pageSize" @current-change="currentChange" />
        </div>

      </div>
    </TopTab>
  </div>
</template>

<script>
import TopTab from "../../components/TopTab.vue";
import "../../assets/less/main/finishTest.less";
export default {
  name: "MyFinishTest",
  components: {
    TopTab,
  },
  data() {
    return {
      finishExamList: [],
      keyword: "",

      //分页
      currentPage: 1,
      pageSize: 10,
      total: null,

      loading: false,
    };
  },
  created() {
    this.getFinishExamList();
  },

  watch: {},

  methods: {
    //获取列表
    async getFinishExamList() {
      this.loading = true;
      let params = {
        pageSize: this.pageSize,
        currentPage: this.currentPage,
      };
      setTimeout(() => {
        this.$http.get("/getFinishExam", { params }).then((res) => {
          res.data.content.map(t =>{
            if(!t.grade){
              t.grade = '--'
            }
          })
          this.finishExamList = res.data.content;
          this.total = res.data.total;
          this.loading = false;
        });
      }, 500);
    },

    //打开试卷
    goExam(examId,classesId){
      var { href } = this.$router.resolve({
        name: "TestPaperStu",
        params: {
          tp_id: examId,
          c_id: classesId,
        },
      });
      window.open(href, "_blank");
    },

    //进入班级
    goClasses(id,title){
      this.$router.push({
        name: 'ClassesSpace',
        params: {id}
      })
    },

    //切换分页时触发
    currentChange(val) {
      this.currentPage = val;
      this.getFinishExamList();
    },
  },
};
</script>

<style lang="less" scoped>
.FinishTest {
  .table {
    margin-top: 24px;
  }
}
.list-header {
  position: relative;
  background: #fafafa;
  padding: 6px 24px;
  border-radius: 4px;
  height: 60px;
  box-sizing: border-box;
  box-shadow: 0 2px 4px 0 rgb(0 0 0 / 12%), 0 0 6px 0 rgb(0 0 0 / 4%);

  span.list-title {
    display: inline-block;
    margin-right: 30px;
    font-size: 16px;
    line-height: 48px;
  }
  .query {
    position: absolute;
    right: 24px;
    top: 14px;
    width: 400px;
    height: 40px;
  }
  .query .el-input {
    width: 320px;
    margin-right: 20px;
  }
  .query .el-button {
    background: #4788cc;
    border-color: #4788cc;
    transition: 1s;
  }
}
</style>
