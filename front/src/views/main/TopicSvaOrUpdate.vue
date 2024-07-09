<template>
  <div class="topicClass">
    <!-- 修改用户信息对话框 -->
    <el-dialog :title="this.isSave ? '新增用户' : '更新用户' " :visible.sync="dialog" width="42%">
      <el-form label-position="right" :model="user" :rules="rules" status-icon label-width="auto" ref="editClassesForm">

        <el-form-item label="头像" prop="photo">
          <img :src="user.photo" width="20%" alt=""/>
        </el-form-item>

        <el-form-item label="用户名"
                      prop="userName">
          <el-input v-model="user.userName" show-word-limit size="medium" maxlength="30"
                    placeholder="请输入用户名"></el-input>
        </el-form-item>

        <el-form-item
            label="班级"
            v-if="user.role !== 'teacher'"
            prop="sex">
          <el-select v-model="user.classesId" placeholder="请选择" size="small">
            <el-option
                v-for="item in classOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"/>
          </el-select>
        </el-form-item>

        <el-form-item label="密码"
                      prop="password">
          <el-input v-model="user.password" show-word-limit size="medium" maxlength="30"
                    placeholder="请输入密码"></el-input>
        </el-form-item>

        <el-form-item label="性别" prop="sex">
          <el-select v-model="user.sex" placeholder="请选择" size="small">
            <el-option v-for="item in sex" :key="item.key" :label="item.value" :value="item.key"/>
          </el-select>
        </el-form-item>

        <el-form-item label="电话"
                      prop="phone">
          <el-input v-model="user.phone" show-word-limit size="medium" maxlength="11"
                    placeholder="请输入电话"></el-input>
        </el-form-item>

        <el-form-item label="邮箱"
                      prop="email">
          <el-input v-model="user.email" show-word-limit size="medium" maxlength="30"
                    placeholder="请输入邮箱"></el-input>
        </el-form-item>

        <el-form-item label="角色" prop="role">
          <el-select v-model="user.role" placeholder="请选择" size="small">
            <el-option v-for="item in role" :key="item.key" :label="item.value" :value="item.key"/>
          </el-select>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialog = false">取 消</el-button>
        <el-button type="primary" @click="saveOrUpdate()">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>

export default {
  name: "TopicClass",
  data() {
    return {
      rules: {
        userName: [{required: true, message: '请输入用户名', trigger: 'blur'}],
        password: [{required: true, message: '请输入密码', trigger: 'blur'}],
        phone: [{required: true, message: '请输入有效的电话号码', trigger: 'blur'}],
        email: [{required: true, type: 'email', message: '请输入有效的邮箱地址', trigger: 'blur'}]
      },

      dialog: false,
      userId: '',
      // 用户信息数据
      user: {
        // 用户名
        userName: '',
        // 密码
        password: '',
        // 性别
        sex: '男',
        // 头像
        photo: 'http://localhost:8081/images/user.jpg',
        // 电话
        phone: '',
        // 邮箱
        email: '',
        // 角色
        role: 'student',
        // 班级id
        classesId: ''
      },
      // 是否为新增
      isSave: true,

      // 性别选择
      sex: [
        {key: '男', value: '男'},
        {key: '女', value: '女'},
      ],

      // 角色选择
      role: [
        {key: 'student', value: '学生'},
        {key: 'teacher', value: '教师'},
      ],

      // 班级选择
      classOptions: [],

    };
  },
  methods: {

    // 获取所有班级
    getClass() {
      this.$http.get("/classes/findAll", {}).then((res) => {
        this.classOptions = res.data.map(item => {
          return {
            value: item.classesId,
            label: item.classesName
          }
        })
      });
    },

    // 如果是更新,则需要根据id查询数据回显
    getUser() {
      let params = {
        id: this.userId
      };
      this.$http.get(`/findOneByUserId`, {params}).then((res) => {
        if (res.code === 200) {
          this.user = res.data;
        } else {
          this.$message.error(res.msg);
        }
      })
    },
    //修改班级按钮
    saveOrUpdate() {
      this.$refs.editClassesForm.validate((valid) => {
        if (valid) {
          if (this.isSave) {
            // 新增操作
            this.$http.post("/addUser", this.user).then((res) => {
              if (res.code === 200) {
                this.dialog = false;
                this.$message.success(res.msg);
                this.$emit('success')
              } else {
                this.$message.error(res.msg);
                s
              }
            })
          } else {
            // 更新操作
            this.user.photo = this.user.photo.split("/")[4]
            this.$http.post("/updateUser", this.user).then((res) => {
              if (res.code === 200) {
                this.dialog = false;
                this.$message.success(res.msg);
                this.$emit('success')
              } else {
                this.$message.error(res.msg);
              }
            })
          }
        } else {
          // 验证不通过，不执行保存或更新操作
          return false;
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
