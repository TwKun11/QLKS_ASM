package dao;

import java.util.ArrayList;
import model.DatPhong;

public interface IDAODatPhong {

    ArrayList<DatPhong> getAll();

    boolean insert(DatPhong tmp);

    boolean checkRoomAvailability(int idPhong, String ngayDen, String ngayTra);

    boolean update(int id);

    boolean delete(int id);

    ArrayList<DatPhong> getAllByUser(String username);

    DatPhong getByID(int id);
}
