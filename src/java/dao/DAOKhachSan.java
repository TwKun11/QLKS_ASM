package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.KhachSan;

public class DAOKhachSan {

    private static Connection con;

    public static ArrayList<KhachSan> getAll() {
        ArrayList<KhachSan> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select K.Id as Id, K.Ten as Ten, DiaChi,"
                    + "SoDienThoai, CachTrungTam, K.MoTa, GiapBien, DanhGia, BuaAn, IdThanhPho,"
                    + "T.Ten as TenThanhPho, IdLoaiKhachSan, L.Ten as TenLoaiKhachSan, T.UrlHinhAnh from KhachSan K, ThanhPho T,"
                    + "LoaiKhachSan L where K.IdThanhPho = T.Id and K.IdLoaiKhachSan = L.Id");
            while (rs.next()) {
                KhachSan tmp = new KhachSan();
                tmp.setId(rs.getInt("Id"));
                tmp.setTen(rs.getString("Ten"));
                tmp.setDiaChi(rs.getString("DiaChi"));
                tmp.setSoDienThoai(rs.getString("SoDienThoai"));
                tmp.setCachTrungTam(rs.getInt("CachTrungTam"));
                tmp.setMoTa(rs.getString("MoTa"));
                tmp.setGiapBien(rs.getBoolean("GiapBien"));
                tmp.setDanhGia(rs.getInt("DanhGia"));
                tmp.setBuaAn(rs.getInt("BuaAn"));
                tmp.setIdThanhPho(rs.getInt("IdThanhPho"));
                tmp.setTenThanhPho(rs.getString("TenThanhPho"));
                tmp.setIdLoaiKhachSan(rs.getInt("IdLoaiKhachSan"));
                tmp.setTenLoaiKhachSan(rs.getString("TenLoaiKhachSan"));
                tmp.setUrlHinhAnhThanhPho(rs.getString("UrlHinhAnh"));
                list.add(tmp);
            }
            con.close();
        } catch (Exception e) {
        }
        return list;
    }

    public static ArrayList<KhachSan> getKhachSanGoodRate() {
        ArrayList<KhachSan> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            String sql = "SELECT K.Id, K.Ten, K.DiaChi, K.SoDienThoai, K.CachTrungTam, "
                    + "K.MoTa, K.GiapBien, K.DanhGia, K.BuaAn, K.IdThanhPho, "
                    + "T.Ten AS TenThanhPho, K.IdLoaiKhachSan, L.Ten AS TenLoaiKhachSan, T.UrlHinhAnh "
                    + "FROM KhachSan K "
                    + "JOIN ThanhPho T ON K.IdThanhPho = T.Id "
                    + "JOIN LoaiKhachSan L ON K.IdLoaiKhachSan = L.Id "
                    + "WHERE K.DanhGia = 5";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                KhachSan tmp = new KhachSan();
                tmp.setId(rs.getInt("Id"));
                tmp.setTen(rs.getString("Ten"));
                tmp.setDiaChi(rs.getString("DiaChi"));
                tmp.setSoDienThoai(rs.getString("SoDienThoai"));
                tmp.setCachTrungTam(rs.getInt("CachTrungTam"));
                tmp.setMoTa(rs.getString("MoTa"));
                tmp.setGiapBien(rs.getBoolean("GiapBien"));
                tmp.setDanhGia(rs.getInt("DanhGia"));
                tmp.setBuaAn(rs.getInt("BuaAn"));
                tmp.setIdThanhPho(rs.getInt("IdThanhPho"));
                tmp.setTenThanhPho(rs.getString("TenThanhPho"));
                tmp.setIdLoaiKhachSan(rs.getInt("IdLoaiKhachSan"));
                tmp.setTenLoaiKhachSan(rs.getString("TenLoaiKhachSan"));
                tmp.setUrlHinhAnhThanhPho(rs.getString("UrlHinhAnh"));
                list.add(tmp);
            }
            con.close();
        } catch (Exception e) {
        }
        return list;
    }

    public static boolean insert(KhachSan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement("insert into KhachSan output inserted.Id values(?,?,?,?,?,?,?,?,?,?)");
            stmt.setString(1, tmp.getTen());
            stmt.setString(2, tmp.getDiaChi());
            stmt.setString(3, tmp.getSoDienThoai());
            stmt.setInt(4, tmp.getCachTrungTam());
            stmt.setString(5, tmp.getMoTa());
            stmt.setBoolean(6, tmp.isGiapBien());
            stmt.setInt(7, tmp.getDanhGia());
            stmt.setInt(8, tmp.getBuaAn());
            stmt.setInt(9, tmp.getIdThanhPho());
            stmt.setInt(10, tmp.getIdLoaiKhachSan());
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

    public static boolean update(KhachSan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement("update KhachSan set Ten=?, DiaChi=?, SoDienThoai=?, CachTrungTam=?, MoTa=?, GiapBien=?, DanhGia=?, BuaAn=?, IdThanhPho=?, IdLoaiKhachSan=? where Id=?");
            stmt.setString(1, tmp.getTen());
            stmt.setString(2, tmp.getDiaChi());
            stmt.setString(3, tmp.getSoDienThoai());
            stmt.setInt(4, tmp.getCachTrungTam());
            stmt.setString(5, tmp.getMoTa());
            stmt.setBoolean(6, tmp.isGiapBien());
            stmt.setInt(7, tmp.getDanhGia());
            stmt.setInt(8, tmp.getBuaAn());
            stmt.setInt(9, tmp.getIdThanhPho());
            stmt.setInt(10, tmp.getIdLoaiKhachSan());
            stmt.setInt(11, tmp.getId());
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static boolean delete(int id) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement("delete from KhachSan where id=?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static List<KhachSan> getKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, Boolean giapBien, Integer idThanhPho, int page, int pageSize) throws SQLException {
        List<KhachSan> list = new ArrayList<>();
        Connection conn = SQLConnection.getConnection();

        // Sử dụng JOIN để lấy tên loại khách sạn
        String sql = "SELECT ks.*, lks.Ten AS tenLoaiKhachSan "
                + "FROM KhachSan ks "
                + "JOIN LoaiKhachSan lks ON ks.IdLoaiKhachSan = lks.Id "
                + "WHERE 1=1";

        if (loaiKhachSan != null) {
            sql += " AND ks.IdLoaiKhachSan = ?";
        }
        if (danhGia != null) {
            sql += " AND ks.DanhGia = ?";
        }
        if (giapBien != null) {
            sql += " AND ks.GiapBien = ?";
        }
        if (idThanhPho != null) {
            sql += " AND ks.IdThanhPho = ?";
        }

        // Thêm phân trang
        sql += " ORDER BY ks.Id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;

            if (loaiKhachSan != null) {
                ps.setInt(index++, loaiKhachSan);
            }
            if (danhGia != null) {
                ps.setInt(index++, danhGia);
            }
            if (giapBien != null) {
                ps.setBoolean(index++, giapBien);
            }
            if (idThanhPho != null) {
                ps.setInt(index++, idThanhPho);
            }

            // Tính toán OFFSET và FETCH NEXT
            int offset = (page - 1) * pageSize;
            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                KhachSan ks = new KhachSan();
                ks.setId(rs.getInt("Id"));
                ks.setTen(rs.getString("Ten"));
                ks.setDiaChi(rs.getString("DiaChi"));
                ks.setSoDienThoai(rs.getString("SoDienThoai"));
                ks.setCachTrungTam(rs.getInt("CachTrungTam"));
                ks.setMoTa(rs.getString("MoTa"));
                ks.setGiapBien(rs.getBoolean("GiapBien"));
                ks.setDanhGia(rs.getInt("DanhGia"));
                ks.setBuaAn(rs.getInt("BuaAn"));
                ks.setIdThanhPho(rs.getInt("IdThanhPho"));
                ks.setIdLoaiKhachSan(rs.getInt("IdLoaiKhachSan"));
                ks.setTenLoaiKhachSan(rs.getString("tenLoaiKhachSan")); // Thêm tên loại khách sạn

                list.add(ks);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int countKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, Boolean giapBien, Integer idThanhPho) throws SQLException {
        Connection conn = SQLConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM KhachSan WHERE 1=1";

        if (loaiKhachSan != null) {
            sql += " AND IdLoaiKhachSan = ?";
        }
        if (danhGia != null) {
            sql += " AND DanhGia = ?";
        }
        if (giapBien != null) {
            sql += " AND GiapBien = ?";
        }
        if (idThanhPho != null) {
            sql += " AND IdThanhPho = ?";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (loaiKhachSan != null) {
                ps.setInt(index++, loaiKhachSan);
            }
            if (danhGia != null) {
                ps.setInt(index++, danhGia);
            }
            if (giapBien != null) {
                ps.setBoolean(index++, giapBien);
            }
            if (idThanhPho != null) {
                ps.setInt(index++, idThanhPho);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
