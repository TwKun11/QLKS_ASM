package service;

import java.sql.SQLException;
import java.util.ArrayList;
import dao.DAOTaiKhoan;
import dao.ITaiKhoanDAO;
import model.TaiKhoan;

public class TaiKhoanService {
    private final DAOTaiKhoan daoTaiKhoan;

    public TaiKhoanService() {
        this.daoTaiKhoan = new DAOTaiKhoan();
    }

    public ArrayList<TaiKhoan> getAll() {
        return daoTaiKhoan.getAll();
    }

    public TaiKhoan getByDangNhap(String tenTaiKhoan, String matKhau) {
        return daoTaiKhoan.getByDangNhap(tenTaiKhoan, matKhau);
    }

    public boolean insert(TaiKhoan taiKhoan) {
        return daoTaiKhoan.insert(taiKhoan);
    }

    public boolean update(TaiKhoan taiKhoan) {
        return daoTaiKhoan.update(taiKhoan);
    }

    public boolean delete(String tenTaiKhoan) {
        return daoTaiKhoan.delete(tenTaiKhoan);
    }

    public TaiKhoan getByTenTaiKhoan(String tenTaiKhoan) throws SQLException {
        return daoTaiKhoan.getByTenTaiKhoan(tenTaiKhoan);
    }

    public boolean checkPassword(String username, String password) {
        return daoTaiKhoan.checkPassword(username, password);
    }

    public boolean updatePassword(String username, String newPassword) {
        return daoTaiKhoan.updatePassword(username, newPassword);
    }

    public TaiKhoan getByEmail(String email) {
        return daoTaiKhoan.getByEmail(email);
    }

    public int getTotalTaiKhoan() {
        return daoTaiKhoan.getTotalTaiKhoan();
    }
}