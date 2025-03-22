package model;

import java.io.Serializable;

public class TaiKhoan {

    String tenTaiKhoan;
    String matKhau;
    String hoTen;
    boolean gioiTinh;
    String soDienThoai;
    String email;
    int idRole;

    public TaiKhoan() {
    }

    public int getIdRole() {
        return idRole;
    }

    public TaiKhoan(String tenTaiKhoan, String matKhau, String hoTen, boolean gioiTinh, String soDienThoai, String email, int Role) {
        this.tenTaiKhoan = tenTaiKhoan;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.gioiTinh = gioiTinh;
        this.soDienThoai = soDienThoai;
        this.email = email;
        this.idRole = Role;
    }

    public TaiKhoan(String tenTaiKhoan, String email, String matKhau, String hoTen, int idRole) {
        this.tenTaiKhoan = tenTaiKhoan;
        this.email = email;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.idRole = idRole;
    }

    public String getTenTaiKhoan() {
        return tenTaiKhoan;
    }

    public void setTenTaiKhoan(String tenTaiKhoan) {
        this.tenTaiKhoan = tenTaiKhoan;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public boolean isGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(boolean gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    // Setter cần có
    public void setIdRole(int idRole) {
        this.idRole = idRole;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
