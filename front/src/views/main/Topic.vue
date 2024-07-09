<template>
  <div class="myTest content-bg ">
    <div class="tab-title">
      <div class="tabTitle-item active">用户管理</div>
    </div>
    <div class="tab-item">
      <div class="list-header">
        <span class="list-title">用户信息管理</span>
        <el-button type="primary" size="medium" icon="el-icon-plus" @click="saveOrUpdate(0)" class="create">新建用户
        </el-button>
        <div class="query">
          <el-input v-model="keyword" size="small" placeholder="请输入姓名"
                    prefix-icon="el-icon-search"></el-input>
          <el-button type="primary" size="small" @click="getTestPaperList(keyword)">查询</el-button>
        </div>
      </div>

      <div class="table">
        <el-table :data="testPaperList" item style="width: 100%" v-loading="loading">
          <el-table-column label="用户名" width="110">
            <template slot-scope="scope">{{ scope.row.userName }}</template>
          </el-table-column>
          <el-table-column label="密码" min-width="110">
            <template slot-scope="scope">{{ scope.row.password }}</template>
          </el-table-column>
          <el-table-column prop="sex" label="性别" width="50">
          </el-table-column>
          <el-table-column label="班级" min-width="110">
            <template slot-scope="scope">
              <span v-if="scope.row.classesName">{{ scope.row.classesName }}班</span>
              <span v-if="scope.row.role === 'teacher'">无需班级</span>
              <span v-if="!scope.row.classesName && scope.row.role !== 'teacher'">暂无班级</span>
            </template>
          </el-table-column>
          <el-table-column label="头像" width="150">
            <template slot-scope="scope">
              <img :src='scope.row.photo' class="avatar" alt="" width="70%">
            </template>
          </el-table-column>
          <el-table-column label="电话" width="150">
            <template slot-scope="scope">{{ scope.row.phone }}</template>
          </el-table-column>
          <el-table-column label="邮箱" width="180">
            <template slot-scope="scope">{{ scope.row.email }}</template>
          </el-table-column>
          <el-table-column label="角色" width="150">
            <template slot-scope="scope">{{ scope.row.role === 'teacher' ? '教师' : '学生' }}</template>
          </el-table-column>
          <el-table-column prop="enter_date" label="更新时间" width="240">
            <template slot-scope="scope">
              <i class="el-icon-time"></i>
              <span style="margin-left: 10px">{{ scope.row.createDate }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="240" fixed="right">
            <template slot-scope="scope">
              <el-button v type="info" size="mini" plain
                         @click="saveOrUpdate(scope.row.userId)">编辑
              </el-button>
              <el-button v type="success" size="mini" plain
                         v-if="!scope.row.classesName && scope.row.role !== 'teacher'"
                         @click="openDominate(scope.row.userId)">分配班级
              </el-button>
              <el-button type="danger" size="mini" plain
                         @click="deleteTest(scope.row.userId)">删除
              </el-button>
            </template>
          </el-table-column>

        </el-table>
      </div>

      <div class="page">
        <el-pagination background layout="total, prev, pager, next,jumper" @current-change="currentChange"
                       :total="total" :page-size="pageSize"/>
      </div>

      <TopicClass ref="topicClass" @success="getTestPaperList()"/>

      <el-dialog :title=" '分配班级' " :visible.sync="dominate" width="32%">
        <el-form label-position="right" :model="classOptions" status-icon label-width="auto" ref="editClassesForm">
          <el-form-item label="请选择班级">
            <el-select v-model="classesId" placeholder="请选择" size="small">
              <el-option
                  v-for="item in classOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"/>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="close()">取 消</el-button>
          <el-button type="primary" @click="saveUserClasses()">确 定</el-button>
        </div>
      </el-dialog>

    </div>
  </div>
</template>

<script>
import "../../assets/less/my_tab.less";
import TopicClass from "./TopicSvaOrUpdate"

export default {
  name: "MyTest",
  components: {TopicClass},
  data() {
    return {
      // 是否教师
      loading: true,
      testPaperList: [],
      // 分页
      currentPage: 1,
      pageSize: 10,
      total: null,
      keyword: '',

      // 班级选择
      classOptions: [],

      // 是否打开分配班级弹窗
      dominate: false,
      // 当前分配班级userId
      userIdDominate: 0,
      // 当前分配的班级id
      classesId: ''
    };
  },

  created() {
    this.getTestPaperList();

  },

  methods: {
    close() {
      this.dominate = false;
      this.classesId = '';
      this.userIdDominate = 0;
    },
    // 给用户分配班级
    saveUserClasses() {
      if (!this.classesId) {
        this.$message.error("请选择班级");
        return;
      }
      let params = {
        classesId: this.classesId,
        userIds: this.userIdDominate
      }
      this.$http.get("/classes/userAddClasses", {params}).then((res) => {
        if (res.data) {
          this.$message.success("分配成功");
          this.close();
        }
        this.getTestPaperList();
      });
    },

    // 打开分配班级弹窗
    openDominate(userId) {
      this.userIdDominate = userId;
      this.getClass();
      this.dominate = true;
    },

    getClass() {
      this.$http.get("/classes/findAll", {}).then((res) => {
        console.log(res)
        this.classOptions = res.data.map(item => {
          return {
            value: item.classesId,
            label: item.classesName
          }
        })
      });
    },

    // 新增或者编辑
    saveOrUpdate(row) {
      this.$refs.topicClass.dialog = true;
      this.$refs.topicClass.user = {
        photo: 'http://localhost:8081/images/user.jpg',
        role: 'student',
        sex: '男'
      };
      this.$refs.topicClass.getClass();
      if (row > 0) {
        this.$refs.topicClass.userId = row;
        this.$refs.topicClass.getUser();
        this.$refs.topicClass.isSave = false;
      }
    },
    // 获取所有用户列表
    getTestPaperList(val = '') {
      this.loading = true
      let params = {
        pageSize: this.pageSize,
        currentPage: this.currentPage,
        username: val
      };
      // 定时器
      setTimeout(() => {
        this.$http.get("/queryUserList", {params}).then((res) => {
          this.testPaperList = res.data.content;
          this.total = parseInt(res.data.total);
          this.loading = false
        });
      }, 500);
    },


    // 删除用户
    deleteTest(userId) {
      this.$confirm("确认要删除该用户吗,删除后无法恢复哦", "确认框", {type: "warning"}).then(() => {
        const params = {
          userId: userId
        }
        this.$http.get("/deleteByUserId", {params}).then((res) => {
          if (res.code === 200) {
            this.$message.success(res.msg);
            this.getTestPaperList();
          } else {
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
