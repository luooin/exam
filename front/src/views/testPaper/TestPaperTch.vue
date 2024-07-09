<template>
  <div class="createTest testPaper" @click.self="edit(-1,-1)">
    <div class="w">
      <div class="header"></div>
      <!-- 试卷信息 -->
      <div class="title">
        <el-input v-model="testData.examName" class="testName" placeholder="请输入内容"></el-input>
        <ul>
          <li class="test-info">出卷者: {{ testData.creatorName }}</li>
          <li class="test-info">
            答题时间:
            <el-input-number v-model="testData.time" controls-position="right" :step="10" size="mini" :min="1"/>
            分钟
          </li>
          <li class="test-info">题目数量: 共 {{ topicNavIndex_mixin(4, sortedTopics[4].topic_content.length - 1) }} 道
          </li>
          <li class="test-info">总分: {{ totalScore }} 分</li>
          <li class="test-info">
            及格分数:
            <el-input-number v-model="testData.passMark" controls-position="right" :step="1" size="mini" :min="0"
                             :max="totalScore"/>
            分
          </li>
          <li class="test-info" style="margin-top: 10px">所属科目:
            <el-select
                v-model="testData.subjectId"
                placeholder="请选择所属科目"
            >
              <el-option
                  v-for="item in subjectsOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
              ></el-option>
            </el-select>
          </li>
          <li style="clear:both;"></li>
        </ul>
        <ul>
          <li class="test-info">允许学生切换页面次数:
            <el-input-number v-model="testData.switchPage" controls-position="right" :step="1" size="mini" :min="-1"/>
            <el-tooltip class="item" effect="light" content="-1表示允许学生无限次切换页面" placement="bottom-start">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </li>
          <li class="test-info">是否允许复制文本:
            <el-switch v-model="testData.permitCopy" active-color="#409EFF" inactive-color="#ccc"></el-switch>
          </li>
<!--          <li class="test-info">是否自动评分:-->
<!--            <el-switch v-model="testData.autoMack" active-color="#409EFF" inactive-color="#ccc"></el-switch>-->
<!--            <el-tooltip class="item" effect="light"-->
<!--                        content="取消自动评分系统依然会自动批改,但会先显示分数为0分,等待教师审批确认"-->
<!--                        placement="bottom-start">-->
<!--              <i class="el-icon-question"></i>-->
<!--            </el-tooltip>-->
<!--          </li>-->
          <li class="test-info">是否打乱题目顺序:
            <el-switch v-model="testData.disruptOrder" active-color="#409EFF" inactive-color="#ccc"></el-switch>
          </li>
          <li class="fr">
            <el-button v-if="testData.releasing === 0 || params.type === 'add'" size="mini" type="primary"
                       @click="submit()">保存试卷
            </el-button>
            <el-button v-else size="mini" type="primary" @click="copy()">复制试卷</el-button>
          </li>
          <li style="clear:both;"></li>
        </ul>

      </div>

      <div class="test-content" @click.self="edit(-1,-1)">
        <div class="topics">
          <!-- 所有题目 -->
          <div class="topic" v-for="(s_topics, index) in sortedTopics" :key="index">
            <!-- 按类型分类好的题目 -->
            <div class="topicsType" v-if="s_topics.topic_content.length != 0">
              <div class="bigQuestionName">
                <h4> {{ bigQuestionName_mixin(s_topics.type, index) }} </h4><!-- 题目类型名称 -->
                <div class="allScore">
                  <button :class="s_topics.showAllScore? 'active':''"
                          @click="s_topics.showAllScore = !s_topics.showAllScore">统一设置题目分数
                  </button>
                  <el-input v-if="s_topics.showAllScore" @change="setAllScore($event,s_topics.type)"
                            v-model="s_topics.score" placeholder="请输入分数"></el-input>
                </div>
              </div>

              <div v-for="(t, tIndex) in s_topics.topic_content" :key="tIndex" @click="edit(s_topics.type,tIndex)">
                <div class="topic-content" :class="isEdit(s_topics.type,tIndex)?'isEdit':''">
                  <!-- 题目 -->
                  <div class="question">
                    <strong class="question_nunber">{{ topicNavIndex_mixin(s_topics.type, tIndex) }}、</strong>
                    <span v-if="isEdit(s_topics.type,tIndex)">
                      <el-input v-model="t.question" type="textarea" autosize></el-input>
                    </span>
                    <span v-else>{{ t.question }}</span>
                  </div>

                  <!-- 单项选择题 -->
                  <div class="userAnswer" v-if="s_topics.type==0">
                    <div class="radios">
                      <el-radio v-for="(item, index) in t.choice" :key="index" v-model="t.correctAnswer" :label="item">
                        <span class="topicNavIndex">{{ String.fromCharCode(65 + index) }}、</span>
                        <span v-if="editInedx.type==0&&editInedx.index==tIndex">
                          <el-input v-model="t.choice[index]" type="textarea" autosize></el-input>
                          <el-button class="delRadios" size="mini" type="danger" v-if="t.choice.length>2"
                                     @click="delRadios(0,tIndex,index)">
                            <i class="el-icon-close"></i>
                          </el-button>
                        </span>
                        <span v-else>{{ item }}</span>
                      </el-radio>
                    </div>
                    <el-button class="addRadios" size="mini" icon="el-icon-plus"
                               @click="addRadios(s_topics.type,tIndex)">添加选项
                    </el-button>
                  </div>

                  <!-- 多项选择题 -->
                  <div class="userAnswer" v-if="s_topics.type==1">
                    <div class="checkbox">
                      <el-checkbox-group v-model="t.correctAnswer">
                        <el-checkbox :label="item" v-for="(item, index) in t.choice" :key="index">
                          <span class="topicNavIndex">{{ String.fromCharCode(65 + index) }}、</span>
                          <span v-if="editInedx.type==1&&editInedx.index==tIndex">
                            <el-input v-model="t.choice[index]" type="textarea" autosize></el-input>
                            <el-button class="delRadios" size="mini" type="danger" v-if="t.choice.length>2"
                                       @click="delRadios(1,tIndex,index)">
                              <i class="el-icon-close"></i>
                            </el-button>
                          </span>
                          <span v-else>{{ item }}</span>
                        </el-checkbox>
                      </el-checkbox-group>
                    </div>
                    <el-button class="addRadios" size="mini" icon="el-icon-plus"
                               @click="addRadios(s_topics.type,tIndex)">添加选项
                    </el-button>
                  </div>

                  <!-- 判断题 -->
                  <div class="userAnswer" v-if="s_topics.type==2">
                    <div class="TrueOrFalse">
                      <el-radio v-model="t.correctAnswer" label="true">正确</el-radio>
                      <el-radio v-model="t.correctAnswer" label="false">错误</el-radio>
                    </div>
                  </div>

                  <!-- 填空题 -->
                  <div class="userAnswer" v-if="s_topics.type==3">
                    <el-button size="mini" @click="addFillSymbol(tIndex)">插入填空符</el-button>
                    <span style="font-size:12px;">(三个下划线为一个填空符)</span>

                    <div class="fillInBlank">
                      <div v-for="(q, index) in fillSymbolStr(t.question)" :key="index">
                        <el-input type="textarea" autosize placeholder="请回答"
                                  v-if="index!=fillSymbolStr(t.question).length-1" v-model="t.correctAnswer[index]">
                        </el-input>
                      </div>
                    </div>
                  </div>

                  <!-- 简答题 -->
                  <div class="userAnswer" v-if="s_topics.type==4">
                    <div class="text">
                      <strong>&nbsp;&nbsp;关键字</strong>
                      <div v-for="(q, index) in t.correctAnswer" :key="index">
                        
                        <el-input type="textarea" autosize placeholder="请输入关键字"
                                  v-model="t.correctAnswer[index]"></el-input>
                         
                        <el-button class="delRadios" size="mini" type="danger" v-if="t.correctAnswer.length>2"
                                       @click="delKeyWord(4,tIndex,index)">
                              <i class="el-icon-close"></i>
                        </el-button>
                        
                        <span v-else>{{ item }}</span>
                      </div>
                      <el-button class="addRadios" size="mini" icon="el-icon-plus" @click="addKeyWord(tIndex)">
                        添加关键字
                      </el-button>
                      <!-- {{t.correctAnswer}} -->
                    </div>
                  </div>

                  <!-- 正确答案 -->
                  <p class="correctAnswer">
                    <strong>正确答案: </strong>
                    {{ t.correctAnswer }}
                  </p>
                  <div>
                    <div class="difficulty">
                      <strong>难度: </strong>
                      <span v-if="isEdit(s_topics.type,tIndex)">
                        <el-select v-model="t.difficulty" placeholder="请选择" size="mini">
                          <el-option v-for="item in topicDifficultyOptions" :key="item" :label="item" :value="item">
                          </el-option>
                        </el-select>
                      </span>
                      <span v-else>{{ t.difficulty }}</span>
                    </div>
                    <div class="topicScore">
                      <strong>分值: </strong>
                      <span v-if="isEdit(s_topics.type,tIndex)">
                        <el-input-number v-model="t.score" controls-position="right" :step="1" size="mini" :min="0"/>
                      </span>
                      <span v-else>{{ t.score }}</span>
                      (分)
                    </div>
                    <div class="required">
                      <strong>是否必填: </strong>
                      <el-switch v-model="t.required" active-color="#409EFF" inactive-color="#ccc"></el-switch>
                    </div>
                  </div>
                  <div class="analysis">
                    <strong>题目解析: </strong>
                    <span v-if="isEdit(s_topics.type,tIndex)">
                      <el-input v-model="t.analysis" type="textarea" autosize></el-input>
                    </span>
                    <span v-else>{{ t.analysis }}</span>
                  </div>

                </div>
                <el-divider></el-divider>
              </div>

            </div>
          </div>

        </div>

        <!-- 题目导航 -->
        <div class="topic-nav" :class="isFixed ? 'isFixed' : ''" :style="topic_nav_style">
          <!-- 工具 -->
          <div class="tool">
            <transition name="el-zoom-in-top">
              <div v-show="!isEdit(-1,-1)">
                <el-button icon="el-icon-top" title="上移" @click="moveTopic(-1)"></el-button>
                <el-button icon="el-icon-bottom" title="下移" @click="moveTopic(1)"></el-button>

                <el-button type="danger" icon="el-icon-delete" title="删除" @click="delTopic()"></el-button>
              </div>
            </transition>
          </div>

          <!-- 导航按钮 -->
          <ul v-for="(topics, Topics_index) in sortedTopics" :key="Topics_index">
            <li class="topic-nav-item" @click.self="edit(-1,-1)">
              <div class="nav-title">{{ topicTypeName_mixin(topics.type) }}</div>
              <span class="topic-nav-button" :class="editInedx.type==topics.type"
                    v-for="(item , index) in topics.topic_content" :key="index" @click="topicNav(Topics_index,index)">
                {{ topicNavIndex_mixin(Topics_index, index) }}
              </span>

              <span class="topic-nav-button" @click="newTopic(topics.type)">
                <i class="el-icon-plus"></i>
              </span>
            </li>
          </ul>
        </div>

        <div style="clear:both;"></div>
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

export default {
  name: "TestPaperTch",
  mixins: [testPaperMixin],
  data() {
    return {
      //按题目类型分类好的题目数据
      //题目类型==>  0:单选题  1:多选题  2:判断题  3:填空题  4:简答题
      sortedTopics: [
        {type: 0, topic_content: [], score: 0, showAllScore: false},
        {type: 1, topic_content: [], score: 0, showAllScore: false},
        {type: 2, topic_content: [], score: 0, showAllScore: false},
        {type: 3, topic_content: [], score: 0, showAllScore: false},
        {type: 4, topic_content: [], score: 0, showAllScore: false},
      ],

      // 所选科目类型
      subjectsOptions: [],

      // 试卷数据
      testData: {
        examId: -1,
        examName: "请输入试卷名称", //试卷名称
        time: 60, //答题时间
        topicNum: 0, //题目数量
        passMark: 0,
        autoMack: 1, //是否自动评分
        permitCopy: 1, //是否允许复制文本
        repeatTest: 1, //用户可重复考试次数
        switchPage: -1,
        disruptOrder: 0, //是否打乱题目顺序
        subjectId: "", // 所选科目id
        creatorName: this.$store.state.userName,
      },

      //用户数据
      userData: {
        id: "",
        name: "李子建",
      },

      //当前编辑的题目索引
      editInedx: {
        type: "-1",
        index: "-1",
        input: "-2",
      },

      topicDifficultyOptions: ["简单", "中等", "困难"], //题目难度选项

      //侧导航栏是否悬浮
      isFixed: false,
      topic_nav_style: "top:0px",
    };
  },

  computed: {
    params() {
      return this.$route.params;
    },
    //试卷总分
    totalScore() {
      let score = 0;
      this.sortedTopics.forEach((element) => {
        element.topic_content.forEach((item) => {
          score += parseInt(item.score);
        });
      });
      this.testData.totalScore = score;
      return score;
    },

    //按填空符(三个下划线)划分字符串
    fillSymbolStr() {
      return function (str) {
        return str.split("___");
      };
    },
  },

  created() {
    let type = this.$route.params.type;
    if (type === "add") {
      this.getSubjectList();
    }
    if (type === "edit") {
      this.getTestPaper();
    }
  },

  mounted() {
    // 监听滚动事件，然后用handleScroll这个方法进行相应的处理
    window.addEventListener("scroll", this.handleScroll);
  },
  methods: {
    // 复制试卷
    copy() {
      this.testData.examName = "请输入试卷名称";
      this.$router.push({
        name: "createExam",
        params: {type: "add", data: this.testData},
      });
      this.$message.success("复制成功");
    },

    //提交试卷
    submit() {
      if (this.topicNavIndex_mixin(4, this.sortedTopics[4].topic_content.length - 1) === 0) {
        this.$message.error("请至少添加一道题目后再保存");
        return;
      }
      if (!this.testData.subjectId){
        this.$message.error("请选择当前试卷科目");
        return;
      }
      let url;
      /*  处理题目信息 */
      const topicData = [];
      this.sortedTopics.forEach((element) => {
        if (element.topic_content.length !== 0) {
          element.topic_content.forEach((item) => {
            //深拷贝
            const newItem = JSON.parse(JSON.stringify(item));
            topicData.push(newItem);
          });
        }
      });

      //处理选择题选项
      topicData.forEach((item) => {
        let choice = "";
        item.choice.forEach((c) => {
          choice += c + "\n";
        });
        item.choice = choice.slice(0, -1);
        item.required = item.required === true ? 1 : 0
      });

      //处理正确答案
      for (let item of topicData) {
        if (!item.correctAnswer) {
          this.$message.warning("有题目未选答案");
          return
        }
        if (item.correctAnswer instanceof Array) {
          if (item.correctAnswer.length === 1 && item.correctAnswer[0] === '') {
            this.$message.warning("有题目未选答案");
            return
          }
          var correctAnswer = "";
          item.correctAnswer.forEach((c) => {
            correctAnswer += c + "\n";
          });
          item.correctAnswer = correctAnswer.slice(0, -1);
        }
      }

      //处理试卷信息
      const testData = JSON.parse(JSON.stringify(this.testData));
      testData.topicTchDTOList = topicData;
      testData.creatorName = this.$store.state.userName;
      testData.topicNum = topicData.length;
      // testData.autoMack = testData.autoMack ? "1" : "0";
      testData.autoMack = "1";
      testData.disruptOrder = testData.disruptOrder ? "1" : "0";
      testData.permitCopy = testData.permitCopy ? "1" : "0";


      const request = {
        ...testData,
      };

      if (this.params.type === "edit") {
        url = "/updateTestPaper";
      } else {
        url = "/createTestPaper";
      }
      console.log(request);
      this.$http.post(url, request).then((res) => {
        if (res.code === 200) {
          this.$message.success(res.msg);
          if (url === "/createTestPaper") {
            this.$router.push("/testPaperTch/" + res.data.examId);
          }
        }
      });
    },

    // 获得所有科目
    getSubjectList() {
      this.$http.get("/subject/findAll", {}).then((res) => {
        this.subjectsOptions = res.data.map(item => {
          return {
            value : item.id,
            label : item.name
          }
        })
      });
    },

    //编辑试卷---获取试卷信息
    async getTestPaper() {
      let params = {
        examId: this.$route.params.tp_id,
      };
      await this.$http.get("/getTestPaperByTp_id", {params}).then((res) => {
        const testData = res.data;
        if (res.code === 200) {
        } else {
          return;
        }

        //处理试卷的题目数据
        testData.topicTchDTOList.forEach((item) => {
          if (item.topicType === 4 || item.topicType === 3 || item.topicType === 1) {
            item.correctAnswer = item.correctAnswer.split(/[\n]/g);
          }
          //按换行符分割字符串
          item.choice = item.choice.split(/[\n]/g);
          item.required = item.required === 1;
        });
        testData.disruptOrder = testData.disruptOrder === 1;
        testData.autoMack = testData.autoMack === 1;
        testData.permitCopy = testData.permitCopy === 1;

        this.testData = testData;
        console.log("testData ==> ", this.testData);

        //按题目类型分类并保存
        const topics = this.testData.topicTchDTOList;
        for (let i = 0; i < topics.length; i++) {
          for (let item of this.sortedTopics) {
            if (topics[i].topicType === item.type) {
              item.topic_content.push(topics[i]);
            }
          }
        }
        console.log(this.sortedTopics);
      });
      this.getSubjectList();
    },

    //统一设置题目分数
    setAllScore(val, type) {
      val = parseInt(val);
      this.sortedTopics[type].topic_content.forEach((item) => {
        item.score = val;
      });
    },

    //设置当前编辑中的题目
    edit(type, index) {
      if (this.editInedx.type === type && this.editInedx.index === index) {
        console.log("拦截");
        return;
      }
      this.editInedx.type = type;
      this.editInedx.index = index;
    },

    //是否在编辑状态
    isEdit(type, index, input = -2) {
      if (
          this.editInedx.type == type &&
          this.editInedx.index == index &&
          this.editInedx.input == input
      ) {
        return true;
      } else {
        return false;
      }
    },

    //滚动事件
    handleScroll() {
      let scrollTop =
          window.pageYOffset ||
          document.documentElement.scrollTop ||
          document.body.scrollTop; // 滚动条偏移量
      if (scrollTop > 154) {
        this.topic_nav_style = "top:" + (scrollTop + 20) + "px";
        this.isFixed = true;
      } else {
        this.isFixed = false;
      }
    },

    //点击题号导航跳转
    topicNav(type, index) {
      const totalIndex = this.topicNavIndex_mixin(type, index) - 1;
      setTimeout(() => {
        document
            .getElementsByClassName("topic-content")
            [totalIndex].scrollIntoView({behavior: "smooth"});
      }, 100);
      this.edit(type, index);
    },

    //新建题目
    newTopic(type) {
      this.sortedTopics[type].topic_content.push({
        u_id: this.userData.id,
        topicType: type,
        question: "请输入题目标题",
        choice: ["选项1", "选项2", "选项3", "选项4"],
        correctAnswer: [],
        analysis: "请输入答案分析",
        difficulty: "中等",
        score: 10,
        subjectId: this.testData.subjectId,
        required: true
      });

      const time = setTimeout(() => {
        this.topicNav(type, this.sortedTopics[type].topic_content.length - 1);
        clearInterval(time);
      }, 100);
    },

    //删除当前正在编辑的题目
    delTopic() {
      var type = this.editInedx.type;
      var index = this.editInedx.index;
      this.sortedTopics[type].topic_content.splice(index, 1);
    },

    //上移或下移当前正在编辑的题目  -1:上移   1:下移
    moveTopic(n) {
      var type = this.editInedx.type;
      var index = this.editInedx.index;

      if (index == 0 && n == -1) {
        console.log("拦截");
        return;
      }
      if (index == this.sortedTopics[type].topic_content.length - 1 && n == 1) {
        console.log("拦截");
        return;
      }

      var topic = this.sortedTopics[type].topic_content[index];
      var upTopic = this.sortedTopics[type].topic_content[index + n];

      this.sortedTopics[type].topic_content.splice(index, 1, upTopic);
      this.sortedTopics[type].topic_content.splice(index + n, 1, topic);

      var time = setTimeout(() => {
        this.topicNav(type, index + n, 10);
        clearInterval(time);
      }, 100);
    },

    //删除选项
    delRadios(type, tIndex, index) {
      this.sortedTopics[type].topic_content[tIndex].choice.splice(index, 1);
      this.sortedTopics[type].topic_content[tIndex].correctAnswer.splice(index, 1);  //联动删除选项对应的正确答案
    },

    //添加选项
    addRadios(type, tIndex) {
      var choiceLength =
          this.sortedTopics[type].topic_content[tIndex].choice.length + 1;
      if (choiceLength > 10) {
        this.$message({
          message: "不能再添加选项了喔!",
          type: "warning",
        });
        return;
      }
      this.sortedTopics[type].topic_content[tIndex].choice.push(
          "选项" + choiceLength
      );
    },

    //添加填空符
    addFillSymbol(tIndex) {
      var str = this.sortedTopics[3].topic_content[tIndex].question;
      // console.log(str);
      this.sortedTopics[3].topic_content[tIndex].question = str + "___";
    },

    //添加关键字
    addKeyWord(tIndex) {
      this.sortedTopics[4].topic_content[tIndex].correctAnswer.push("");
      console.log(this.sortedTopics[4].topic_content[tIndex]);
    },

    //删除关键字
    delKeyWord(type, tIndex, index) {
      console.log(this.sortedTopics[tIndex].topic_content[tIndex].correctAnswer[index]);
      this.sortedTopics[type].topic_content[tIndex].correctAnswer.splice(index, 1);  //联动删除选项对应的正确答案
    },
  },
};
</script>
