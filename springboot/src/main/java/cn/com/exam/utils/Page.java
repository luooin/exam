package cn.com.exam.utils;

import lombok.Data;

import java.util.List;

@Data
public class Page<T> {
    public static final int DEFAULT_PAGE_SIZE = 10;

    /*每页显示个数*/
    private int pageSize;

    /*当前页数*/
    private int currentPage;

    /*总页数*/
    private int totalPage;

    /*总数据个数*/
    private int total;

    private List<T> content;

    public Page(){
        this.pageSize = DEFAULT_PAGE_SIZE;
        this.currentPage = 1;
    }

    public Page(int size,int current){
        this.pageSize = size <= 0 ? 1:size;
        this.currentPage = current <=0? 1:current;
    }

    public void build(List<T> content){
        this.total = content.size();
        if(this.total == 0){
            this.totalPage = 0;
            this.currentPage = 1;
            this.setContent(content);
            return;
        }
        this.totalPage = this.total%this.pageSize == 0 ? this.total/this.pageSize : this.total/this.pageSize+1;
        this.currentPage = this.currentPage > this.totalPage ? this.totalPage : this.currentPage;
        this.setContent(content.subList(this.pageSize*(this.currentPage-1),this.currentPage==this.totalPage?content.size():this.pageSize*this.currentPage));
    }
}
