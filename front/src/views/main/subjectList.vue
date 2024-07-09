<template>
  <div class="myTest content-bg ">
    <div class="tab-title">
      <div class="tabTitle-item active">我的试卷</div>
    </div>
    <div class="tab-item">
      <div class="list-header">
        <el-button type="primary" size="medium" icon="el-icon-plus" @click="openCreated()" class="create">新建科目
        </el-button>
      </div>

      <div class="table">
        <el-table :data="testList" style="width: 100%" v-loading="loading">
          <el-table-column label="科目编号" width="110">
            <template slot-scope="scope">{{ scope.row.id }}</template>
          </el-table-column>
          <el-table-column label="科目名称" min-width="220">
            <template slot-scope="scope">{{ scope.row.name }}</template>
          </el-table-column>
          <el-table-column label="拥有该科目的班级数量" min-width="220">
            <template slot-scope="scope">{{ scope.row.numberCount }}个</template>
          </el-table-column>
          <el-table-column label="试卷数量" min-width="220">
            <template slot-scope="scope">{{ scope.row.examCount }}套</template>
          </el-table-column>
          <el-table-column label="操作" width="240" fixed="right">
            <template slot-scope="scope">
              <el-button
                  type="primary"
                  size="mini"
                  plain
                  @click="openUpdate(scope.row.id,scope.row.name)">
                修改科目名称
              </el-button>
            </template>
          </el-table-column>

        </el-table>
      </div>


      <el-dialog :title=" this.isSave ?
              '新增科目' : '编辑科目' " :visible.sync="dialog" width="42%">
        <el-form label-position="right" :model="subject" status-icon label-width="auto" ref="editClassesForm">
          <el-form-item label="科目名称" prop="name">
            <el-input v-model="subject.name"
                      show-word-limit
                      size="medium"
                      maxlength="30"
                      placeholder="请输入科目名称"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cloneDialog()">取 消</el-button>
          <el-button type="primary" @click="saveOrUpdate()">确 定</el-button>
        </div>
      </el-dialog>


    </div>
  </div>
</template>

<script>
import "../../assets/less/my_tab.less";

export default {
  name: "SubjectList",
  data() {
    return {
      loading: true,
      testList: [],
      // 是否为新增
      isSave: true,
      dialog: false,
      subject: {
        id: "",
        name: ""
      }
    };
  },

  created() {
    this.getTestPaperList();
  },

  methods: {
    //获取试卷列表
    getTestPaperList() {
      this.loading = true
      this.$http.get("/subject/findAll", {}).then((res) => {
        this.testList = res.data;
        this.loading = false
      });
    },

    cloneDialog() {
      this.dialog = false;
      this.$data.subject = {};
    },
    openCreated() {
      this.dialog = true;
      this.isSave = true;
    },

    openUpdate(id, name) {
      this.dialog = true;
      this.isSave = false;
      this.subject = {id: id, name: name}; // 创建新的对象

    },

    saveOrUpdate() {
      if (this.isSave) {
        // 新增操作
        this.$http.post("/subject/create", this.subject).then((res) => {
          if (res.data) {
            this.dialog = false;
            this.$message.success("新增成功");
            this.$data.subject = {};
            this.getTestPaperList();
            this.$emit('success')
          } else {
            this.$message.error("新增失败");
          }
        })
      } else {
        // 更新操作
        this.$http.post("/subject/update", this.subject).then((res) => {
          if (res.data) {
            this.dialog = false;
            this.$message.success("修改成功");
            this.$data.subject = {};
            this.getTestPaperList();
            this.$emit('success')
          } else {
            this.$message.error("修改失败");
          }
        })
      }
    },
  },
};
</script>

<style lang="less" scoped>
.myTest {
  .tab-item {
    padding: 10px 20px;
  }

  .table {
    margin-top: 24px;
  }

  .releaseTest .el-dialog {
    .el-dialog__header {
      text-align: center;
      font-size: 16px;
    }

    .el-dialog__body {
      padding-top: 0px;
      padding-bottom: 0px;
      text-align: center;
    }

    .pagination {
      text-align: center;
    }

    .el-date-editor {
      margin: 38px 0px;
    }
  }
}

.list-header {
  position: relative;
  background: #fafafa;
  padding: 6px 24px;
  border-radius: 4px;
  height: 60px;
  box-sizing: border-box;
  box-shadow: 0 2px 4px 0 rgb(0 0 0 / 12%), 0 0 6px 0 rgb(0 0 0 / 4%);

  span.list-title {
    display: inline-block;
    margin-right: 30px;
    font-size: 16px;
    line-height: 48px;
  }

  .create {
    background: #4788cc;
    color: #fff;
    border-color: #f6f6f6;
  }

  .query {
    position: absolute;
    right: 24px;
    top: 14px;
    width: 400px;
    height: 40px;
  }

  .query .el-input {
    width: 320px;
    margin-right: 20px;
  }

  .query .el-button {
    background: #4788cc;
    border-color: #4788cc;
    transition: 1s;
  }
}
</style>
