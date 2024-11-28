using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WEB_DA.Models; 
namespace WEB_DA.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        DataClasses1DataContext data = new DataClasses1DataContext();
        public ActionResult Index(string fragment)
        {
            ViewBag.Fragment = fragment;
            List<SanPham> sp = data.SanPhams.ToList();
            return View(sp);
        }
        public ActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SignUp(KhachHang t)
        {
            if (ModelState.IsValid)
            {
                var existingCustomer = data.KhachHangs.FirstOrDefault(k => k.DienThoai == t.DienThoai);
                if (existingCustomer == null)
                {
                    KhachHang newCustomer = new KhachHang
                    {
                        TenKhachHang = t.TenKhachHang,
                        DienThoai = t.DienThoai,
                        MatKhau = t.MatKhau,
                        GioiTinh = t.GioiTinh,
                        DiaChi = t.DiaChi
                    };

                    data.KhachHangs.InsertOnSubmit(newCustomer);
                    data.SubmitChanges();
                    ViewBag.Message = "Bạn đã đăng ký thành công!";
                }
                else
                {
                    ViewBag.Message = "Số điện thoại đã tồn tại. Vui lòng chọn số khác.";
                }
            }
            else
            {
                ViewBag.Message = "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại!";
            }

            return View();
        }
        public ActionResult SignIn()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignIn(FormCollection col)
        {
            var ten = col["txtName"];
            var pass = col["txtPass"];
            KhachHang kh = data.KhachHangs.FirstOrDefault(k => k.DienThoai == ten && k.MatKhau == pass);
            if (kh != null)
            {
                Session["kh"] = kh;
                return RedirectToAction("Index");
            }
            return View();
        }
        public ActionResult LogOut()
        {
            Session["kh"] = null;
            return RedirectToAction("Index");
        }
     
        public ActionResult ThemMatHang(string id)
        {
            GioHang gh = Session["GioHang"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang();
            }
            gh.Them(id);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
        public ActionResult TangMatHang(string id)
        {
            GioHang gh = Session["GioHang"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang();
            }
            gh.Them(id);
            Session["GioHang"] = gh;
            return RedirectToAction("Xemgiohang");
        }
        public ActionResult GiamMatHang(string id)
        {
            GioHang gh = Session["GioHang"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang();
            }
            int result = gh.Giam(id);
            Session["GioHang"] = gh;
            if (result == -1)
            {
                ViewBag.ErrorMessage = "Mặt hàng không tồn tại trong giỏ hàng.";
            }
            else if (result == -2)
            {
                ViewBag.ErrorMessage = "Số lượng mặt hàng đã là 0 và không thể giảm thêm.";
            }
            return RedirectToAction("Xemgiohang");
        }

        public ActionResult Xemgiohang()
        {
            GioHang gh = Session["GioHang"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang();
            }
            return View(gh);
        }
        public ActionResult Dathang()
        {
            if (Session["kh"] == null)
            {
                return RedirectToAction("SignIn");
            }
            GioHang gh = Session["GioHang"] as GioHang;
            KhachHang khach = Session["kh"] as KhachHang;
            ViewBag.k = khach;
            return View(gh);
        }
       
        public ActionResult Detail(string id)
        {
            SanPham sp = data.SanPhams.Where(n => n.MaSanPham == id).FirstOrDefault();
            return View(sp);
        }
        public ActionResult Menuc1()
        {
            List<DanhMucSanPham> dmsp = data.DanhMucSanPhams.ToList();

            return PartialView(dmsp);
        }
        public ActionResult MenuCap2(int madm)
        {
            List<Loai> dsloai = data.Loais.Where(t => t.MaDanhMuc == madm).ToList();
            return PartialView(dsloai);
        }
        public ActionResult LocDL_Theoloai(int mdm)
        {
            List<SanPham> ds = data.SanPhams.Where(t => t.MaLoaiSP == mdm).ToList();
            return View("Index", ds);
        }
        public ActionResult Search(string searchString, int[] categoryIds)
        {
            var sp = from a in data.SanPhams select a;

            if (!string.IsNullOrEmpty(searchString))
            {
                sp = sp.Where(s => s.TenSanPham.Contains(searchString));
            }

            if (categoryIds != null && categoryIds.Any())
            {
                sp = sp.Where(s => categoryIds.Contains(s.MaLoaiSP));
            }

            return View("Index", sp.ToList());
        }

        public ActionResult TimKiem()
        {
            ViewBag.Title = "TimKiem";
            ViewBag.Categories = data.Loais.ToList(); // Populate categories from your data source
            return View();
        }

        public ActionResult RemoveFromCart(string id)
        {
            GioHang gh = Session["GioHang"] as GioHang;
            gh.XoaSanPham(id);
            return RedirectToAction("Xemgiohang");
        }
        public ActionResult AddItem()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddItem(SanPham item)
        {
            if (ModelState.IsValid)
            {
                data.SanPhams.InsertOnSubmit(item);
                data.SubmitChanges();
                return RedirectToAction("Index");
            }
            return View(item);
        }
        [HttpPost]
        public ActionResult XacNhanDonHang()
        {
            if (Session["kh"] == null)
            {
                return RedirectToAction("SignIn");
            }
            GioHang gh = Session["GioHang"] as GioHang;
            if (gh == null || !gh.list.Any())
            {
                return RedirectToAction("Xemgiohang");
            }
            KhachHang khach = Session["kh"] as KhachHang;
            DonDatHang donHang = new DonDatHang
            {
                MaKhachHang = khach.MaKhachHang,
                NgayDatHang = DateTime.Now,
                TongSLHang=gh.TongSLHang(),
                TongThanhTien = (decimal?)gh.TongThanhTien(),
            };
            data.DonDatHangs.InsertOnSubmit(donHang);
            data.SubmitChanges();

            foreach (var item in gh.list)
            {
                ChiTietDonHang chiTiet = new ChiTietDonHang
                {
                    MaDonHang = donHang.MaDonHang,
                    MaSanPham = item.MaSP,
                    SoLuong = item.SoLuong,
                    DonGia = item.DonGia,
                };

                data.ChiTietDonHangs.InsertOnSubmit(chiTiet);
            }
            data.SubmitChanges();

            Session["GioHang"] = null;

            return RedirectToAction("Index");
        }
        public ActionResult LichSuDonHang()
        {
            if (Session["kh"] == null)
            {
                return RedirectToAction("SignIn");
            }

            KhachHang khach = Session["kh"] as KhachHang;

            var donHangs = data.DonDatHangs
                                .Where(d => d.MaKhachHang == khach.MaKhachHang)
                                .OrderByDescending(d => d.NgayDatHang)
                                .ToList();

            return View(donHangs);
        }

 

    }
}
