package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.KhachSan;
import model.Phong;

public class DAOPhong implements IPhongDAO {
    // Các hằng số query SQL
    private static final String SELECT_ALL_PHONG = 
            "select P.Id, P.Ten, P.DienTich, P.GiaThue, P.TienNghi, P.MoTa, P.LoaiGiuong, " +
            "P.IdKhachSan, K.Ten as TenKhachSan from Phong P, KhachSan K where P.IdKhachSan=K.Id";
    
    private static final String INSERT_PHONG = 
            "insert into Phong output inserted.Id values(?,?,?,?,?,?,?)";
    
    private static final String UPDATE_PHONG = 
            "update Phong set Ten=?, DienTich=?, GiaThue=?, TienNghi=?, MoTa=?, LoaiGiuong=?, IdKhachSan=? where Id=?";
    
    private static final String DELETE_PHONG = 
            "delete from Phong where id=?";
    
    private static final String SELECT_PHONG_TRONG = 
            "SELECT p.*, ks.Ten AS TenKhachSan, ks.DiaChi, ks.SoDienThoai, ks.DanhGia " +
            "FROM Phong p JOIN KhachSan ks ON p.IdKhachSan = ks.Id " +
            "WHERE p.IdKhachSan = ? AND p.Id NOT IN (" +
            "    SELECT dp.IdPhong FROM DatPhong dp " +
            "    WHERE dp.NgayDen < ? AND dp.NgayTra > ? AND dp.DaHuy = 0)";
    
    private static final String SELECT_BY_ID = 
            "SELECT P.Id, P.Ten, P.DienTich, P.GiaThue, P.TienNghi, P.MoTa, " +
            "P.LoaiGiuong, P.IdKhachSan, K.Ten AS TenKhachSan " +
            "FROM Phong P JOIN KhachSan K ON P.IdKhachSan = K.Id WHERE P.Id = ?";

    private static Connection con;

    @Override
    public ArrayList<Phong> getAll() {
        ArrayList<Phong> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_ALL_PHONG);
            while (rs.next()) {
                Phong tmp = new Phong();
                tmp.setId(rs.getInt("Id"));
                tmp.setTen(rs.getString("Ten"));
                tmp.setDienTich(rs.getInt("DienTich"));
                tmp.setGiaThue(rs.getInt("GiaThue"));
                tmp.setTienNghi(rs.getString("TienNghi"));
                tmp.setMoTa(rs.getString("MoTa"));
                tmp.setLoaiGiuong(rs.getInt("LoaiGiuong"));
                tmp.setIdKhachSan(rs.getInt("IdKhachSan"));
                tmp.setTenKhachSan(rs.getString("TenKhachSan"));
                list.add(tmp);
            }
            con.close();
        } catch (Exception e) {
        }
        return list;
    }

    @Override
    public boolean insert(Phong tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(INSERT_PHONG);
            stmt.setString(1, tmp.getTen());
            stmt.setInt(2, tmp.getDienTich());
            stmt.setInt(3, tmp.getGiaThue());
            stmt.setString(4, tmp.getTienNghi());
            stmt.setString(5, tmp.getMoTa());
            stmt.setInt(6, tmp.getLoaiGiuong());
            stmt.setInt(7, tmp.getIdKhachSan());
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
    public boolean update(Phong tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(UPDATE_PHONG);
            stmt.setString(1, tmp.getTen());
            stmt.setInt(2, tmp.getDienTich());
            stmt.setInt(3, tmp.getGiaThue());
            stmt.setString(4, tmp.getTienNghi());
            stmt.setString(5, tmp.getMoTa());
            stmt.setInt(6, tmp.getLoaiGiuong());
            stmt.setInt(7, tmp.getIdKhachSan());
            stmt.setInt(8, tmp.getId());
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
            PreparedStatement stmt = con.prepareStatement(DELETE_PHONG);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public List<Phong> layPhongTrong(int idKhachSan, Date ngayDen, Date ngayTra) {
        List<Phong> danhSachPhong = new ArrayList<>();
        try {
            Connection con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_PHONG_TRONG);
            stmt.setInt(1, idKhachSan);
            stmt.setDate(2, new java.sql.Date(ngayTra.getTime()));
            stmt.setDate(3, new java.sql.Date(ngayDen.getTime()));

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Phong phong = new Phong();
                phong.setId(rs.getInt("Id"));
                phong.setTen(rs.getString("Ten"));
                phong.setDienTich(rs.getInt("DienTich"));
                phong.setGiaThue(rs.getInt("GiaThue"));
                phong.setTienNghi(rs.getString("TienNghi"));
                phong.setMoTa(rs.getString("MoTa"));
                phong.setLoaiGiuong(rs.getInt("LoaiGiuong"));

                KhachSan khachSan = new KhachSan();
                khachSan.setId(idKhachSan);
                khachSan.setTen(rs.getString("TenKhachSan"));
                khachSan.setDiaChi(rs.getString("DiaChi"));
                khachSan.setSoDienThoai(rs.getString("SoDienThoai"));
                khachSan.setDanhGia(rs.getInt("DanhGia"));
                phong.setKhachSan(khachSan);
                danhSachPhong.add(phong);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return danhSachPhong;
    }

    @Override
    public Phong getById(int id) {
        Phong phong = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_ID);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                phong = new Phong();
                phong.setId(rs.getInt("Id"));
                phong.setTen(rs.getString("Ten"));
                phong.setDienTich(rs.getInt("DienTich"));
                phong.setGiaThue(rs.getInt("GiaThue"));
                phong.setTienNghi(rs.getString("TienNghi"));
                phong.setMoTa(rs.getString("MoTa"));
                phong.setLoaiGiuong(rs.getInt("LoaiGiuong"));
                phong.setIdKhachSan(rs.getInt("IdKhachSan"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return phong;
    }
}