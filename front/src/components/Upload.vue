<template>
  <div class="uploadPhoto">
    <div class="title">上传头像 :</div>
    <el-upload 
				action="http://localhost:8082/upload" 
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
</template>

<script>
export default {
	name: "Upload",
  data() {
    return {
			imageUrl: '',
			fileList: [
			],
			token: "",
      autoUpload: false

    };
  },
	methods:{
		handleAvatarSuccess(res, file) {
			console.log(res,file);
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
			console.log(file);
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
		handleAvatarChange(file, fileList){
      console.log(file);
      this.imageUrl = URL.createObjectURL(file.raw);
    },
		handleAvatarExceed(file,fileList){
			this.$message("图片只能上传一张,请删除图片再上传");
		},
		handleAvatarRemove(res, file){
			console.log(res,file);
			if(res.response){
				let params = { fileName: res.response.data.fileUrl }
				this.$http.delete("/upload/delete", {params}).then(res =>{
					if(res.code == 200){
						this.imageUrl = ''
					}
				})
			}

      if(this.autoUpload === false) this.imageUrl = ''

			
		}
	}
};
</script>

<style lang="less" scoped>
.avatar-uploader .el-upload {
	border: 1px dashed #d9d9d9;
	border-radius: 6px;
	cursor: pointer;
	position: relative;
	overflow: hidden;
}
.avatar-uploader .el-upload:hover {
	border-color: #409EFF;
}
.avatar-uploader-icon {
	font-size: 28px;
	color: #8c939d;
	width: 178px;
	height: 178px;
	line-height: 178px;
	text-align: center;
}
.avatar {
	width: 178px;
	height: 178px;
	display: block;
}

</style>