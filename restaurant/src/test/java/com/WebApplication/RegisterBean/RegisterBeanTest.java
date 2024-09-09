package com.WebApplication.RegisterBean; // Adjust this as needed

import com.WebApplication.Beans.RegisterBean; // Import RegisterBean from the correct package
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class RegisterBeanTest {

    private RegisterBean registerBean;

    @Before
    public void setUp() {
        registerBean = new RegisterBean();
    }

    @Test
    public void testGetName() {
        registerBean.setName("John Doe");
        assertEquals("John Doe", registerBean.getName());
    }

    @Test
    public void testGetEmail() {
        registerBean.setEmail("john@example.com");
        assertEquals("john@example.com", registerBean.getEmail());
    }

    @Test
    public void testGetPassword() {
        registerBean.setPassword("password123");
        assertEquals("password123", registerBean.getPassword());
    }

    @Test
    public void testGetConfirmPassword() {
        registerBean.setConfirmPassword("password123");
        assertEquals("password123", registerBean.getConfirmPassword());
    }

    @Test
    public void testConstructor() {
        RegisterBean bean = new RegisterBean("John Doe", "john@example.com", "password123", "password123");
        assertEquals("John Doe", bean.getName());
        assertEquals("john@example.com", bean.getEmail());
        assertEquals("password123", bean.getPassword());
        assertEquals("password123", bean.getConfirmPassword());
    }
}
