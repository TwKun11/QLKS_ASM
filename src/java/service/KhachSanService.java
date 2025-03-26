package service;

import java.sql.SQLException;
import java.util.List;
import dao.DAOKhachSan;
import dao.IDAOKhachSan;
import model.KhachSan;

public class KhachSanService {
    private final IDAOKhachSan daoKhachSan;

    public KhachSanService() {
        this.daoKhachSan = new DAOKhachSan();
    }

    public List<KhachSan> getAll() {
        return daoKhachSan.getAll();
    }

    public List<KhachSan> getKhachSanGoodRate() {
        return daoKhachSan.getKhachSanGoodRate();
    }

    public boolean insert(KhachSan khachSan) {
        return daoKhachSan.insert(khachSan);
    }

    public KhachSan getById(int id) {
        return daoKhachSan.getKhachSanById(id);
    }

    public int countByLoaiKhachSan(String tenLoaiKhachSan) {
        return daoKhachSan.countByLoaiKhachSan(tenLoaiKhachSan);
    }

    public boolean update(KhachSan khachSan) {
        return daoKhachSan.update(khachSan);
    }

    public boolean delete(int id) {
        return daoKhachSan.delete(id);
    }

    public List<KhachSan> getKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, 
            Boolean giapBien, Integer idThanhPho, int page, int pageSize) throws SQLException {
        return daoKhachSan.getKhachSanByFilter(loaiKhachSan, danhGia, giapBien, idThanhPho, page, pageSize);
    }

    public int countKhachSanByFilter(Integer loaiKhachSan, Integer danhGia, 
            Boolean giapBien, Integer idThanhPho) throws SQLException {
        return daoKhachSan.countKhachSanByFilter(loaiKhachSan, danhGia, giapBien, idThanhPho);
    }

    public KhachSan getByName(String name) {
        return daoKhachSan.getByName(name);
    }

    public List<KhachSan> searchKhachSan(String keyword) throws SQLException {
        return daoKhachSan.searchKhachSan(keyword);
    }
}