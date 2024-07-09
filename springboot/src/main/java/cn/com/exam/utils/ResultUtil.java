package cn.com.exam.utils;

public class ResultUtil {
    /**
     * 请求成功返回
     *
     * @param object
     * @return
     */
    public static <T> Msg<T> success(T data) {
        Msg<T> msg = new Msg<>();
        msg.setCode(200);
        msg.setMsg("请求成功");
        msg.setData(data);
        return msg;
    }

    public static Msg success(String message) {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg(message);
        return msg;
    }

    public static Msg success() {
        return success(null);
    }

    public static Msg error(Integer code, String resultmsg) {
        Msg msg = new Msg();
        msg.setCode(code);
        msg.setMsg(resultmsg);
        return msg;
    }

    public static Msg error(Integer code, String resultmsg, String data) {
        Msg msg = new Msg();
        msg.setCode(code);
        msg.setMsg(resultmsg);
        msg.setData(data);
        return msg;
    }

}
