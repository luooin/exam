<template>
  <div class="classesSpace">
    <div class="classesInfo" v-loading="loading">
      <div class="tital">
        <h2>C{{ classesData.classesId }}&nbsp;&nbsp; {{ classesData.classesName }} </h2>
        <span
            v-if="$role('teacher')"
            class="editClasses"
            @click="editClasses">
          修改班级信息
          <i class="el-icon-edit"></i></span>
      </div>

      <div class="details">
        <ul>
          <li class="item"><span class="key">创建时间：</span> {{ classesData.createDate }}</li>
          <li class="item"><span class="key">创建者：</span> {{ classesData.creatorName }}</li>
          <li class="item"><span class="key">班级人数：</span> {{ classesData.peopleNum }} 人</li>
        </ul>
        <div class="title">
          <span class="key">班级简介：</span>{{ classesData.introduction }}
        </div>
      </div>
    </div>

    <div class="tab-classes">
      <span :class="tab_classes==='examination_list'?'active':''" @click="examList()">班级考试</span>
      <span :class="tab_classes==='user_list'?'active':''" @click="userList()">班级成员</span>
      <span :class="tab_classes==='subject_list'?'active':''" @click="subjectList()">班级课程</span>
    </div>

    <!-- 班级考试信息表格 -->
    <div class="test_list table" v-if="tab_classes==='examination_list'">
      <el-table :data="TestData" style="width: 100%" v-loading="loading">
        <el-table-column label="考试编号" width="110">
          <template slot-scope="scope">E{{ scope.row.examId }}</template>
        </el-table-column>
        <el-table-column prop="examName" label="考试名称"></el-table-column>
        <el-table-column label="考试时间" width="350">
          <template slot-scope="scope">{{ scope.row.startDate }} 至 {{ scope.row.deadline }}</template>
        </el-table-column>
        <el-table-column label="考试科目" width="120">
          <template slot-scope="scope">{{ scope.row.subjectName }}</template>
        </el-table-column>
        <el-table-column label="答题时间" width="100">
          <template slot-scope="scope">{{ scope.row.time }} 分钟</template>
        </el-table-column>
        <el-table-column label="总分" width="100">
          <template slot-scope="scope">{{ scope.row.totalScore }} 分</template>
        </el-table-column>
        <el-table-column label="是否公布答案" width="120" v-if="$role('teacher')">
          <template slot-scope="scope">{{ scope.row.publishAnswer == 1 ? '是' : '否' }}</template>
        </el-table-column>
        <el-table-column label="是否公布分数" width="120" v-if="$role('teacher')">
          <template slot-scope="scope">{{ scope.row.publishScore == 1 ? '是' : '否' }}</template>
        </el-table-column>
        <el-table-column prop="grade" label="分数" width="100" v-if="$role('student')"></el-table-column>
        <el-table-column prop="status" label="状态" width="80"></el-table-column>
        <el-table-column prop="operate" label="操作" :width="$role('teacher')?'300':'150'">
          <template slot-scope="scope">
            <div v-if="$role('teacher')">
              <el-button type="primary" size="small" @click="testSituation(scope.row.examId)" plain>查看考试情况
              </el-button>
              <el-button type="info" size="small" @click="changeTestDate(scope.row)" plain>设置</el-button>
              <el-button type="danger" size="small" @click="cancelRelease(scope.row.examId)" plain>取消发布</el-button>
            </div>
            <div v-if="$role('student')">
              <el-button type="primary" size="small" v-if="scope.row.status!='未开始'" @click="openTestPaper(scope.row)"
                         plain>
                {{ scope.row.status == '进行中' ? '开始考试' : '' }}
                {{ scope.row.status == '已结束' ? '查看试卷' : '' }}
                {{ scope.row.status == '答题完毕' ? '查看试卷' : '' }}
              </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 其他班级成员表格 -->
    <div class="user_list table" v-if="tab_classes==='user_list'">
      <el-button
          v-if="$role('teacher')"
          round @click="openAddUser()">
        增加学生
      </el-button>
      <el-table :data="userData" style="width: 100%;margin-top: 20px" v-loading="loading">
        <el-table-column label="用户id">
          <template slot-scope="scope">U{{ scope.row.userId }}</template>
        </el-table-column>
        <el-table-column prop="userName" label="成员名称"></el-table-column>
        <el-table-column label="加入时间">
          <template slot-scope="scope">{{ scope.row.enterDate }}</template>
        </el-table-column>
        <el-table-column label="身份">
          <template slot-scope="scope">{{ scope.row.position }}</template>
        </el-table-column>
        <el-table-column
            v-if="$role('teacher')"
            prop="operate"
            label="操作"
            width="300">
          <template slot-scope="scope" v-if="tab_classes=='user_list'">
            <!--            <el-button type="primary" size="small" @click="openPaper(scope.row.classesId, scope.row.classes.name)" plain>查看该学生的考试记录</el-button>-->
            <el-button type="danger" size="small" @click="outUser(scope.row.userId)" plain>踢出班级</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 班级课程 -->
    <div class="table" v-if="tab_classes==='subject_list'">
      <el-transfer
          v-model="value"
          filterable
          :titles="['可选课程', '已选课程']"
          :data="data"
          style="text-align: left; display: inline-block"
          @change="handleChange"
      >
      </el-transfer>
    </div>

    <div
        v-if="tab_classes!=='subject_list'"
        class="page">
      <el-pagination
          background
          layout="total, prev, pager, next,jumper"
          @current-change="currentChange"
          :current-page.sync="currentPage"
          :total="total"
          :page-size="pageSize"/>
    </div>

    <!-- 修改试卷发布设置 -->
    <ReleaseUpdate ref="releaseUpdate" @success="getClassesTestPaper()"/>

    <!-- 修改班级 -->
    <EditClasses ref="EditClasses" @success="getClassesData()"/>

    <el-dialog
        class="releaseTest"
        :title="'请选择学生信息'"
        :visible.sync="this.addUserLoading"
        width="56%"
        @close="closeAddUserLoading()">
      <el-table
          ref="multipleTable"
          :data="userNoClassesList"
          tooltip-effect="dark"
          style="width: 100%"
          @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"/>
        <el-table-column label="用户名" width="110">
          <template slot-scope="scope">{{ scope.row.userName }}</template>
        </el-table-column>
        <el-table-column prop="sex" label="性别" width="50">
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
      </el-table>

      <div slot="footer" class="dialog-footer">
        <el-button @click="closeAddUserLoading">取 消</el-button>
        <el-button type="primary" @click="addUserToClasses()">确定添加</el-button>
      </div>

    </el-dialog>

  </div>
</template>

<script>
import ReleaseUpdate from "./components/ReleaseUpdate";
import EditClasses from './components/EditClasses'
import {mapState} from "vuex";


export default {
  name: "ClassesSpace",
  components: {ReleaseUpdate, EditClasses},
  computed: {
    ...mapState(['userRole'])
  },
  watch: {
    //监听params参数的变化
    $route: {
      handler() {
        this.Classes_id = this.$route.params.id;
        this.getClassesData();
      },
      deep: true,
    },
  },
  data() {
    return {
      Classes_id: "班级不存在",

      // 当前班级数据
      classesData: {},
      // 试卷信息数据
      TestData: [],
      // 班级其他成员数据
      userData: [],
      // 班级所选科目数据
      data: [],
      value: [],

      tab_classes: "examination_list",

      // 分页
      currentPage: 1,
      pageSize: 10,
      total: null,
      loading: false,

      // 增加班级弹窗tap
      addUserLoading: false,
      // 学生信息
      userNoClassesList: [],
      // 已选择的用户
      selectionUser: [],
    };
  },
  async mounted() {
    this.Classes_id = this.$route.params.id;
    await this.getClassesData();
    await this.getClassesTestPaper();
  },

  methods: {
    // 打开添加学生弹窗
    openAddUser() {
      this.addUserLoading = true;
      this.getUserNoClasses()
    },
    // 关闭添加学生弹窗
    closeAddUserLoading() {
      this.addUserLoading = false;
      this.selectionUser = [];
    },

    // 查询所有没有加入班级的学生信息
    getUserNoClasses() {
      this.$http.get("/user/getUserNoClasses", {}).then((res) => {
        this.userNoClassesList = res.data;
      })
    },

    handleSelectionChange(val) {
      this.selectionUser = val.map(item => item.userId);
    },

    addUserToClasses() {
      let params = {
        classesId: this.Classes_id,
        userIds: this.selectionUser.join(',')
      }
      this.$http.get("/classes/userAddClasses", {params}).then((res) => {
        if (res.data) {
          this.closeAddUserLoading();
          this.$message.success("分配成功");
        }
        this.getClassesMembers();
      });
    },

    //获取班级信息
    getClassesData() {
      this.loading = true
      let params = {
        classesId: this.$route.params.id,
      };
      setTimeout(() => {
        this.$http.get("/queryClasses", {params}).then((res) => {
          this.classesData = res.data;
          this.loading = false
        });
      }, 400);

    },

    //获取班级成员信息
    getClassesMembers() {
      this.loading = true
      let params = {
        c_id: this.$route.params.id,
        pageSize: this.pageSize,
        currentPage: this.currentPage,
      };
      setTimeout(() => {
        this.$http.get("/queryUserByC_id", {params}).then((res) => {
          if (res.code === 200) {
            //去除创建人的数据
            this.userData = res.data.content;
            this.total = res.data.total
          }
          this.loading = false
        });
      }, 500);

    },

    //获取班级试卷信息
    getClassesTestPaper() {
      this.loading = true
      let params = {
        classesId: this.$route.params.id,
        pageSize: this.pageSize,
        currentPage: this.currentPage,
      };
      setTimeout(() => {
        this.$http.get("/getExamByClasses", {params}).then((res) => {
          if (res.code === 200) {
            const data = res.data.content;
            //处理数据
            for (let i = 0; i < data.length; i++) {
              //判断是否已答题完毕
              if (data[i].examStatus === 1) {
                //判断是否公开成绩
                if (data[i].publishScore === 1) {
                  data[i].grade += "分";
                } else {
                  data[i].grade = "--";
                }

                data[i].status = "答题完毕";
              } else {
                data[i].status = "进行中";
                data[i].grade = "--";
              }

              //判断考试是否结束
              const nowDate = new Date().getTime();
              const deadlineTime = new Date(data[i].deadline).getTime();
              const startDateTime = new Date(data[i].startDate).getTime();
              if (nowDate > deadlineTime) {
                data[i].status = "已结束";
              }
              if (nowDate < startDateTime) {
                data[i].status = "未开始";
              }
            }

            this.TestData = data;
            this.total = res.data.total
            this.loading = false
          }
        });
      }, 500);
    },

    examList() {
      this.tab_classes = "examination_list";
      this.currentPage = 1
      this.getClassesTestPaper()
    },

    userList() {
      this.tab_classes = "user_list";
      this.currentPage = 1
      this.getClassesMembers()
    },

    subjectList() {
      this.tab_classes = "subject_list";
      this.currentPage = 1
      this.getSubjectMembers()
    },

    getSubjectMembers() {
      let params = {
        classesId: this.$route.params.id,
      };
      setTimeout(() => {
        this.$http.get("/subject/findSubjectsByClassesId", {params}).then((res) => {
          if (res.code === 200) {
            this.data = res.data.map(item => {
              return {
                key: item.subjectsId,
                label: item.subjectsName,
              }
            })
            this.value = res.data
                .filter(item => item.isHave)
                .map(item => {
                  return item.subjectsId;
                })
          }
        });
      }, 800);
    },

    handleChange(value, direction, movedKeys) {
      if (this.userRole === 'student') {
        this.$message.error("只有教师可以设置哦，如果有需要请联系教师");
        this.getSubjectMembers();
        return;
      }
      let isJoin = false;
      if (direction === 'right') {
        // 向右移动 将当前课程加入当前班级
        isJoin = true;
      }
      let params = {
        classesId: this.$route.params.id,
        subjectsDataList: movedKeys.join(','),
        isJoin: isJoin
      };
      setTimeout(() => {
        this.$http.get("/subject/updateByClassesId", {params}).then((res) => {
          if (res.data) {
            this.$message.success("修改成功");
          }
        });
      }, 500);
      this.getSubjectMembers();
    },

    //修改班级信息
    editClasses() {
      this.$refs.EditClasses.dialog = true
      console.log(this.classesData);
      this.$refs.EditClasses.editClassesData = JSON.parse(JSON.stringify(this.classesData))
    },

    //把学生踢出班级
    outUser(u_id) {
      this.$confirm(" 这将会删除他所有与班级有关的信息", "是否确定删除学生?", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
      })
          .then(() => {
            // 处理post请求参数
            const params = {
              u_id: u_id,
              c_id: this.classesData.classesId,
            };
            this.$http.delete("/outClassesByTeacher", {params}).then((res) => {
              if (res.code == 200) {
                this.$message({message: "删除学生成功", type: "success"});
                this.getClassesMembers();
              }
            });
          })
          .catch(() => {
          });
    },

    //更改考试设置
    changeTestDate(val) {
      this.$refs.releaseUpdate.changeTestDate(val, this.classesData.classesId);
    },

    // 查看考试情况
    testSituation(tp_id) {
      this.$router.push({
        path: "/main/classes/testSituation",
        query: {cId: this.Classes_id, tpId: tp_id},
      });
    },

    // 取消发布
    cancelRelease(tp_id) {
      this.$confirm("此操作将删除试卷在该班级的所有信息, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
      })
          .then(() => {
            var params = {
              tp_id,
              c_id: this.classesData.classesId,
            };
            this.$http.delete("/cancelRelease", {params}).then((res) => {
              if (res.code == 200) {
                this.getClassesTestPaper();
                this.$message.success("已取消发布");
              }
            });
          })
          .catch(() => {
          });
    },

    //开始考试
    openTestPaper(val) {
      var {href} = this.$router.resolve({
        name: "TestPaperStu",
        params: {
          tp_id: val.examId,
          c_id: this.classesData.classesId,
        },
      });
      window.open(href, "_blank");
    },

    //切换分页时触发
    currentChange(val) {
      this.currentPage = val;
      switch (this.tab_classes) {
        case 'examination_list':
          this.getClassesTestPaper();
          break
        case 'user_list':
          this.getClassesMembers();
          break
      }
    },

  },


};
</script>

<style lang="less" scoped>
.classesSpace {
  padding: 10px 20px;

  .tab-classes {
    margin-left: 20px;
    margin-bottom: 10px;

    span {
      padding: 0 20px;
      font-size: 14px;
      cursor: pointer;
      border-right: 1px solid #333;
    }

    span:last-child {
      border: none;
    }

    span.active {
      font-size: 16px;
      font-weight: bold;
    }
  }

  .classesInfo {
    padding: 12px 24px;
    margin-bottom: 24px;
    border-radius: 4px;
    background: #fafafa;
    display: flex;

    .tital {
      width: 30%;

      h2 {
        margin-bottom: 10px;
      }

      .editClasses {
        cursor: pointer;
      }
    }

    .details {
      width: 70%;
    }

    ul {
      margin: 12px 0 16px;
      display: flex;
      align-items: center;
    }

    ul li {
      padding-right: 24px;
    }

    span.key {
      color: #606266;
    }
  }
}

/deep/ .el-transfer-panel {
  width: 470px; /* 左右两个穿梭框的高度和宽度 */
  height: 450px;
}

/deep/ .el-transfer-panel__list.is-filterable {
  height: 303px; /* 穿梭框列表高度 */
}
</style>
