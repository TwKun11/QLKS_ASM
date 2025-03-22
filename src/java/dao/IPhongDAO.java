/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Phong;

/**
 *
 * @author Admin
 */
public interface IPhongDAO {
    ArrayList<Phong> getAll();
    boolean insert(Phong tmp);
    boolean update(Phong tmp);
    boolean delete(int id);
    List<Phong> layPhongTrong(int idKhachSan, Date ngayDen, Date ngayTra);
    Phong getById(int id);
}
