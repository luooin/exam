<template>
    <div>
        <div v-if="isClassesList">这是班级列表
            <el-button
                size="small"
                @click="goClassesSpace('00001')"
            >进入班级空间</el-button>
        </div>

        
        <div v-else>这是班级空间</div>

        
        <!-- <div class="table">
            <el-table
                :data="tableData"
                style="width: 100%">
                <el-table-column prop="date" label="日期"  width="180"> </el-table-column>
                <el-table-column prop="name" label="姓名" width="180"> </el-table-column>
                <el-table-column prop="address" label="地址"> </el-table-column>
            </el-table>
        </div> -->
    </div>
</template>

<script>
export default {
    name:"MyclassesPaper",
    props:['isClassesList'],

    data(){
        return{
            tableData: [{
                date: '2016-05-02',
                name: '王小虎',
                address: '上海市普陀区金沙江路 1518 弄'
            }],
        }
    },


    methods:{
        goClassesSpace(c_id){
            this.$emit('goClassesSpace',c_id);
        }
    }

}
</script>
