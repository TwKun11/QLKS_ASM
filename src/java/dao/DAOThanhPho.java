package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.ThanhPho;

public class DAOThanhPho implements IThanhPhoDAO {
    // Các hằng số query SQL
    private static final String SELECT_ALL_THANHPHO = 
            "select T.Id as A, T.Ten as B, T.MoTa as C, T.UrlHinhAnh as D, " +
            "count(K.Id) as E from ThanhPho T left join KhachSan K " +
            "on T.Id = K.IdThanhPho group by T.Id, T.Ten, T.MoTa, T.UrlHinhAnh";
    
    private static final String INSERT_THANHPHO = 
            "insert into ThanhPho output inserted.Id values(?,?,?)";
    
    private static final String UPDATE_THANHPHO = 
            "update ThanhPho set Ten=?, MoTa=?, UrlHinhAnh=? where Id=?";
    
    private static final String DELETE_THANHPHO = 
            "delete from ThanhPho where Id=?";
    
    private static final String SELECT_BY_NAME = 
            "SELECT Id, Ten, MoTa, UrlHinhAnh FROM ThanhPho WHERE Ten = ?";

    private static Connection con;

    @Override
    public ArrayList<ThanhPho> getAll() {
        ArrayList<ThanhPho> list = new ArrayList();
        try {
            con = SQLConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_ALL_THANHPHO);
            while (rs.next()) {
                ThanhPho tmp = new ThanhPho();
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
    public boolean insert(ThanhPho tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(INSERT_THANHPHO);
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
    public boolean update(ThanhPho tmp) {
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(UPDATE_THANHPHO);
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
            PreparedStatement stmt = con.prepareStatement(DELETE_THANHPHO);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @Override
    public ThanhPho getByName(String ten) {
        ThanhPho thanhPho = null;
        try {
            con = SQLConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(SELECT_BY_NAME);
            stmt.setString(1, ten);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                thanhPho = new ThanhPho();
                thanhPho.setId(rs.getInt("Id"));
                thanhPho.setTen(rs.getString("Ten"));
                thanhPho.setMoTa(rs.getString("MoTa"));
                thanhPho.setUrlHinhAnh(rs.getString("UrlHinhAnh"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return thanhPho;
    }
}