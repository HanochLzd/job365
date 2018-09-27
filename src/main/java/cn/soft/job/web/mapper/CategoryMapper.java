package cn.soft.job.web.mapper;

import cn.soft.job.web.pojo.po.Category;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/27 15:23
 */
public interface CategoryMapper {

    List<Category> getAllCategory(int type);
}
