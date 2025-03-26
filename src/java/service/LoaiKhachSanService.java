package service;

import java.util.ArrayList;
import dao.DAOLoaiKhachSan;
import model.LoaiKhachSan;

public class LoaiKhachSanService {
    private final DAOLoaiKhachSan daoLoaiKhachSan;

    public LoaiKhachSanService() {
        this.daoLoaiKhachSan = new DAOLoaiKhachSan();
    }

    public ArrayList<LoaiKhachSan> getAll() {
        return daoLoaiKhachSan.getAll();
    }

    public boolean insert(LoaiKhachSan loaiKhachSan) {
        return daoLoaiKhachSan.insert(loaiKhachSan);
    }

    public boolean update(LoaiKhachSan loaiKhachSan) {
        return daoLoaiKhachSan.update(loaiKhachSan);
    }

    public boolean delete(int id) {
        return daoLoaiKhachSan.delete(id);
    }

    public LoaiKhachSan getById(int id) {
        return daoLoaiKhachSan.getById(id);
    }

    public LoaiKhachSan getByName(String ten) {
        return daoLoaiKhachSan.getByName(ten);
    }
}