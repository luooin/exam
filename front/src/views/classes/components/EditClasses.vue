<template>
  <div class="editClasses">
    <!-- 修改用户信息对话框 -->
    <el-dialog title="修改班级" :visible.sync="dialog" width="42%">
      <el-form label-position="right" :model="editClassesData" :rules="rules" status-icon label-width="auto"
               ref="editClassesForm">
        <el-form-item label="班级名称" prop="name">
          <el-input v-model="editClassesData.classesName" size="small" placeholder="请输入班级名称"></el-input>
        </el-form-item>
        <el-form-item label="班级简介" prop="introduction">
          <el-input v-model="editClassesData.introduction" :autosize="{ minRows: 2, maxRows: 6 }" type="textarea"
                    show-word-limit size="medium" maxlength="300" placeholder="请输入班级简介"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialog = false">取 消</el-button>
        <el-button type="primary" @click="editClasses('editClassesForm')">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>

export default {
  name: "EditClasses",
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
      editClassesData: {
        name: "",
        introduction: "",
      },
      rules: {
        name: [{validator: checkName, trigger: "change"}],
      },
    };
  },
  methods: {
    //修改班级按钮
    editClasses(formName) {
      //修改班级信息
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.dialog = false;
          // 处理post请求参数
          const params = {
            classesId: this.editClassesData.classesId,
            introduction: this.editClassesData.introduction,
            classesName: this.editClassesData.classesName,
          };
          this.$http.put("/updateClasses", params).then((res) => {
            if (res.code == 200) {
              this.$message.success("修改班级信息成功");
              this.$emit('success')
            }
          });
        }
      });
    },
  },
};
</script>

<style lang="less" scoped>
.el-dialog__body {
  text-align: left;
}
</style>
