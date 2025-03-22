/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.ThanhPho;

/**
 *
 * @author Admin
 */
public interface IThanhPhoDAO {
    ArrayList<ThanhPho> getAll();
    boolean insert(ThanhPho tmp);
    boolean update(ThanhPho tmp);
    boolean delete(int id);
    ThanhPho getByName(String ten);
}
