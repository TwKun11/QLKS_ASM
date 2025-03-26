package service;

import java.util.ArrayList;
import dao.DAOThanhPho;
import dao.IThanhPhoDAO;
import model.ThanhPho;

public class ThanhPhoService {
    private final IThanhPhoDAO daoThanhPho;

    public ThanhPhoService() {
        this.daoThanhPho = new DAOThanhPho();
    }

    public ArrayList<ThanhPho> getAll() {
        return daoThanhPho.getAll();
    }

    public boolean insert(ThanhPho thanhPho) {
        return daoThanhPho.insert(thanhPho);
    }

    public boolean update(ThanhPho thanhPho) {
        return daoThanhPho.update(thanhPho);
    }

    public boolean delete(int id) {
        return daoThanhPho.delete(id);
    }

    public ThanhPho getByName(String ten) {
        return daoThanhPho.getByName(ten);
    }
}