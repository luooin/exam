package cn.com.exam.enums;

public enum Position {
    creator("创建者","creator"),
    student("学生","student"),
    admin("管理员","admin")
    ;

    private String name;
    private String value;
    Position(String name, String value) {
        this.name = name;
        this.value = value;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
