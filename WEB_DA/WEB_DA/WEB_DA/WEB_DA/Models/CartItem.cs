using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB_DA.Models
{
    public class CartItem
    {
        public string MaSP { get; set; }
        public string TenSP { get; set; }
        public string AnhBia { get; set; }
        public decimal DonGia { get; set; }
        public int SoLuong { get; set; }
        public decimal   ThanhTien
        {
            get { return SoLuong * DonGia; }
        }
        DataClasses1DataContext data = new DataClasses1DataContext();
        public CartItem(string masp)
        {
            SanPham sp = data.SanPhams.SingleOrDefault(t => t.MaSanPham == masp);
            if (sp != null)
            {
                MaSP = masp;
                TenSP = sp.TenSanPham;
                AnhBia = sp.HinhDaiDien;
                DonGia = decimal.Parse(sp.DonGia.ToString());
                SoLuong = 1;
            }

        }
    }
}