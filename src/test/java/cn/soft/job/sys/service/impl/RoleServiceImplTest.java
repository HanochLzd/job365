package cn.soft.job.sys.service.impl;

import cn.soft.job.sys.mapper.RoleMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/spring/applicationContext-*.xml")
public class RoleServiceImplTest {

    @Autowired
    private RoleMapper roleMapper;


    @Test
    public void getOwnRoleById() {
        System.out.println(roleMapper.getOwnRoleByUserId(1));
    }
}