package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.TaiKhoan;

public class DAOTaiKhoan implements ITaiKhoanDAO {

    // Các hằng số query SQL
    private static final String SELECT_ALL_TAIKHOAN
            = "select * from TaiKhoan";

    private static final String SELECT_BY_DANGNHAP
            = "select * from TaiKhoan where TenTaiKhoan=? and MatKhau=?";

    private static final String INSERT_TAIKHOAN
            = "insert into TaiKhoan values(?,?,?,?,?,?,?)";

    private static final String UPDATE_TAIKHOAN
            = "update TaiKhoan set MatKhau=?, HoTen=?, GioiTinh=?, SoDienThoai=?, Email=?, IdRole=? where TenTaiKhoan=?";

    private static final String DELETE_TAIKHOAN
            = "delete from TaiKhoan where TenTaiKhoan=?";

    private static final String SELECT_BY_TENTAIKHOAN
            = "SELECT * FROM TaiKhoan WHERE TenTaiKhoan=?";
    private static final String SELECT_BY_EMAIL = "SELECT * FROM TaiKhoan WHERE Email = ?";
    private static final String GET_TOTAL_TAIKHOAN
            = "SELECT COUNT(*) AS Total FROM TaiKhoan WHERE  IdRole = 2";
    private static Connection con;

    @Override
    public ArrayList<TaiKhoan> getAll() {
        ArrayList<TaiKhoan> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_ALL_TAIKHOAN);
            while (rs.next()) {
                TaiKhoan tmp = new TaiKhoan();
                tmp.setTenTaiKhoan(rs.getString(1));
                tmp.setMatKhau(rs.getString(2));
                tmp.setHoTen(rs.getString(3));
                tmp.setGioiTinh(rs.getBoolean(4));
                tmp.setSoDienThoai(rs.getString(5));
                tmp.setEmail(rs.getString(6));
                tmp.setIdRole(rs.getInt(7));
                list.add(tmp);
            }
            con.close();
        } catch (Exception e) {
        }
        return list;
    }

    @Override
    public TaiKhoan getByDangNhap(String tenTaiKhoan, String matKhau) {
        TaiKhoan tmp = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_DANGNHAP);
            stmt.setString(1, tenTaiKhoan);
            stmt.setString(2, matKhau);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tmp = new TaiKhoan();
                tmp.setTenTaiKhoan(rs.getString(1));
                tmp.setMatKhau(rs.getString(2));
                tmp.setHoTen(rs.getString(3));
                tmp.setGioiTinh(rs.getBoolean(4));
                tmp.setSoDienThoai(rs.getString(5));
                tmp.setEmail(rs.getString(6));
                tmp.setIdRole(rs.getInt(7));

            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return tmp;
    }

    @Override
    public boolean insert(TaiKhoan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(INSERT_TAIKHOAN);
            stmt.setString(1, tmp.getTenTaiKhoan());
            stmt.setString(2, tmp.getMatKhau());
            stmt.setString(3, tmp.getHoTen());
            stmt.setBoolean(4, tmp.isGioiTinh());
            stmt.setString(5, tmp.getSoDienThoai());
            stmt.setString(6, tmp.getEmail());
            stmt.setInt(7, tmp.getIdRole());
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public boolean update(TaiKhoan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(UPDATE_TAIKHOAN);
            stmt.setString(1, tmp.getMatKhau());
            stmt.setString(2, tmp.getHoTen());
            stmt.setBoolean(3, tmp.isGioiTinh());
            stmt.setString(4, tmp.getSoDienThoai());
            stmt.setString(5, tmp.getEmail());
            stmt.setInt(6, tmp.getIdRole());
            stmt.setString(7, tmp.getTenTaiKhoan());
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public boolean delete(String tenTaiKhoan) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(DELETE_TAIKHOAN);
            stmt.setString(1, tenTaiKhoan);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public TaiKhoan getByTenTaiKhoan(String tenTaiKhoan) throws SQLException {
        TaiKhoan tmp = null;
        Connection con = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_TENTAIKHOAN);
            stmt.setString(1, tenTaiKhoan);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                tmp = new TaiKhoan();
                tmp.setTenTaiKhoan(rs.getString(1));
                tmp.setMatKhau(rs.getString(2));
                tmp.setHoTen(rs.getString(3));
                tmp.setGioiTinh(rs.getBoolean(4));
                tmp.setSoDienThoai(rs.getString(5));
                tmp.setEmail(rs.getString(6));
                tmp.setIdRole(rs.getInt(7));
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
        return tmp;
    }

    @Override
    public boolean checkPassword(String username, String password) {
        String sql = "SELECT * FROM TaiKhoan WHERE tenTaiKhoan = ? AND matKhau = ?";
        try (Connection conn = SQLConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password); // Nên hash mật khẩu trong thực tế

            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE TaiKhoan SET matKhau = ? WHERE tenTaiKhoan = ?";
        try (Connection conn = SQLConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword); // Nên hash mật khẩu trong thực tế
            stmt.setString(2, username);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public TaiKhoan getByEmail(String email) {
        TaiKhoan user = null;
        try (Connection con = SQLConnection.getConnection(); PreparedStatement stmt = con.prepareStatement(SELECT_BY_EMAIL)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new TaiKhoan();
                user.setTenTaiKhoan(rs.getString("TenTaiKhoan"));
                user.setMatKhau(rs.getString("MatKhau"));
                user.setHoTen(rs.getString("HoTen"));
                user.setGioiTinh(rs.getBoolean("GioiTinh"));
                user.setSoDienThoai(rs.getString("SoDienThoai"));
                user.setEmail(rs.getString("Email"));
                user.setIdRole(rs.getInt("IdRole"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public int getTotalTaiKhoan() {
        int total = 0;
        try (Connection conn = SQLConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(GET_TOTAL_TAIKHOAN); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("Total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
