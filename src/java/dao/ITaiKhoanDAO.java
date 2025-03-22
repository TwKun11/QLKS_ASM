/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.TaiKhoan;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public interface ITaiKhoanDAO {

    ArrayList<TaiKhoan> getAll();

    TaiKhoan getByDangNhap(String tenTaiKhoan, String matKhau);

    boolean insert(TaiKhoan tmp);

    boolean update(TaiKhoan tmp);

    boolean delete(String tenTaiKhoan);

    TaiKhoan getByTenTaiKhoan(String tenTaiKhoan) throws SQLException;

    boolean updatePassword(String username, String newPassword);

    boolean checkPassword(String username, String password);
    
    TaiKhoan getByEmail(String email);
}
