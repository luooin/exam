<template>
  <el-dialog class="releaseTest" title="设置考试发布信息" :visible.sync="dialog" width="40%" @close="releaseTestDate = []">
    <!-- 选择考试时间 -->
    <el-date-picker v-model="releaseTestDate" type="datetimerange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
    </el-date-picker>
    <el-switch v-model="updateRelease.publishAnswer" active-text="公布答案" :active-value="1" inactive-text="不公布答案" :inactive-value="0" />
    <el-switch v-model="updateRelease.publishScore" active-text="公布分数" :active-value="1" inactive-text="不公布分数" :inactive-value="0" />

    <span slot="footer" class="dialog-footer">
      <el-button size="medium" @click="dialog=false"> 取消 </el-button>
      <el-button type="primary" size="medium" @click="doChangeTestDate()"> 确认更改 </el-button>
    </span>
  </el-dialog>
</template>

<script>
import { getFormatDate } from "@/utils/common.js";

export default {
  name: "ReleaseUpdate",
  data() {
    return {
      classesId: "",
      examId: "",
      dialog: false,
      releaseTestDate: [],
      updateRelease: {},
    };
  },
  methods: {
    //更改考试时间弹框
    changeTestDate(val, classesId) {
      this.dialog = true;
      this.updateRelease = val;
      this.classesId = classesId;
      this.releaseTestDate = [val.startDate, val.deadline];
      console.log(val);
    },

    //更改考试时间数据库操作
    doChangeTestDate() {
      //考试开始时间
      var start_date = getFormatDate(new Date(this.releaseTestDate[0]));
      //考试结束时间
      var deadline = getFormatDate(new Date(this.releaseTestDate[1]));

      // 处理post请求参数
      var request = {
        examId: this.updateRelease.examId,
        classesId: this.classesId,
        startDate: start_date,
        deadline,
        publishScore: this.updateRelease.publishScore,
        publishAnswer: this.updateRelease.publishAnswer,
      };
      this.$http.post("/updateReleaseTest", request).then((res) => {
        if (res.code == 200) {
          this.$emit("success");
          this.dialog = false;
          this.$message.success("更改成功");
        }
      });
    },
  },
};
</script>

<style lang="less" scoped>
.el-dialog__body {
  padding: 0 12px;
  text-align: center;

  // .el-range-editor.el-input__inner{
  //   display: block;
  // }
  .el-switch {
    display: block;
    margin: 24px 0;
  }
}
</style>