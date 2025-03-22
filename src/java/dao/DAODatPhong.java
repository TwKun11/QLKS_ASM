package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Statement;
import java.util.ArrayList;
import model.DatPhong;

public class DAODatPhong implements IDAODatPhong {

    private static Connection con;

    // Các query được đưa lên trên
    private static final String GET_ALL_QUERY = "select * from DatPhong";
    private static final String INSERT_QUERY = "insert into DatPhong output inserted.Id values(?,?,?,?,?,?,?,?,?)";
    private static final String CHECK_ROOM_QUERY
            = "SELECT COUNT(*) FROM DatPhong WHERE IdPhong = ? AND ? < NgayTra AND ? > NgayDen AND DaHuy = 0";
    private static final String UPDATE_QUERY = "update DatPhong set DaHuy=? where Id=?";
    private static final String COUNT_BOOKED_ROOMS_QUERY = "SELECT COUNT(*) FROM DatPhong";

    public int getBookedRoomCount() {
        int count = 0;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(COUNT_BOOKED_ROOMS_QUERY);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public ArrayList<DatPhong> getAll() {
        ArrayList<DatPhong> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(GET_ALL_QUERY);
            while (rs.next()) {
                DatPhong tmp = new DatPhong();
                tmp.setId(rs.getInt("Id"));
                tmp.setTaiKhoan(rs.getString("TaiKhoan"));
                tmp.setIdPhong(rs.getInt("IdPhong"));
                tmp.setNgayDat(rs.getDate("NgayDat"));
                tmp.setNgayDen(rs.getDate("NgayDen"));
                tmp.setNgayTra(rs.getDate("NgayTra"));
                tmp.setDichVu(rs.getString("DichVu"));
                tmp.setGhiChu(rs.getString("GhiChu"));
                tmp.setThanhTien(rs.getInt("ThanhTien"));
                tmp.setDaHuy(rs.getBoolean("DaHuy"));
                list.add(tmp);
            }
            con.close();
        } catch (Exception e) {
        }
        return list;
    }

    @Override
    public boolean insert(DatPhong tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(INSERT_QUERY);
            stmt.setString(1, tmp.getTaiKhoan());
            stmt.setInt(2, tmp.getIdPhong());
            stmt.setDate(3, new java.sql.Date(tmp.getNgayDat().getTime()));
            stmt.setDate(4, new java.sql.Date(tmp.getNgayDen().getTime()));
            stmt.setDate(5, new java.sql.Date(tmp.getNgayTra().getTime()));
            stmt.setString(6, tmp.getDichVu());
            stmt.setString(7, tmp.getGhiChu());
            stmt.setInt(8, tmp.getThanhTien());
            stmt.setBoolean(9, tmp.isDaHuy());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                tmp.setId(rs.getInt("Id"));
            }
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public boolean checkRoomAvailability(int idPhong, String ngayDen, String ngayTra) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(CHECK_ROOM_QUERY);
            stmt.setInt(1, idPhong);
            stmt.setString(2, ngayDen);
            stmt.setString(3, ngayTra);
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Phòng đã được đặt
            }
            con.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(int id) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY);
            stmt.setBoolean(1, true);
            stmt.setInt(2, id);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public boolean update(DatPhong datPhong) {
        String UPDATE_QUERY = "UPDATE DatPhong SET TaiKhoan = ?, IdPhong = ?, NgayDat = ?, NgayDen = ?, NgayTra = ?, DichVu = ?, GhiChu = ?, ThanhTien = ? WHERE Id = ?";
        try {
            con = SQLConnection.getConnection(); // Kết nối đến cơ sở dữ liệu
            PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY);

            // Đặt các giá trị cho câu lệnh SQL
            stmt.setString(1, datPhong.getTaiKhoan());
            stmt.setInt(2, datPhong.getIdPhong());
            stmt.setDate(3, new java.sql.Date(datPhong.getNgayDat().getTime()));
            stmt.setDate(4, new java.sql.Date(datPhong.getNgayDen().getTime()));
            stmt.setDate(5, new java.sql.Date(datPhong.getNgayTra().getTime()));
            stmt.setString(6, datPhong.getDichVu());
            stmt.setString(7, datPhong.getGhiChu());
            stmt.setInt(8, datPhong.getThanhTien());
            stmt.setInt(9, datPhong.getId());

            // Thực thi câu lệnh SQL
            int rowsAffected = stmt.executeUpdate();
            con.close();

            // Kiểm tra xem có dòng nào bị ảnh hưởng không
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String REMOVE_QUERY = "DELETE FROM DatPhong WHERE Id = ?";
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(REMOVE_QUERY);
            stmt.setInt(1, id);

            int rowsAffected = stmt.executeUpdate();
            con.close();

            // Kiểm tra xem có dòng nào bị ảnh hưởng không
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public ArrayList<DatPhong> getAllByUser(String username) {
        if (username == null || username.trim().isEmpty()) {
            return new ArrayList<>();
        }

        ArrayList<DatPhong> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = SQLConnection.getConnection();
            String sql = "SELECT * FROM DatPhong WHERE TaiKhoan = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DatPhong tmp = new DatPhong();
                tmp.setId(rs.getInt("Id"));
                tmp.setTaiKhoan(rs.getString("TaiKhoan"));
                tmp.setIdPhong(rs.getInt("IdPhong"));
                tmp.setNgayDat(rs.getDate("NgayDat"));
                tmp.setNgayDen(rs.getDate("NgayDen"));
                tmp.setNgayTra(rs.getDate("NgayTra"));
                tmp.setDichVu(rs.getString("DichVu"));
                tmp.setGhiChu(rs.getString("GhiChu"));
                tmp.setThanhTien(rs.getInt("ThanhTien"));
                tmp.setDaHuy(rs.getBoolean("DaHuy"));
                list.add(tmp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public int getMostBookedRoom() {
        int mostBookedRoomId = 0;
        try {
            con = SQLConnection.getConnection();
            String sql = "SELECT TOP 1 IdPhong FROM DatPhong GROUP BY IdPhong ORDER BY COUNT(*) DESC";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                mostBookedRoomId = rs.getInt("IdPhong");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mostBookedRoomId;
    }

    public int getTotalRevenue() {
        int totalRevenue = 0;
        try {
            con = SQLConnection.getConnection();
            String sql = "SELECT SUM(ThanhTien) AS TotalRevenue FROM DatPhong WHERE DaHuy = 0";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getInt("TotalRevenue");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }

    @Override
    public DatPhong getByID(int id) {
        DatPhong datPhong = null;
        try {
            con = SQLConnection.getConnection();
            String sql = "SELECT * FROM DatPhong WHERE Id = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                datPhong = new DatPhong();
                datPhong.setId(rs.getInt("Id"));
                datPhong.setTaiKhoan(rs.getString("TaiKhoan"));
                datPhong.setIdPhong(rs.getInt("IdPhong"));
                datPhong.setNgayDat(rs.getDate("NgayDat"));
                datPhong.setNgayDen(rs.getDate("NgayDen"));
                datPhong.setNgayTra(rs.getDate("NgayTra"));
                datPhong.setDichVu(rs.getString("DichVu"));
                datPhong.setGhiChu(rs.getString("GhiChu"));
                datPhong.setThanhTien(rs.getInt("ThanhTien"));
                datPhong.setDaHuy(rs.getBoolean("DaHuy"));
            }

            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return datPhong;
    }

}
