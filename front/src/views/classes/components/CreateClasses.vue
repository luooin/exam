<template>
  <div class="createClasses">
    <!-- 创建班级对话框 -->
    <el-dialog title="创建班级" :visible.sync="dialog" width="42%">
      <el-form label-position="right" :model="createClassesData" :rules="rules" status-icon label-width="auto"
               ref="createClassesForm">
        <el-form-item label="创建班级名称" prop="name">
          <el-input v-model="createClassesData.name" size="small" placeholder="请输入班级名称"></el-input>
        </el-form-item>
        <el-form-item label="班级简介" prop="introduction">
          <el-input v-model="createClassesData.introduction" :autosize="{ minRows: 2, maxRows: 6 }" type="textarea"
                    show-word-limit size="medium" maxlength="300" placeholder="请输入班级简介"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialog = false">取 消</el-button>
        <el-button type="primary" @click="createClasses('createClassesForm')">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>

export default {
  name: "CreateClasses",
  data() {
    const checkName = (rule, value, callback) => {
      const reg = /^[\u4e00-\u9fa5\w]{1,16}$/;
      if (!reg.test(value)) {
        callback(new Error("班级名称只能是3-16位汉字、字母、数字、下划线"));
      } else {
        callback();
      }
    };
    return {
      dialog: false,
      //创建班级的数据
      createClassesData: {
        name: "",
        introduction: ""
      },
      rules: {
        name: [{validator: checkName, trigger: "change"}],
      },
    }
  },
  methods: {
    //创建班级
    createClasses(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.dialog = false;
          const params = {
            classesName: this.createClassesData.name,
            creatorName: this.$store.state.userName,
            introduction: this.createClassesData.introduction,
          };
          this.$http.post('/createClasses', params).then(res => {
            if (res.code === 200) {
              this.$message.success('创建班级成功')
              this.$emit('success')
            }
          })
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
  }
};
</script>

<style lang="less" scoped>
.el-textarea .el-input__count {
  bottom: 0px;
  right: 21px;
  background: unset;
}

.el-dialog__body {
  text-align: left;
}
</style>
