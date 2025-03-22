package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.LoaiKhachSan;

// Interface định nghĩa các phương thức
interface ILoaiKhachSanDAO {
    ArrayList<LoaiKhachSan> getAll();
    boolean insert(LoaiKhachSan tmp);
    boolean update(LoaiKhachSan tmp);
    boolean delete(int id);
    LoaiKhachSan getById(int id);
    LoaiKhachSan getByName(String ten);
}