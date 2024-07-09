package cn.com.exam.enums;

public enum Role {
    student("学生","student"),
    teacher("教师","teacher");

    private String name;
    private String value;
    Role(String name, String value) {
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
