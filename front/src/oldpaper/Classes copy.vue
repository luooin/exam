<template>
    <div class="my-tab">
        <el-tabs v-model="editableTabsValue" type="card"  @tab-remove="removeTab">
            <el-tab-pane
                v-for="(item, index) in editableTabs"
                :key="item.name"
                :label="item.title"
                :name="item.name"
                :closable="item.closable"
            >
                <div class="tabContent-item" >
                    {{item.content}}{{index}}
                    <MyclassesPaper :isClassesList="item.isClassesList" @goClassesSpace="goClassesSpace"/>
                </div>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
import "../../assets/less/my_tab.less"
import MyclassesPaper from "../../components/MyclassesPaper.vue"
export default {
    name:"Classes",

    props:["tabHeader_left"],

    components: {
        MyclassesPaper,
    },
    data(){
        return {
            editableTabsValue: '1',
            editableTabs: [{
                title: '我的班级',
                name: '1',
                content: '<MyclassesList />',
                isClassesList:true
                }],
            tabIndex: 2
        }
    },

    created(){
        // console.log(this.tabHeader_left);
            
    },

    mounted(){
        var tabHeader=document.getElementsByClassName("el-tabs__header")[0];
        tabHeader.style.left=this.tabHeader_left;
    },

    methods:{
        goClassesSpace(c_id){
            console.log(c_id);
            let newTabName = ++this.tabIndex + '';
            this.editableTabs.push({
                title: 'New Classes',
                name: newTabName,
                content: c_id,
                closable:true,
                isClassesList:false
            });
            this.editableTabsValue = newTabName;
        },
        addTab(targetName) {
            let newTabName = ++this.tabIndex + '';
            this.editableTabs.push({
            title: 'New Tab',
            name: newTabName,
            content: 'New Tab content'
            });
            this.editableTabsValue = newTabName;
        },
        removeTab(targetName) {
            let tabs = this.editableTabs;
            let activeName = this.editableTabsValue;
            if (activeName === targetName) {
                tabs.forEach((tab, index) => {
                    if (tab.name === targetName) {
                    let nextTab = tabs[index + 1] || tabs[index - 1];
                    if (nextTab) {
                        activeName = nextTab.name;
                    }
                    }
                });
            }
            
            this.editableTabsValue = activeName;
            this.editableTabs = tabs.filter(tab => tab.name !== targetName);
        }
    },

    watch:{
        tabHeader_left(newval, val) {
            // console.log("tabHeader_left -> newval", newval)
            // console.log("tabHeader_left -> val", val)
            var tabHeader=document.getElementsByClassName("el-tabs__header")[0];
            tabHeader.style.left=newval;
            // console.log(tabHeader);
        }
    }


}
</script>

<style lang="scss" scoped>

</style>