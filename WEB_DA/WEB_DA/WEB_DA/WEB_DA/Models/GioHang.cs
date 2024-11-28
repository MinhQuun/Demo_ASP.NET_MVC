using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB_DA.Models
{
    public class GioHang
    {
         public List<CartItem> list;
        public GioHang()
        {
            list = new List<CartItem>();
        }
        public GioHang(List<CartItem> listGH)
        {
            list = listGH;
        }
        public int SoMatHang()
        {
            if (list == null)
                return 0;
            return list.Count;
        }

        public int TongSLHang()
        {
            int tong = 0;
            if (list != null)
            {
                tong = list.Sum(n => n.SoLuong);
            }
            return tong;
        }

        public double TongThanhTien()
        {
            double tong = 0;
            if (list != null)
            {
                tong = list.Sum(n => (double)n.ThanhTien); 
            }
            return tong;
        }

        public int Them(string masp)
        {
            CartItem sp = list.Find(n => n.MaSP == masp);
            if(sp == null)
            {
                CartItem SanPham = new CartItem(masp);
                if (SanPham == null)
                    return -1;
                list.Add(SanPham);
            }
            else
            {
                sp.SoLuong++;
            }
            return 1;
        }
        public int Giam(string masp)
        {
            CartItem sp = list.Find(n => n.MaSP == masp);
            if (sp == null)
            {
                return -1;
            }
            if (sp.SoLuong > 0)
            {
                sp.SoLuong--;
                if (sp.SoLuong == 0)
                {
                    list.Remove(sp);
                }
            }
            else
            {
                return -2;
            }

            return 1;
        }

        public void XoaSanPham(string id)
        {
            var item = list.FirstOrDefault(i => i.MaSP == id);
            if (item != null)
            {
                list.Remove(item);
            }
        }
    }
    }
