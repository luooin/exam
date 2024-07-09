<template>
    <div>
        这是我考过的试卷列表

        <el-button class="openTest" @click="openTest('0003')">openTest</el-button>
        <el-button class="openTest" @click="openTest('0011')">openTest</el-button>

        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
        <p>这是我考过的试卷列表</p>
    </div>
</template>

<script>
export default {
    name:"MyTestList.vue",
    data(){
        return{
            test_id:"",
        }
    },

    methods:{
        openTest(test_id){
            this.$emit("openPaper",test_id,"试卷"+test_id)
        }
    }
}
</script>

<style lang="scss" scoped>

</style>