package cn.soft.job.web.service.impl;

import cn.soft.job.web.mapper.CategoryMapper;
import cn.soft.job.web.pojo.po.Category;
import cn.soft.job.web.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Hanoch
 * @version 1.0
 * @date 2018/9/27 15:24
 */
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> getAllCategory(int i) {
        return categoryMapper.getAllCategory(i);
    }
}
