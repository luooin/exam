<template>
  <div class="home">
    <TopTab title="首页">
      <el-card style="min-height: calc(100vh - 80px);width: 100%;height: 100%">

        <!--   教师   -->
        <div v-if="$role('teacher')">
          <div>
            <el-row :gutter="20" class="topInfo">
              <el-col :span="6">
                <div id="stuNumDiv" class="el-colDiv">
                  <div id="ssv1-main-text" class="nowDiv">实时</div>
                  <span class="title">班级数量</span><br/>
                  <span class="digital">{{ this.homeData.classesCount }}个</span><br/>
                  <span class="last-span">当前分类总记录数</span>
                </div>
              </el-col>
              <el-col :span="6">
                <div id="haveRoomDiv" class="el-colDiv">
                  <div id="ssv2-main-text" class="nowDiv">实时</div>
                  <span class="title">学生人数</span><br/>
                  <span class="digital">{{ this.homeData.userCount }}位</span><br/>
                  <span class="last-span">当前分类总记录数</span>
                </div>
              </el-col>
              <el-col :span="6">
                <div id="repairNum" class="el-colDiv">
                  <div id="ssv3-main-text" class="nowDiv">实时</div>
                  <span class="title">科目统计</span><br/>
                  <span class="digital">{{ this.homeData.subjectCount }}科</span><br/>
                  <span class="last-span">当前分类总记录数</span>
                </div>
              </el-col>
              <el-col :span="6">
                <div id="emptyRoom" class="el-colDiv">
                  <div id="ssv4-main-text" class="nowDiv">实时</div>
                  <span class="title">试卷统计</span><br/>
                  <span class="digital">{{ this.homeData.examCount }}套</span><br/>
                  <span class="last-span">当前分类总记录数</span>
                </div>
              </el-col>
            </el-row>
          </div>
          <div>
            <el-row>
              <!--    日历组件-->
              <el-col :span="8">
                <el-card style="width: 330px; max-height: 440px;margin-left: 15px">
                  <calendar/>
                </el-card>
              </el-col>
              <el-col :span="8">
              </el-col>
            </el-row>
          </div>
        </div>

        <!--   学生   -->
        <div v-if="$role('student')">
          <el-row :gutter="20" class="topInfo">
            <el-col>
              <div style="background-color: #2b4450" class="el-colDiv2">
                <span v-if="this.homeData.classesName" class="title">
                  您的班级是:{{ this.homeData.classesName }}班
                  <span style="margin-left: 20px">
                    班级人数为:{{ this.homeData.classesNumber }}位
                  </span>
                </span>
                <span v-else class="title">您还没有班级,快联系教师加入吧~</span>
              </div>
            </el-col>

            <el-col :span="8">
              <el-card style="width: 330px; max-height: 440px;">
                <calendar/>
              </el-card>
            </el-col>
            <el-col :span="8">
            </el-col>

          </el-row>

        </div>
      </el-card>
    </TopTab>

  </div>
</template>

<script>
import TopTab from "../../components/TopTab.vue";
import "../../assets/less/main/home.less";
import weather from "@/views/components/weather";
import calendar from "@/views/components/Calendar";


export default {
  name: "Home",
  components: {TopTab, weather, calendar},
  data() {
    return {
      homeData: {}
    };
  },
  created() {
    this.getHomeData();
  },
  methods: {
    getHomeData() {
      this.$http.get('/home/data')
          .then(res => {
            this.homeData = res.data;
          })
    },
  },
};
</script>

<style>

.topInfo {
  margin: 0 auto;
}

.el-colDiv {
  margin: 20px auto;
  max-width: 340px;
  min-width: 200px;
  overflow: hidden;
  height: 115px;
  border-radius: 5px;
  background-color: black;
  color: white;
  padding-left: 15px;
  padding-top: 15px;
  position: relative;
}

.el-colDiv2 {
  margin: 20px auto;
  max-width: 100%;
  min-width: 100%;
  overflow: hidden;
  height: 40px;
  border-radius: 5px;
  background-color: black;
  color: white;
  padding-left: 15px;
  padding-top: 15px;
  position: relative;
}

.nowDiv {
  width: 38px;
  height: 19px;
  position: absolute;
  right: 5%;
  font-size: 15px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 3px;
}

.digital {
  font-size: 25px;
  line-height: normal;
  margin-left: 2px;
}

.title {
  font-size: 18px;
}

.last-span {
  font-size: 13px;
}

#stuNumDiv {
  background-color: #2e4057;
}

#ssv1-main-text {
  background-color: #1398ff;
}

#haveRoomDiv {
  background-color: #1398ff;
}

#ssv2-main-text {
  background-color: #2e4057;
}

#repairNum {
  background-color: #008789;
}

#ssv3-main-text {
  background-color: #ffb400;
}

#emptyRoom {
  background-color: #ffb400;
}

#ssv4-main-text {
  background-color: #008789;
}
</style>
