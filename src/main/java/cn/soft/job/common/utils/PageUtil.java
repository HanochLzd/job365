/**
 * @(#) Page.java created at 2015-7-22.
 * <p>
 * Copyright © 2015 Antai, Inc. All roghts reserved.
 */
package cn.soft.job.common.utils;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 * This is about: <code>Page.java</code>.
 * </p>
 * <p>
 * 分页操作类
 * </p>
 *
 * @author <a href="mailto:jkzhao@antai.com">xfyue</a>
 * @version V1.0
 */
public class PageUtil implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    /**
     * 页码
     */
    private int pageNo;

    /**
     * 单页记录数
     */
    private int pageSize;

    /**
     * 记录总数
     */
    private long totalCount;

    /**
     * 记录总页数
     */
    private int totalPages;

    /**
     * 记录列表
     */
    private List<?> result;

    /**
     * 排序字段
     */
    private String sort;

    /**
     * 开始记录
     */
    private long start;

    /**
     * 结束记录
     */
    private long limit;


    /**
     * 无参构造函数
     */
    public PageUtil() {
        this.pageNo = 1;
        this.pageSize = 15;
        this.result = Collections.emptyList();
        this.totalCount = 0L;
        this.totalPages = 0;
    }


    /**
     *
     * @param pageCurrent 当前页
     * @param pageSize 页面大小
     */
    public PageUtil(String pageCurrent, int pageSize) {
        if (null == pageCurrent || "" == pageCurrent) {
            pageNo = 1;
        } else {
            pageNo = Integer.parseInt(pageCurrent);
            // 当输入页码小于等于0时，默认转到首页
            if (pageNo <= 0) {
                pageNo = 1;
            }
        }

        // 当输入每页记录数小于等于0时，默认为20条
        if (pageSize <= 0) {
            this.pageSize = Constants.PER_PAGE_SIZE;
        } else {
            this.pageSize = pageSize;
        }
//		// 当输入记录总数小于0时，默认按0处理
//		if (totalCount < 0L) {
//			this.totalCount = 0L;
//		} else {
//			this.totalCount = totalCount;
//		}
//		// 当输入页码大于总页码时, 默认转到尾页
//		if ( (pageNo-1) * pageSize >= totalCount) {
//			pageNo = (int) ((totalCount+pageSize-1) /pageSize);
//		}
        // 每页起始记录
        this.start = (pageNo - 1) * pageSize;
        this.limit = pageSize;
    }

    /**
     *
     * @param start  数据起始位置
     * @param limit     数据长度
     */
    public PageUtil(String start, String limit) {
        if (null == start || "".equals(start)) {
            this.start = 0;
        } else {
            this.start = Long.valueOf(start);
        }
        if (null == limit || "".equals(limit)) {
            this.limit = 10;
        } else {
            this.limit = Long.valueOf(limit);
        }
    }

    /**
     * 构造函数
     *
     * @param pageNo
     * @param pageSize
     * @param totalCount
     * @param result
     */
    public PageUtil(String pageNo, int pageSize, long totalCount, List<?> result) {
        this(pageNo, pageSize);
        // 设值结果列表
        setResult(result);
    }

    /**
     * 获取开始记录
     *
     * @return
     */
    public int getFirst() {
        return (pageNo - 1) * pageSize;
    }

    /**
     * 获取结束记录
     *
     * @return
     */
    public int getMax() {
        return pageNo * pageSize;
    }

    /**
     * @return the pageNo
     */
    public int getPageNo() {
        return pageNo;
    }

    /**
     * @param pageNo
     *            the pageNo to set
     */
    public void setPageNo(int pageNo) {
        if (pageNo < 1) {
            pageNo = 1;
        }
        this.pageNo = pageNo;
    }

    /**
     * @return the pageSize
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * @param pageSize
     *            the pageSize to set
     */
    public void setPageSize(int pageSize) {
        if (pageSize < 1) {
            pageSize = 15;
        }
        this.pageSize = pageSize;
    }

    /**
     * @return the totalCount
     */
    public long getTotalCount() {
        return totalCount;
    }

    /**
     * @param totalCount
     *            the totalCount to set
     */
    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    /**
     * @return the result
     */
    public List<?> getResult() {
        return result;
    }

    /**
     * @param result
     *            the result to set
     */
    public void setResult(List<?> result) {
        this.result = result;
    }

    /**
     * @return the sort
     */
    public String getSort() {
        return sort;
    }

    /**
     * @param sort
     *            the sort to set
     */
    public void setSort(String sort) {
        this.sort = sort;
    }

    /**
     * @return the start
     */
    public long getStart() {
        return start;
    }

    /**
     * @param start
     *            the start to set
     */
    public void setStart(long start) {
        this.start = start;
    }

    /**
     * @return the limit
     */
    public long getLimit() {
        return limit;
    }

    /**
     * @param limit
     *            the limit to set
     */
    public void setLimit(long limit) {
        this.limit = limit;
    }

    /**
     * @return the totalPages
     */
    public int getTotalPages() {
        return totalPages;
    }

    /**
     * @param totalPages
     *            the totalPages to set
     */
    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

}
