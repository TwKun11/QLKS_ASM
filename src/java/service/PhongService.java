package service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import dao.DAOPhong;
import dao.IPhongDAO;
import model.Phong;

public class PhongService {
    private final IPhongDAO daoPhong;

    public PhongService() {
        this.daoPhong = new DAOPhong();
    }

    public ArrayList<Phong> getAll() {
        return daoPhong.getAll();
    }

    public boolean insert(Phong phong) {
        return daoPhong.insert(phong);
    }

    public boolean update(Phong phong) {
        return daoPhong.update(phong);
    }

    public boolean delete(int id) {
        return daoPhong.delete(id);
    }

    public List<Phong> layPhongTrong(int idKhachSan, Date ngayDen, Date ngayTra) {
        return daoPhong.layPhongTrong(idKhachSan, ngayDen, ngayTra);
    }

    public Phong getById(int id) {
        return daoPhong.getById(id);
    }
}