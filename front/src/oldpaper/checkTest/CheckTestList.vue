<template>
    <div>
        试卷列表

        <el-button class="openTest" @click="openTest('0003')">openTest</el-button>
        <el-button class="openTest" @click="openTest('0011')">openTest</el-button>
    </div>
</template>

<script>
export default {
    name:"CheckTestList.vue",
    data(){
        return{
            test_id:"",
        }
    },

    methods:{
        openTest(test_id){
            this.$emit("newTest",test_id,"试卷"+test_id)
        }
    }
}
</script>

<style lang="scss" scoped>

</style>