<template>
    <div>
        试卷id:{{this.$route.params.test_id}}
    </div>
</template>

<script>
export default {
    name:"CheckTest",

    data(){
        return{
            test_id:"",
        }
    },
    created(){
        // this.asideIsSpread=false
        this.test_id=this.$route.params.test_id;
        // console.log(this.$route.params);
    },

    watch:{

    }
}
</script>

<style lang="scss" scoped>

</style>