package com.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import javax.sql.DataSource;
import java.util.List;

public class UserDAO extends JdbcTemplate {

    @Autowired
    private PlatformTransactionManager transactionManager;

    @Autowired
    public UserDAO(DataSource dataSource) {
        super(dataSource);
    }

    public List<User> getUserByPhone(String phone) {
        String SQL = "SELECT * FROM userinfo WHERE phone = ?";
        return this.query(SQL, new Object[]{phone}, new UserMapper());
    }

    public List<User> getUserByUsername(String username) {
        String SQL = "SELECT * FROM userinfo WHERE username = ?";
        return this.query(SQL, new Object[]{username}, new UserMapper());
    }

    public void createUser(String phone, String password) {
        TransactionDefinition tdf = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(tdf);
        try {
            String username = "jflh_" + phone;
            String SQL = "INSERT INTO userinfo(phone, username, password) VALUES (?,?,?)";
            this.update(SQL, phone, username, password);
            transactionManager.commit(status);
        } catch (DataAccessException e) {
            System.out.println("Error in creating user, rolling back");
            transactionManager.rollback(status);
            throw e;
        }
    }
}
