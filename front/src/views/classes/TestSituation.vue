<template>
  <div class="testSituation">
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/main/classes/classesList' }">我的班级</el-breadcrumb-item>
      <el-breadcrumb-item><a @click="$router.go(-1)">{{releaseInfo.classesName}}</a></el-breadcrumb-item>
      <el-breadcrumb-item>{{releaseInfo.examName}}</el-breadcrumb-item>
      <el-breadcrumb-item>查看考试情况</el-breadcrumb-item>
    </el-breadcrumb>

    <div class="list-header" v-loading="loading">
      <div class="classesGrade">
        <div class="tital">
          <h2>C{{ releaseInfo.examId }}&nbsp;&nbsp; {{ releaseInfo.examName }} </h2>
        </div>
        <div class="details">
          <ul>
            <li class="item"> <span class="key">考试时间：</span>{{ releaseInfo.startDate + ' 至 ' + releaseInfo.deadline }} </li>
            <li class="item"> <span class="key">公布答案：</span>{{ releaseInfo.publishAnswer ? '是':'否' }} </li>
            <li class="item"> <span class="key">公布分数：</span>{{ releaseInfo.publishScore ? '是':'否' }}</li>
            <li class="item"> <span class="key">及格分数：</span>{{ releaseInfo.passMark }}</li>
          </ul>
          <ul>
            <li class="item"> <span class="key">试卷提交情况：</span>{{ commitNumber }} / {{ userGradeList.length }}</li>
            <li class="item"> <span class="key">批改进度：</span>{{ markNumber }} / {{ userGradeList.length }}</li>
            <li class="item"> <span class="key">平均分：</span>{{ releaseInfo.average }}</li>
            <li class="item"> <span class="key">合格率：</span>{{ releaseInfo.passRate }}%</li>
          </ul>
        </div>
      </div>
      <div class="charts">
        <!-- <div id="myChart" :style="{width: '400px', height: '300px'}"></div>
        <div id="myChart2" :style="{width: '300px', height: '200px'}"></div> -->
      </div>
    </div>

    <!-- 班级成员考试情况表格 -->
    <div class="user_list table">
      <el-table :data="userGradeList" style="width: 100%" v-loading="loading">
        <el-table-column label="用户id">
          <template slot-scope="scope">U{{scope.row.userId}} </template>
        </el-table-column>
        <el-table-column prop="userName" label="成员名称"> </el-table-column>
        <el-table-column prop="answerDate" label="答题日期" width="184"> </el-table-column>
        <el-table-column prop="answerTime" label="答题用时">
          <template slot-scope="scope">{{scope.row.answerTime | formatSeconds}} </template>
        </el-table-column>
        <el-table-column label="答题状态">
          <template slot-scope="scope">{{scope.row.examStatus == 1? '已完成':'未完成'}} </template>
        </el-table-column>
        <el-table-column prop="grade" label="得分"> </el-table-column>
        <el-table-column prop="gradeAuto" label="自动评改得分"> </el-table-column>
        <el-table-column label="批改状态">
          <template slot-scope="scope">{{scope.row.markStatus == 1? '批改完成':'待批改'}} </template>
        </el-table-column>
        <el-table-column prop="operate" label="操作" width="300">
          <template slot-scope="scope">
            <el-button type="primary" size="small" v-if="scope.row.examStatus == 1" @click="openPaper(scope.row.classesId, scope.row.userId,scope.row.examId)" plain>
               {{scope.row.markStatus == 1 ? '查看试卷':'审批试卷'}}
              审批试卷
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="page">
      <el-pagination background layout="total, prev, pager, next,jumper" @current-change="currentChange" :total="total" :page-size="pageSize" />
    </div>
  </div>
</template>

<script>
// 引入基本模板
let echarts = require("echarts/lib/echarts");

export default {
  name: "TestSituation",
  data() {
    return {
      classesId: this.$route.query.cId,
      examId: this.$route.query.tpId,
      userGradeList: [],
      releaseInfo: {},

      commitNumber: 0, // 完成人数
      markNumber: 0, // 批改完成人数


      //分页
      currentPage: 1,
      pageSize: 10,
      total: null,

      loading: false,
    };
  },
  computed: {

  },
  async mounted() {
    await this.getReleaseInfo();
    await this.getUserGradeList();
    // this.drawLine();
    // this.drawLine2();
  },
  methods: {
    drawLine() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = echarts.init(document.getElementById("myChart"));
      // 绘制图表
      myChart.setOption({
        color: ['#5197dc'],
        title: {},
        tooltip: {},
        xAxis: {
          data: ["未完成","不及格", "及格", "良好", "优秀"],
        },
        yAxis: {},
        series: [
          {
            name: "人数",
            type: "bar",
            data: [22,5, 20, 36, 10],
          },
        ],
      });
    },
    drawLine2() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = echarts.init(document.getElementById("myChart2"));
      // 绘制图表
      myChart.setOption({
        tooltip: {
          trigger: "item",
        },
        legend: {
          top: "0%",
          left: "center",
        },
        series: [
          {
            name: "人数",
            type: "pie",
            radius: ["40%", "70%"],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: "#fff",
              borderWidth: 2,
            },
            label: {
              show: false,
              position: "center",
            },
            emphasis: {
              label: {
                show: true,
                fontSize: "20",
                fontWeight: "bold",
              },
            },
            labelLine: {
              show: false,
            },
            data: [
              { value: 1048, name: "及格" },
              { value: 735, name: "不及格" },
              { value: 580, name: "未完成" },
            ],
          },
        ],
      });
    },
    getUserGradeList() {
      this.loading = true;
      let params = {
        classesId: this.classesId,
        examId: this.examId,
        pageSize: this.pageSize,
        currentPage: this.currentPage,
      };
      setTimeout(() => {
        this.$http.get("/getUserGradeList", { params }).then((res) => {
          if (res.code == 200) {
            this.userGradeList = res.data.content;
            this.total = res.data.total;
            this.loading = false;

            this.userGradeList.map((t) => {
              if (t.examStatus === 1) this.commitNumber++;
              if (t.markStatus === 1) this.markNumber++;
            });
          }
        });
      }, 500);
    },

    // 获取试卷发布信息
    getReleaseInfo() {
      let params = {
        classesId: this.classesId,
        examId: this.examId,
      };
      this.$http.get("/getReleaseInfo", { params }).then((res) => {
        if (res.code == 200) {
          res.data.average = res.data.average.toFixed(1)
          res.data.passRate = res.data.passRate.toFixed(2)
          this.releaseInfo = res.data;
        }
      });
    },

    // 批改试卷
    openPaper(classesId, userId, examId) {
      let { href } = this.$router.resolve({
        path: "/markTestPaper",
        query: { cId: classesId, eId: examId, uId: userId },
      });
      console.log(href);
      window.open(href, "_blank");
    },

    //切换分页时触发
    currentChange(val) {
      this.currentPage = val;
      this.getUserGradeList();
    },
  },
};
</script>

<style lang="less" scoped>
.testSituation {
  padding: 24px;

  .el-breadcrumb {
    font-size: 16px;
    padding: 0 16px 16px 16px;
  }

  .list-header {
    margin-bottom: 24px;
    background: #fafafa;
  }
  .list-header .classesGrade {
    padding: 0 24px;
    display: flex;

    .tital {
      width: 30%;
      margin-top: 12px;
    }
    .details {
      width: 70%;
      padding-top: 12px;
    }

    ul {
      margin: 12px 0 16px;
      display: flex;
      align-items: center;
    }
    ul li {
      padding-right: 24px;
    }
    ul li.item .key {
      color: #606266;
    }
  }
  .list-header .charts {
    display: flex;
    justify-content: space-between;
    padding: 0 24px;
  }
}
</style>
