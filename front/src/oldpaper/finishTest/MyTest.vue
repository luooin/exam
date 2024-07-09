<template>
    <div class="MyTest">
        <MyTab :menu="menu" listName="MyTestList" paperName="MyFinishTest" openFinishTestId="openFinishTestId"></MyTab>
    </div>
</template>

<script>
import MyTab from "../../components/MyTab.vue"
export default {
    name:"MyTest",
    components:{
        MyTab
    },

    data(){
        return{
            
            menu:[
                {title:"我考过过的试卷",path:"/main/myTest/myTestList",name:"MyTestList",test_id:"-1"},
                {title:"试卷1",path:"/main/myTest/myFinishTest",name:"MyFinishTest",test_id:"0001",closable:false}
            ]
        }
    }

}
</script>

<style lang="less" scoped>
.MyTest{
    height: 100%;
    // background: #f7f7f7e0;

}
</style>