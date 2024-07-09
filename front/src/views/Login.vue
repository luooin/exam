<template>
  <div class="login">
    <div class="info">
      <p style="text-align: center">欢迎使用在线考试系统</p>
      <!-- {{$store.state.user_id}} -->
      <el-form :model="form" status-icon :rules="rules" ref="loginForm" label-width="auto">
        <el-form-item label="账号" prop="name">
          <el-input v-model="form.name" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="form.password" placeholder="请输入密码"></el-input>
        </el-form-item>
        <!--<img id="verImg" width="130px" height="48px"/>
        <el-form-item label="验证码" prop="verCode">
          <el-input v-model="form.verCode" placeholder="请输入验证码"></el-input>
        </el-form-item>-->
      <el-form-item label="验证码" prop="verCode">
        <div style="display: flex; justify-content: center">
          <el-input v-model="form.verCode" placeholder="请输入验证码"></el-input>
           <img :src="captchaUrl" @click="getCode" width="140px" height="43px"/> 
        </div>
      </el-form-item>

<!--        <div class="forget-password" :underline="false">忘记密码?</div>-->
    

        <div class="login-but" @click="login('loginForm')">登录</div>

      </el-form>
    </div>
  </div>
</template>

<script>
import "../assets/less/login.less"


export default {
  name: "Login",
  key: '',
  data() {
    return {
      key: '',
      captchaUrl: '',
      form: {
        name: '',
        password: '',
        verCode: '',
        verKey: '',
      },
      rules: {
        name: [
          {required: true, message: '请输入账号名称', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
        verCode: [
          {required: true, message: '请输入验证码', trigger: 'blur'},
        ],
      },
    };
  },
  
  created() {
    this.getCode()
  },

  methods: {
    goRouter(path) {
      this.$router.push(path)
    },
    getCode() {
      const axios = require('axios');
      axios.get("http://localhost:8081/captcha").then( res => {
        console.log(res.data.data.token);
        const response = res.data
        this.captchaUrl = response.data.image
        this.form.verKey = response.data.key    
      })
    },
    //路由跳转
    goRouter(path) {
      this.$router.push(path)
    },
    //表单提交-----登录
    login(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // 处理请求参数
          const request = {
            name: this.form.name,
            password: this.form.password,
            verCode: this.form.verCode,
            verKey: this.form.verKey,
          }
          
          this.$http.post('/login', request).then(res => {
            if (res.code === 200) {
              const data = res.data;
              //登录成功跳转
              localStorage.setItem('_token', data.token);
              this.goRouter({name: "Home"})
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
  }
};
</script>