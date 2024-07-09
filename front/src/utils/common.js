export function aaa() {
    console.log(111);
}

export function formatTime(number, format) {
    let time = new Date(number)
    let newArr = []
    let formatArr = ['Y', 'M', 'D', 'h', 'm', 's']
    newArr.push(time.getFullYear())
    newArr.push(formatNumber(time.getMonth() + 1))
    newArr.push(formatNumber(time.getDate()))

    newArr.push(formatNumber(time.getHours()))
    newArr.push(formatNumber(time.getMinutes()))
    newArr.push(formatNumber(time.getSeconds()))

    for (let i in newArr) {
        format = format.replace(formatArr[i], newArr[i])
    }
    return format;
}

function formatNumber(n) {
    n = n.toString()
    return n[1] ? n : '0' + n;
}


//秒转换为时间
export function formatSeconds(value) {
    var theTime = parseInt(value); // 需要转换的时间秒 
    var theTime1 = 0; // 分 
    var theTime2 = 0; // 小时 
    var theTime3 = 0; // 天
    if (theTime > 60) {
        theTime1 = parseInt(theTime / 60);
        theTime = parseInt(theTime % 60);
        if (theTime1 > 60) {
            theTime2 = parseInt(theTime1 / 60);
            theTime1 = parseInt(theTime1 % 60);
            if (theTime2 > 24) {
                //大于24小时
                theTime3 = parseInt(theTime2 / 24);
                theTime2 = parseInt(theTime2 % 24);
            }
        }
    }
    var result = '';
    if (theTime > 0) {
        result = "" + parseInt(theTime) + "秒";
    }
    if (theTime1 > 0) {
        result = "" + parseInt(theTime1) + "分" + result;
    }
    if (theTime2 > 0) {
        result = "" + parseInt(theTime2) + "小时" + result;
    }
    if (theTime3 > 0) {
        result = "" + parseInt(theTime3) + "天" + result;
    }
    return result;
}

//获取格式化时间时间
export function getFormatDate(date) {
    var format='yyyy-MM-dd hh:mm:ss';
  
    //格式化年份
    let year = date.getFullYear().toString();
    // 
    if (/(y+)/.test(format)){
      //获取匹配组的内容
      var content = RegExp.$1;
      // 
      format = format.replace(content, year.slice(year.length - content.length));
    }
  
    // 
  
    //格式化月份、日份、时、分、秒
    let o = {
      M: date.getMonth() + 1,
      d: date.getDate(),
      h: date.getHours(),
      m: date.getMinutes(),
      s: date.getSeconds()
    };
  
    // 
  
    for (let key in o) {
      //创建动态正则表达式
      let reg = new RegExp(`(${key}+)`);
      // 
  
      if (reg.test(format)) {
        //获取组匹配的内容
        let groupContent = RegExp.$1;
        // 
  
        format = format.replace(groupContent, o[key] >= 10 ? o[key] : groupContent.length == 2 ? '0' + o[key] : o[key]);
        // 
      }
      
    }
  
    return format;
  };


  //获取系统时间
export function getNowFormatDate(format) {
    //创建日期对象
    let date = new Date();
  
    //格式化年份
    let year = date.getFullYear().toString();
    // 
    if (/(y+)/.test(format)){
      //获取匹配组的内容
      var content = RegExp.$1;
      // 
      format = format.replace(content, year.slice(year.length - content.length));
    }
  
    // 
  
    //格式化月份、日份、时、分、秒
    let o = {
      M: date.getMonth() + 1,
      d: date.getDate(),
      h: date.getHours(),
      m: date.getMinutes(),
      s: date.getSeconds()
    };
  
    // 
  
    for (let key in o) {
      //创建动态正则表达式
      let reg = new RegExp(`(${key}+)`);
      // 
  
      if (reg.test(format)) {
        //获取组匹配的内容
        let groupContent = RegExp.$1;
        // 
  
        format = format.replace(groupContent, o[key] >= 10 ? o[key] : groupContent.length == 2 ? '0' + o[key] : o[key]);
        // 
      }
      
    }
  
    return format;
  };