<template>
  <div class="myTest content-bg ">
    <div class="tab-title">
      <div class="tabTitle-item active">我的试卷</div>
    </div>
    <div class="tab-item">
      <div class="list-header">
        <el-button type="primary" size="medium" icon="el-icon-plus" @click="createTestPaper" class="create">新建试卷
        </el-button>
        <div class="query">
          <el-input v-model="keyword" size="small" placeholder="请输入试卷编号或者试卷名称"
                    prefix-icon="el-icon-search"></el-input>
          <el-button type="primary" size="small" @click="getTestPaperList(keyword)">查询</el-button>
        </div>
      </div>

      <div class="table">
        <el-table :data="testPaperList" style="width: 100%" v-loading="loading">
          <el-table-column label="试卷编号" width="110">
            <template slot-scope="scope">E{{ scope.row.examId }}</template>
          </el-table-column>
          <el-table-column label="试卷名称" min-width="150">
            <template slot-scope="scope">{{ scope.row.examName }}</template>
          </el-table-column>
          <el-table-column label="所属科目" min-width="150">
            <template slot-scope="scope">{{ scope.row.subjectName }}</template>
          </el-table-column>
          <el-table-column prop="topicNum" label="题目数量" width="110">
          </el-table-column>
          <el-table-column label="是否打乱题目顺序" width="150">
            <template slot-scope="scope">{{ scope.row.disruptOrder === 1 ? '是' : '否' }}</template>
          </el-table-column>
          <el-table-column label="允许页面切换次数" width="150">
            <template slot-scope="scope">{{ scope.row.switchPage === -1 ? '--' : scope.row.switchPage }}</template>
          </el-table-column>
          <el-table-column label="是否自动评改" width="150">
            <template slot-scope="scope">{{ scope.row.autoMack === 1 ? '是' : '否' }}</template>
          </el-table-column>
          <el-table-column prop="totalScore" label="总分" width="110">
          </el-table-column>
          <el-table-column prop="passMark" label="及格分数" width="110">
          </el-table-column>
          <el-table-column prop="enter_date" label="更新时间" width="240">
            <template slot-scope="scope">
              <i class="el-icon-time"></i>
              <span style="margin-left: 10px">{{ scope.row.createDate }}</span>
            </template>
          </el-table-column>
          <!-- <el-table-column prop="subjectName" label="试卷类型" width="100"> </el-table-column> -->
          <el-table-column label="操作" width="240" fixed="right">
            <template slot-scope="scope">
              <el-button type="primary" size="mini" plain @click="releaseTest(scope.row.examId,scope.row.examName)">
                发布考试
              </el-button>
              <el-button v-if="scope.row.releasing === 0" type="info" size="mini" plain
                         @click="editTestPaper(scope.row.examId)">编辑
              </el-button>
              <el-button v-if="scope.row.releasing === 0" type="danger" size="mini" plain
                         @click="deleteTest(scope.row.examId)">删除
              </el-button>
              <el-button v-if="scope.row.releasing === 1" type="info" size="mini" plain
                         @click="editTestPaper(scope.row.examId)">查看试卷
              </el-button>
            </template>
          </el-table-column>

        </el-table>
      </div>

      <div class="page">
        <el-pagination background layout="total, prev, pager, next,jumper" @current-change="currentChange"
                       :total="total" :page-size="pageSize"/>
      </div>

      <!-- 发布考试弹框 -->
      <ReleaseTest ref="releaseTestDialog"/>

    </div>
  </div>
</template>

<script>
import "../../assets/less/my_tab.less";
import ReleaseTest from './components/ReleaseTest'

export default {
  name: "MyTest",
  components: {ReleaseTest},
  data() {
    return {
      loading: true,

      testPaperList: [],// 所有的试卷列表

      // 分页
      currentPage: 1,
      pageSize: 10,
      total: null,

      keyword: '',
    };
  },

  created() {
    this.getTestPaperList();
  },

  methods: {
    //获取试卷列表
    getTestPaperList(val = '') {
      this.loading = true
      let params = {
        pageSize: this.pageSize,
        currentPage: this.currentPage,
        keyword: val
      };
      setTimeout(() => {
        this.$http.get("/getTestPaperByU_id", {params}).then((res) => {
          this.testPaperList = res.data.content;
          this.total = parseInt(res.data.total);
          this.loading = false
        });
      }, 500);
    },

    //去创建新试卷
    createTestPaper() {
      const {href} = this.$router.resolve({
        name: "createExam",
        params: {type: 'add'}
      });
      window.open(href, "_blank");
    },

    // 发布试卷
    releaseTest(examId, examName) {
      this.$refs.releaseTestDialog.releaseTest(examId, examName)
    },

    // 编辑试卷
    editTestPaper(tp_id) {
      const {href} = this.$router.resolve({
        name: "editExam",
        params: {type: 'edit', tp_id}
      });
      window.open(href, "_blank");
    },

    //删除试卷
    deleteTest(tp_id) {
      this.$confirm("确认要删除吗,删除后无法恢复哦", "确认框", {type: "warning"}).then(() => {
        const params = {
          examId: tp_id
        }
        this.$http.get("/deletePaper", {params}).then((res) => {
          if (res.code === 200){
            this.$message.success(res.msg);
            this.getTestPaperList();
          }else {
            this.$message.error(res.msg);
          }
        })
      })
    },

    //切换分页时触发
    currentChange(val) {
      this.currentPage = val;
      this.getTestPaperList();
    },
  },
};
</script>

<style lang="less" scoped>
.myTest {
  .tab-item {
    padding: 10px 20px;
  }

  .table {
    margin-top: 24px;
  }

  .releaseTest .el-dialog {
    .el-dialog__header {
      text-align: center;
      font-size: 16px;
    }

    .el-dialog__body {
      padding-top: 0px;
      padding-bottom: 0px;
      text-align: center;
    }

    .pagination {
      text-align: center;
    }

    .el-date-editor {
      margin: 38px 0px;
    }
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

  .create {
    background: #4788cc;
    color: #fff;
    border-color: #f6f6f6;
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
