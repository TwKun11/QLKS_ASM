package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.KhachSan;
import model.Phong;

public class DAOKhachSan implements IDAOKhachSan {
    // Các hằng số query SQL
    private static final String SELECT_ALL_KHACHSAN = 
            "select K.Id as Id, K.Ten as Ten, DiaChi, SoDienThoai, CachTrungTam, K.MoTa, GiapBien, " +
            "DanhGia, BuaAn, IdThanhPho, T.Ten as TenThanhPho, IdLoaiKhachSan, L.Ten as TenLoaiKhachSan, " +
            "T.UrlHinhAnh from KhachSan K, ThanhPho T, LoaiKhachSan L " +
            "where K.IdThanhPho = T.Id and K.IdLoaiKhachSan = L.Id";
    
    private static final String SELECT_GOOD_RATE_KHACHSAN = 
            "SELECT K.Id, K.Ten, K.DiaChi, K.SoDienThoai, K.CachTrungTam, K.MoTa, K.GiapBien, " +
            "K.DanhGia, K.BuaAn, K.IdThanhPho, T.Ten AS TenThanhPho, K.IdLoaiKhachSan, " +
            "L.Ten AS TenLoaiKhachSan, T.UrlHinhAnh FROM KhachSan K " +
            "JOIN ThanhPho T ON K.IdThanhPho = T.Id " +
            "JOIN LoaiKhachSan L ON K.IdLoaiKhachSan = L.Id WHERE K.DanhGia = 5";
    
    private static final String INSERT_KHACHSAN = 
            "insert into KhachSan output inserted.Id values(?,?,?,?,?,?,?,?,?,?)";
    
    private static final String SELECT_BY_ID = 
            "SELECT * FROM KhachSan WHERE Id = ?";
    
    private static final String COUNT_BY_LOAI = 
            "SELECT COUNT(*) FROM KhachSan WHERE IdLoaiKhachSan IN " +
            "(SELECT Id FROM LoaiKhachSan WHERE Ten = ?)";
    
    private static final String UPDATE_KHACHSAN = 
            "update KhachSan set Ten=?, DiaChi=?, SoDienThoai=?, CachTrungTam=?, MoTa=?, " +
            "GiapBien=?, DanhGia=?, BuaAn=?, IdThanhPho=?, IdLoaiKhachSan=? where Id=?";
    
    private static final String DELETE_KHACHSAN = 
            "delete from KhachSan where id=?";
    
    private static final String SELECT_BY_FILTER_BASE = 
            "SELECT ks.*, lks.Ten AS tenLoaiKhachSan FROM KhachSan ks " +
            "JOIN LoaiKhachSan lks ON ks.IdLoaiKhachSan = lks.Id WHERE 1=1";
    
    private static final String SELECT_KHACHSAN_DETAILS = 
            "SELECT K.Id AS KhachSanId, K.Ten AS TenKhachSan, K.DiaChi AS DiaChi, " +
            "K.SoDienThoai AS SoDienThoai, K.CachTrungTam AS CachTrungTam, K.MoTa AS MoTaKhachSan, " +
            "K.GiapBien AS GiapBien, K.DanhGia AS DanhGia, K.BuaAn AS BuaAn, T.Ten AS TenThanhPho, " +
            "L.Ten AS TenLoaiKhachSan, T.UrlHinhAnh AS UrlHinhAnhThanhPho, P.Id AS PhongId, " +
            "P.Ten AS TenPhong, P.DienTich AS DienTichPhong, P.GiaThue AS GiaThuePhong, " +
            "P.TienNghi AS TienNghiPhong, P.MoTa AS MoTaPhong, P.LoaiGiuong AS LoaiGiuong " +
            "FROM KhachSan K JOIN ThanhPho T ON K.IdThanhPho = T.Id " +
            "JOIN LoaiKhachSan L ON K.IdLoaiKhachSan = L.Id " +
            "LEFT JOIN Phong P ON K.Id = P.IdKhachSan WHERE K.Id = ?";
    
    private static final String SELECT_BY_NAME = 
            "SELECT * FROM KhachSan WHERE Ten = ?";

    private static Connection con;

    @Override
    public ArrayList<KhachSan> getAll() {
        ArrayList<KhachSan> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_ALL_KHACHSAN);
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

    @Override
    public ArrayList<KhachSan> getKhachSanGoodRate() {
        ArrayList<KhachSan> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_GOOD_RATE_KHACHSAN);
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

    @Override
    public boolean insert(KhachSan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(INSERT_KHACHSAN);
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

    @Override
    public KhachSan getById(int id) {
        KhachSan ks = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_ID);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                ks = new KhachSan();
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
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ks;
    }

    @Override
    public int countByLoaiKhachSan(String tenLoaiKhachSan) {
        int count = 0;
        try (Connection con = SQLConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(COUNT_BY_LOAI)) {
            ps.setString(1, tenLoaiKhachSan);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public boolean update(KhachSan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(UPDATE_KHACHSAN);
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

    @Override
    public boolean delete(int id) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(DELETE_KHACHSAN);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public List<KhachSan> getKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, 
            Boolean giapBien, Integer idThanhPho, int page, int pageSize) throws SQLException {
        List<KhachSan> list = new ArrayList<>();
        Connection conn = SQLConnection.getConnection();
        String sql = SELECT_BY_FILTER_BASE;
        
        if (loaiKhachSan != null) sql += " AND ks.IdLoaiKhachSan = ?";
        if (danhGia != null) sql += " AND ks.DanhGia = ?";
        if (giapBien != null) sql += " AND ks.GiapBien = ?";
        if (idThanhPho != null) sql += " AND ks.IdThanhPho = ?";
        sql += " ORDER BY ks.Id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (loaiKhachSan != null) ps.setInt(index++, loaiKhachSan);
            if (danhGia != null) ps.setInt(index++, danhGia);
            if (giapBien != null) ps.setBoolean(index++, giapBien);
            if (idThanhPho != null) ps.setInt(index++, idThanhPho);
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
                ks.setTenLoaiKhachSan(rs.getString("tenLoaiKhachSan"));
                list.add(ks);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, 
            Boolean giapBien, Integer idThanhPho) throws SQLException {
        Connection conn = SQLConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM KhachSan WHERE 1=1";

        if (loaiKhachSan != null) sql += " AND IdLoaiKhachSan = ?";
        if (danhGia != null) sql += " AND DanhGia = ?";
        if (giapBien != null) sql += " AND GiapBien = ?";
        if (idThanhPho != null) sql += " AND IdThanhPho = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (loaiKhachSan != null) ps.setInt(index++, loaiKhachSan);
            if (danhGia != null) ps.setInt(index++, danhGia);
            if (giapBien != null) ps.setBoolean(index++, giapBien);
            if (idThanhPho != null) ps.setInt(index++, idThanhPho);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public KhachSan getKhachSanById(int id) {
        KhachSan khachSan = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_KHACHSAN_DETAILS);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            List<Phong> phongList = new ArrayList<>();

            while (rs.next()) {
                if (khachSan == null) {
                    khachSan = new KhachSan();
                    khachSan.setId(rs.getInt("KhachSanId"));
                    khachSan.setTen(rs.getString("TenKhachSan"));
                    khachSan.setDiaChi(rs.getString("DiaChi"));
                    khachSan.setSoDienThoai(rs.getString("SoDienThoai"));
                    khachSan.setCachTrungTam(rs.getInt("CachTrungTam"));
                    khachSan.setMoTa(rs.getString("MoTaKhachSan"));
                    khachSan.setGiapBien(rs.getBoolean("GiapBien"));
                    khachSan.setDanhGia(rs.getInt("DanhGia"));
                    khachSan.setBuaAn(rs.getInt("BuaAn"));
                    khachSan.setTenThanhPho(rs.getString("TenThanhPho"));
                    khachSan.setTenLoaiKhachSan(rs.getString("TenLoaiKhachSan"));
                    khachSan.setUrlHinhAnhThanhPho(rs.getString("UrlHinhAnhThanhPho"));
                }

                int phongId = rs.getInt("PhongId");
                if (phongId != 0) {
                    Phong phong = new Phong();
                    phong.setId(phongId);
                    phong.setTen(rs.getString("TenPhong"));
                    phong.setDienTich((int) rs.getDouble("DienTichPhong"));
                    phong.setGiaThue((int) rs.getDouble("GiaThuePhong"));
                    phong.setTienNghi(rs.getString("TienNghiPhong"));
                    phong.setMoTa(rs.getString("MoTaPhong"));
                    phong.setLoaiGiuong(rs.getInt("LoaiGiuong"));
                    phongList.add(phong);
                }
            }

            if (khachSan != null) khachSan.setPhongList(phongList);
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return khachSan;
    }

    @Override
    public KhachSan getByName(String name) {
        KhachSan ks = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_NAME);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                ks = new KhachSan();
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
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ks;
    }

    @Override
    public List<KhachSan> searchKhachSan(String keyword) throws SQLException {
        List<KhachSan> list = new ArrayList<>();
        String sql = "SELECT ks.*, tp.Ten AS TenThanhPho "
                   + "FROM KhachSan ks "
                   + "JOIN ThanhPho tp ON ks.IdThanhPho = tp.Id "
                   + "WHERE ks.Ten LIKE ? OR tp.Ten LIKE ?";

        try (Connection conn = SQLConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
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
                    ks.setTenThanhPho(rs.getString("TenThanhPho")); // Thêm tên thành phố vào model

                    list.add(ks);
                }
            }
        }
        return list;
    }
    
}