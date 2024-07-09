export const routes = [
    {
      path: '/login',
      name: 'Login',
      component: () => import( '../views/Login.vue'),
      meta:{
        title:'登录'
      },
    },
    {
      path: '/main',
      name: 'Main',
      component: () => import( '../views/Main.vue'),
      children:[
        {
          path: 'home',
          name: 'Home',
          component: () => import('../views/main/Home.vue'),
          meta:{
            title:'在线考试系统'
          },
        },
        {
          path:"me",
          name:"Me",
          component: () => import('../views/main/Me.vue'),
          meta:{
            title:'个体中心'
          },
        },
        {
          path:"classes",
          name:"Classes",
          component: () => import('../views/classes/Index.vue'),
          children:[
            {
              path:"classesList",
              name:"ClassesList",
              component: () => import('../views/classes/ClassesList.vue')
            },
            {
              path:"classesSpace/:id",
              name:"ClassesSpace",
              component: () => import('../views/classes/ClassesSpace.vue'),
              meta:{
                title:'班级空间'
              },
            },
            {
              path:"testSituation",
              name:"TestSituation",
              component: () => import('../views/classes/TestSituation.vue'),
              meta:{
                title:'班级考试情况'
              },
            },
          ]
        },
        {
          path:"topic",
          name:"Topic",
          component: () => import('../views/main/Topic.vue')
        },
        {
          path:"subjectList",
          name:"SubjectList",
          component: () => import('../views/main/subjectList.vue')
        },
        {
          path:"myTest",
          name:"MyTest",
          component: () => import('../views/myExam/MyTest.vue'),
          meta:{
            title:'我的试卷'
          },
        },
        {
          path:"myTest",
          name:"MyTest",
          component: () => import('../views/myExam/MyTest.vue'),
          meta:{
            title:'我的试卷'
          },
        },
        {
          path:"myFinishTest",
          name:"MyFinishTest",
          component: () => import('../views/main/MyFinishTest.vue')
        },
      ]
    },

    {
      path: '/testPaperStu/:tp_id/:c_id',
      name: 'TestPaperStu',
      component: () => import( '../views/testPaper/TestPaperStu.vue'),
    },
    {
      path: '/testPaperTch/:type',
      name: 'createExam',
      component: () => import( '../views/testPaper/TestPaperTch.vue'),
      meta:{
        title:'新建试卷'
      },
    },
    {
      path: '/testPaperTch/:type/:tp_id',
      name: 'editExam',
      component: () => import( '../views/testPaper/TestPaperTch.vue'),
      meta:{
        title:'修改试卷'
      },
    },
    {
      path: '/markTestPaper',
      name: 'MarkTestPaper',
      component: () => import( '../views/testPaper/MarkTestPaper.vue'),
      meta:{
        title: '批改试卷'
    }
    },
    {
      path:'/*',
      redirect: {
        name: 'Home'
      }
    }
  ]
