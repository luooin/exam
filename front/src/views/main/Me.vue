<template>
  <div class="content-bg me">
    <div class="tab-title">
      <div class="tabTitle-item active">个人中心</div>
    </div>
    <div class="tab-item">
			<div class="uploadPhoto">
				<div class="title">上传头像 :</div>
				<el-upload class="avatar-uploader"
				:action="actionURL"
				:headers="{ token }"
				:file-list="fileList"
				:limit="1"
				:show-file-list="true"
        :auto-upload="autoUpload"
				:on-exceed="handleAvatarExceed"
				:on-change="handleAvatarChange"
				:on-remove="handleAvatarRemove"
				:on-success="handleAvatarSuccess"
				:before-upload="beforeAvatarUpload">
					<img v-if="imageUrl" :src="imageUrl" class="avatar">
					<i v-else class="el-icon-plus avatar-uploader-icon"></i>
				</el-upload>
			</div>
      <div class="userInfo">
        <div class="item">
          <span class="title">用户Id :{{userData.userId}}</span>
        </div>
        <div class="item">
          <span class="title">用户名 :</span>
          <el-input v-model="userData.userName"></el-input>
        </div>
        <div class="item">
          <span class="title">密码 :</span>
          <el-input v-model="userData.password"></el-input>
        </div>
        <div class="item">
          <span class="title">邮 箱 :</span>
          <el-input v-model="userData.email"></el-input>
        </div>
        <div class="item">
          <span class="title">手机号码 :</span>
          <el-input v-model="userData.phone"></el-input>
        </div>
        <div class="item">
          <span class="title">性 别 :</span>
          <el-input v-model="userData.sex"></el-input>
        </div>
        <div class="item">
          <span class="title">创建时间 :</span>
          <div class="con">{{userData.createDate}}</div>
        </div>
        <div v-if="userData.role === 'teacher'" class="item">
          <span class="title">工 作 :</span>
          <div class="con work">{{userData.work}}</div>
        </div>
        <el-button class="openTest" size="medium" @click="update()">修改</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import "@/assets/less/my_tab.less";
import "@/assets/less/main/me.less";

export default {
  name: "Me",
  data() {
    return {
      userData: [],
			imageUrl: '',
			token: "",
			fileList: [],
      autoUpload: true,
      actionURL: this.$baseURL+'/upload'
    };
  },
  created() {
    this.user_id = this.$root.user_id;
		this.token = localStorage.getItem("_token")
    this.getUserData();
  },

  methods: {
    // 修改
    update(){
      this.$http.put(this.$api.user.userEdit,this.userData).then(res =>{
        if (res.code === 200){
          this.$message.success(res.msg);
          this.getUserData();
        }else {
          this.$message.error(res.msg);
        }
      })

    },
    // 获取用户信息
    async getUserData() {
      const res = await this.$http.get(this.$api.user.getUserById)
      this.userData = res.data

      if(res.data.photo){
        this.fileList = [{
          name: res.data.photoName,
          url: this.$imageBaseUrl + res.data.photo
        }]
        this.imageUrl = this.$imageBaseUrl + res.data.photo
      }
    },
    //上传成功
    handleAvatarSuccess(res, file) {
      this.$store.commit('setUserPhoto',res.data.fileUrl);
      this.imageUrl = URL.createObjectURL(file.raw);
      let params = {
        userId: this.userData.userId,
        photo: res.data.fileUrl,
        photoName: res.data.fileName,
        password: this.userData.password
      }
      this.$http.put(this.$api.user.userEdit,params).then(res =>{
        if(res.code === 200){
          this.$message.success('上传成功')
        }
      })
    },
    //删除
		async handleAvatarRemove(res, file){
      console.log(res,file);
      let uploadParams
			if(res.response){
        uploadParams = { fileName: res.response.data.fileUrl }
			}else{
        uploadParams = { fileName: this.userData.photo }
      }

      //删除图片
      let result = await this.$http.delete("/upload/delete", {params:uploadParams})

      //删除用户图片数据
      if(result.code === 200){
        this.imageUrl = ''
        let params = {
          userId: this.userData.userId,
          photo: '',
          photoName: '',
          password:this.userData.password
        }
        this.$http.put(this.$api.user.userEdit,params).then(res =>{
          if(res.code === 200){
            this.$message.success('删除成功')
            this.$store.commit('setUserPhoto',null);
          }
        })
      }

      if(this.autoUpload === false) this.imageUrl = ''

		},



		handleAvatarExceed(file,fileList){
			this.$message("图片只能上传一张,请删除图片再上传");
		},
    handleAvatarChange(file, fileList){
      console.log(123);
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === "image/jpeg" || file.type === "image/png";
      const isLt2M = file.size / 1024 / 1024 < 10;

      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 和 png 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 10MB!");
      }

      return isJPG && isLt2M;
    },
  },
};
</script>

<style lang="less" scoped>



</style>
