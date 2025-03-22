package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.LoaiKhachSan;

public class DAOLoaiKhachSan implements ILoaiKhachSanDAO {
    // Các hằng số query SQL
    private static final String SELECT_ALL_LOAI_KHACHSAN = 
            "select L.Id as A, L.Ten as B, L.MoTa as C, L.UrlHinhAnh as D, " +
            "count(L.Id) as E from LoaiKhachSan L left join KhachSan K " +
            "on L.Id = K.IdLoaiKhachSan group by L.Id, L.Ten, L.MoTa, L.UrlHinhAnh";
    
    private static final String INSERT_LOAI_KHACHSAN = 
            "insert into LoaiKhachSan output inserted.Id values(?,?,?)";
    
    private static final String UPDATE_LOAI_KHACHSAN = 
            "update LoaiKhachSan set Ten=?, MoTa=?, UrlHinhAnh=? where Id=?";
    
    private static final String DELETE_LOAI_KHACHSAN = 
            "delete from LoaiKhachSan where Id=?";
    
    private static final String SELECT_BY_ID = 
            "select Id, Ten, MoTa, UrlHinhAnh from LoaiKhachSan where Id=?";
    
    private static final String SELECT_BY_NAME = 
            "SELECT Id, Ten, MoTa, UrlHinhAnh FROM LoaiKhachSan WHERE Ten = ?";

    private static Connection con;

    @Override
    public ArrayList<LoaiKhachSan> getAll() {
        ArrayList<LoaiKhachSan> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_ALL_LOAI_KHACHSAN);
            while (rs.next()) {
                LoaiKhachSan tmp = new LoaiKhachSan();
                tmp.setId(rs.getInt("A"));
                tmp.setTen(rs.getString("B"));
                tmp.setMoTa(rs.getString("C"));
                tmp.setUrlHinhAnh(rs.getString("D"));
                tmp.setSoKhachSan(rs.getInt("E"));
                list.add(tmp);
            }
            con.close();
        } catch (Exception e) {
        }
        return list;
    }

    @Override
    public boolean insert(LoaiKhachSan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(INSERT_LOAI_KHACHSAN);
            stmt.setString(1, tmp.getTen());
            stmt.setString(2, tmp.getMoTa());
            stmt.setString(3, tmp.getUrlHinhAnh());
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
    public boolean update(LoaiKhachSan tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(UPDATE_LOAI_KHACHSAN);
            stmt.setString(1, tmp.getTen());
            stmt.setString(2, tmp.getMoTa());
            stmt.setString(3, tmp.getUrlHinhAnh());
            stmt.setInt(4, tmp.getId());
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
            PreparedStatement stmt = con.prepareStatement(DELETE_LOAI_KHACHSAN);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public LoaiKhachSan getById(int id) {
        LoaiKhachSan loaiKhachSan = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_ID);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                loaiKhachSan = new LoaiKhachSan();
                loaiKhachSan.setId(rs.getInt("Id"));
                loaiKhachSan.setTen(rs.getString("Ten"));
                loaiKhachSan.setMoTa(rs.getString("MoTa"));
                loaiKhachSan.setUrlHinhAnh(rs.getString("UrlHinhAnh"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return loaiKhachSan;
    }

    @Override
    public LoaiKhachSan getByName(String ten) {
        LoaiKhachSan loaiKhachSan = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_NAME);
            stmt.setString(1, ten);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                loaiKhachSan = new LoaiKhachSan();
                loaiKhachSan.setId(rs.getInt("Id"));
                loaiKhachSan.setTen(rs.getString("Ten"));
                loaiKhachSan.setMoTa(rs.getString("MoTa"));
                loaiKhachSan.setUrlHinhAnh(rs.getString("UrlHinhAnh"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return loaiKhachSan;
    }
}