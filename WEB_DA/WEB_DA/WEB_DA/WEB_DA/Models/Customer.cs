using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace WEB_DA.Models
{
    public class Customer
    {
    
        [Key]
        public int MaKhachHang { get; set; }

        [Required]
        [StringLength(255)]
        public string TenKhachHang { get; set; }

        [Required]
        [StringLength(50)]
        public string DienThoai { get; set; }

        [Required]
        [StringLength(50)]
        public string MatKhau { get; set; }

        public bool? GioiTinh { get; set; }

        [StringLength(255)]
        public string DiaChi { get; set; }
    }
    
}