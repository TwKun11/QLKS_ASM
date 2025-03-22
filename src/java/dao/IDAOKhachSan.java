package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.KhachSan;

public interface IDAOKhachSan {
    ArrayList<KhachSan> getAll();
    ArrayList<KhachSan> getKhachSanGoodRate();
    boolean insert(KhachSan tmp);
    KhachSan getById(int id);
    int countByLoaiKhachSan(String tenLoaiKhachSan);
    boolean update(KhachSan tmp);
    boolean delete(int id);
    List<KhachSan> getKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, Boolean giapBien, Integer idThanhPho, int page, int pageSize) throws SQLException;
    int countKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, Boolean giapBien, Integer idThanhPho) throws SQLException;
    KhachSan getKhachSanById(int id);
    KhachSan getByName(String name);
    List<KhachSan> searchKhachSan(String keyword) throws SQLException;
}