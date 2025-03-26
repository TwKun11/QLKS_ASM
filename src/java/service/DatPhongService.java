package service;

import dao.DAODatPhong;
import dao.DAODatPhong;
import model.DatPhong;

import java.util.ArrayList;

public class DatPhongService {
    private final DAODatPhong daoDatPhong;

    public DatPhongService() {
        this.daoDatPhong = new DAODatPhong();
    }

    public int getBookedRoomCount() {
        return daoDatPhong.getBookedRoomCount();
    }

    public ArrayList<DatPhong> getAll() {
        return daoDatPhong.getAll();
    }

    public boolean insert(DatPhong datPhong) {
        return daoDatPhong.insert(datPhong);
    }

    public boolean checkRoomAvailability(int idPhong, String ngayDen, String ngayTra) {
        return daoDatPhong.checkRoomAvailability(idPhong, ngayDen, ngayTra);
    }

    public boolean update(int id) {
        return daoDatPhong.update(id);
    }

    public boolean update(DatPhong datPhong) {
        return daoDatPhong.update(datPhong);
    }

    public boolean delete(int id) {
        return daoDatPhong.delete(id);
    }

    public ArrayList<DatPhong> getAllByUser(String username) {
        return daoDatPhong.getAllByUser(username);
    }

    public int getMostBookedRoom() {
        return daoDatPhong.getMostBookedRoom();
    }

    public int getTotalRevenue() {
        return daoDatPhong.getTotalRevenue();
    }

    public DatPhong getByID(int id) {
        return daoDatPhong.getByID(id);
    }
}