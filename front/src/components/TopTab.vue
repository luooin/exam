<template>
  <div class="content-bg">
    <div class="tab-title">
      <div class="tabTitle-item active">{{title}}</div>
    </div>
    <div class="tab-item">
      
      <slot></slot>
    </div>

    
  </div>
</template>

<script>
import "../assets/less/my_tab.less"
export default {
  name: "TopTab",

  props: ['title'],


};
</script>

<style lang="less" scoped>
</style>