<template>
  <div class="Classes">
    <MyTab :menu="menu" paperName="ClassesSpace" listName="ClassesList" openFinishTestId="openClassesSpace"></MyTab>
  </div>
</template>

<script>
import MyTab from "@/components/MyTab.vue"

export default {
  name: "Index",
  components: {
    MyTab,
  },
  data() {
    return {
      menu: [
        {title: "我的班级", name: "ClassesList", id: "-1"},
      ]
    }
  },
}
</script>

<style lang="less" scoped>
.Classes {
  height: 100%;
}
</style>
