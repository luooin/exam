!<template>
  <div class="markTestPaper testPaper">
    <div class="w">
      <!-- 考试信息 -->
      <div class="title">
        <h3 class="testName">{{ testData.examName }}</h3>
        <ul>
          <li class="test-info">试卷Id: {{ testData.examId }}</li>
          <li class="test-info">出卷者: {{testData.creatorName}}</li>
          <li class="test-info">答题时间: {{ testData.time }} 分钟</li>
          <li class="test-info">截至时间: {{ testData.examClasses.deadline }}</li>
          <li class="test-info">题目数量: 共 {{ testData.topicNum }} 道</li>
          <li class="test-info">总分: {{ testData.totalScore }} 分</li>
        </ul>

        <ul>
          <li class="user-info">所属班级: {{ testData.examClasses.classesName }}</li>
          <li class="user-info">答题人: {{ testData.userGrade.userName }}</li>
          <li class="user-info">答题人Id: U{{ testData.userGrade.userId }}</li>
          <li class="user-info">自动评改得分: {{ testData.userGrade.gradeAuto }} 分</li>
          <li class="user-info">最终得分: {{ testData.userGrade.grade }} 分</li>
          <li class="fr">
            <el-button type="primary" size="mini" @click="submitTestpaper" >提交试卷</el-button>
          </li>
        </ul>
      </div>

      <div class="title fixed" v-if="isFixed">
        <ul>
          <li class="test-info"><strong class="testName">{{ testData.name }}</strong></li>
          <li class="test-info">总分: {{ testData.totalScore }} 分</li>
          <li class="test-info">答题人: {{ testData.userGrade.userName }}</li>
          <li class="test-info">最终得分: {{ testData.userGrade.grade }} 分</li>
          <li class="fr">
            <el-button type="primary" size="mini" @click="submitTestpaper" >提交试卷</el-button>
          </li>
        </ul>
      </div>

      <div class="test-content">
        <!-- 题目内容 -->
        <div class="topics">
          <div class="topic" v-for="(topics, index) in sortedTopics" :key="index">

            <div class="topicsType" v-if="topics.topic_content.length != 0 ">
              <h4>{{bigQuestionName_mixin(topics.topic_type,index)}}</h4><!-- 题目类型名称 -->
              <ul>
                <li class="topic-content" v-for="(t, index) in topics.topic_content" :key="index">
                  <div class="_location"></div>
                  <!-- 题目 -->
                  <div class="left">
                    <div class="question">
                      <span class="question_nunber">{{ topicNavIndex_mixin(topics.topic_type,index) }}、</span>
                      {{ t.question }}
                      <span class="score">({{ t.score }}分)</span>
                    </div>

                    <!-- 单选题 -->
                    <div class="radio" v-if="t.topicType==0">
                      <el-radio v-for="(item, index) in t.choice" :key="index"
                      :class="item == t.correctAnswer? 'correct':'error'"
                      v-model="t.userAnswer"
                      :label="item"
                      :disabled="isRead">
                        {{String.fromCharCode(65+index)}}、{{ item }}
                      </el-radio>
                    </div>

                    <!-- 多选题 -->
                    <div class="checkbox" v-if="t.topicType == 1">
                      <el-checkbox-group v-model="t.userAnswer">
                        <el-checkbox :label="item" v-for="(item, index) in t.choice" :key="index"
                        :disabled="isRead"
                        :class="isCheckboxCorrect(t,item)" >
                          {{String.fromCharCode(65+index)}}、{{ item }}
                        </el-checkbox>
                      </el-checkbox-group>
                    </div>

                    <!-- 判断题 -->
                    <div class="TrueOrFalse" v-if="t.topicType == 2">
                      <el-radio v-model="t.userAnswer" label="true" :class="'true' == t.correctAnswer? 'correct':'error'" :disabled="isRead">正确</el-radio>
                      <el-radio v-model="t.userAnswer" label="false" :class="'false' == t.correctAnswer? 'correct':'error'" :disabled="isRead">错误</el-radio>
                    </div>

                    <!-- 填空题 -->
                    <div class="fillInBlank" v-if="t.topicType == 3">
                      <div v-for="(q, index) in t.correctAnswer" :key="index">
                        <el-input type="textarea" autosize placeholder="(学生没有回答)" :disabled="isRead" v-model="t.userAnswer[index]">
                        </el-input>
                      </div>
                    </div>

                    <!-- 简答题 -->
                    <div class="text" v-if="t.topicType == 4">
                      <el-input type="textarea" v-model="t.userAnswer" :autosize="{ minRows: 3, maxRows: 10 }" placeholder="(学生没有回答)" :disabled="isRead">
                      </el-input>
                    </div>

                    <div v-if="t.topicType == 3||t.topicType == 4" class="correctAnswer">参考答案: {{t.correctAnswer}}</div>
                  </div>
                  <div class="right">
                    <div v-if="t.topicType == 0||t.topicType == 1||t.topicType == 2">
                      <div class="correctAnswer">参考答案: {{correctOptions(t)}}</div>
                      <div class="userScore">得分: {{t.userScore}} 分</div>
                    </div>
                    <div v-else>
                      <div class="userScore">
                        得分:
                        <el-input-number v-model="t.userScore" controls-position="right" :min="0" :max="t.score"></el-input-number>
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
            </div>

          </div>
        </div>

        <!-- 题目导航 -->
        <div class="topic-nav " :class="isFixed?'isFixed':''" :style="topic_nav_style">
          <div class="topic-nav-describe">
            <span class="topic-nav-but correct"> </span> 正确
            <span class="space"></span>
            <span class="topic-nav-but error"> </span> 错误
          </div>

          <div v-for="(topics, Topics_index) in sortedTopics" :key="Topics_index">

            <div class="topic-nav-item" v-if="topics.topic_content.length != 0">
              <div class="nav-title">{{topicTypeName_mixin(topics.topic_type)}}</div>

              <span class="topic-nav-button" @click="topicNav(topics.topic_type,index)" v-for="(item , index) in topics.topic_content" :key="index" :class="isMarkTopic(item)">
                {{topicNavIndex_mixin(topics.topic_type,index)}}
              </span>
            </div>

          </div>
        </div>

      </div>

      <div class="back-top" @click="backTop_mixin()">
        <i class="el-icon-arrow-up"></i>
      </div>

    </div>
  </div>
</template>

<script>
import "@/assets/less/testPaper.less";
import testPaperMixin from "@/mixins/testPaper-mixin";
import "@/assets/less/markTestPaper.less";

export default {
  name: "MarkTestPaper",
  mixins: [testPaperMixin],
  data() {
    return {
      classesId: this.$route.query.cId,
      examId: this.$route.query.eId,
      userId: this.$route.query.uId,


      //按题目类型分类好的题目数据
      //题目类型==>  0:单选题  1:多选题  2:判断题  3:填空题  4:简答题
      sortedTopics: [
        { topic_type: 0, topic_content: [] },
        { topic_type: 1, topic_content: [] },
        { topic_type: 2, topic_content: [] },
        { topic_type: 3, topic_content: [] },
        { topic_type: 4, topic_content: [] },
      ],
      //试卷数据
      testData: {
        examClasses:{},
        userGrade:{}
      },
      isRead: true, //是否为只读模式
      //侧导航栏是否悬浮
      isFixed: false,
      topic_nav_style: "top:0px",
    };
  },

  created() {
    this.getTestPaperData();
  },

  mounted() {
    // 监听滚动事件，然后用handleScroll这个方法进行相应的处理
    window.addEventListener("scroll", this.handleScroll);
  },

  methods: {
    //提交试卷
    submitTestpaper() {
      let userTopicList =[]
      let grade = 0;
      this.testData.topicTchDTOList.forEach(item =>{
        grade += item.userScore
        userTopicList.push({
          classesId: this.classesId,
          userId: this.userId,
          examId: this.examId,
          topicId: item.topicId,
          userScore: item.userScore,
        })
      })
      let request = {
        classesId: this.classesId,
        userId: this.userId,
        examId: this.examId,
        grade: grade,
        userTopicList: userTopicList,
      };
      console.log(request);
      this.$http.put("/tchMarkExam",request).then(res =>{
        if(res.code == 200){
          this.$message.success('批改完成');
        }
      })
    },

    //获取试卷数据
    getTestPaperData() {
      let params = {
        classesId: this.classesId,
        examId: this.examId,
        userId: this.userId,
      }
      this.$http.get('/getStuExamInfo',{params}).then(res =>{
        if(res.code == 200){
          this.processTestPaperData(res.data);
        }
      })
    },

    //处理试卷的题目数据
    processTestPaperData(testData) {
      testData.topicTchDTOList.forEach((item, index) => {
        //按换行符分割字符串
        item.choice = item.choice.split(/[\n]/g);
        item.correctAnswer = item.correctAnswer.split(/[\n]/g);
        //添加空用户答案
        if (item.topicType == 1 || item.topicType == 3) {
          item.userAnswer = [];
        } else {
          item.userAnswer = "";
        }
        //添加教师是否批改判断
        item.status = testData.userTopicList[index].topicStatus;
        //添加评改分数
        item.userScore = testData.userTopicList[index].userScore;
      });


      //处理用户答案数据
      testData.userTopicList.forEach((item, index) => {
        //按换行符分割字符串
        if (item.userAnswer.indexOf("\n") != -1) {
          item.userAnswer = item.userAnswer.split(/[\n]/g);
        }

        testData.topicTchDTOList[index].userAnswer = item.userAnswer;
        // console.log(item.userAnswer);
      });
      //根据题目id写入用户答案


      this.testData = testData;
      console.log("this.testData ==> ", this.testData);

      //按题目类型分类并保存
      var topics = this.testData.topicTchDTOList;
      var topicsIndex = 1;
      for (let i = 0; i < topics.length; i++) {
        for (let item of this.sortedTopics) {
          if (topics[i].topicType == item.topic_type) {
            //添加
            topics[i].index = topicsIndex++;
            item.topic_content.push(topics[i]);
          }
        }
      }
      console.log("this.sortedTopics ==> ", this.sortedTopics);

    },

    //滚动事件
    handleScroll() {
      let scrollTop =
        window.pageYOffset ||
        document.documentElement.scrollTop ||
        document.body.scrollTop; // 滚动条偏移量
      if (scrollTop > 154) {
        this.topic_nav_style = "top:" + (scrollTop + 62) + "px";
        this.isFixed = true;
      } else {
        this.isFixed = false;
      }
    },

    //点击题号定位到题目位置
    topicNav(type, index) {
      var i = this.topicNavIndex_mixin(type, index);
      console.log(i);
      document
        .getElementsByClassName("_location")
        [i - 1].scrollIntoView({ behavior: "smooth", block: "start" });
    },

    //判断题目是否批改与正确
    isMarkTopic(topic) {
      //单选题/多选题/判断题/
      if (topic.topicType == 0 || topic.topicType == 2 || topic.topicType == 1) {
         if(topic.score == topic.userScore){
            return "correct";
          } else {
            return "error";
          }
      }
      //如果为自动评分
      if (this.testData.autoMack === 1) {
        if(topic.score === topic.userScore){
          return "correct";
        } else {
          return "error";
        }
      }
      // } else {
      //   if (topic.status == 1) return "correct";
      //   if (topic.status == 2) return "error";
      // }
    },

    isCheckboxCorrect(topic,val){
      // console.log(topic ,val);
      let is = false
      topic.correctAnswer.forEach(item =>{
        if(item == val){
          console.log(item);
          is = true
        }
      })
      if(is){
        return "correct";
      } else {
        return "error";
      }
    },

    //正确选项参考答案选项字母化
    correctOptions(topic) {
      var correctOptions = "";
      switch (topic.topicType) {
        case 0:
          for (let i = 0; i < topic.choice.length; i++) {
            if (topic.choice[i] == topic.correctAnswer[0]) {
              correctOptions = String.fromCharCode(65 + i);
              break;
            }
          }
          break;

        case 1:
          for (let i = 0; i < topic.choice.length; i++) {
            for (let j = 0; j < topic.correctAnswer.length; j++) {
              if (topic.choice[i] == topic.correctAnswer[j]) {
                correctOptions += String.fromCharCode(65 + i);
                continue;
              }
            }
          }
          break;

        case 2:
          if (topic.correctAnswer[0] == "true") {
            correctOptions = "正确";
          } else {
            correctOptions = "错误";
          }
          break;
      }

      return correctOptions;
    },
  },
};
</script>

<style lang="scss" scoped>
</style>
