using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace BLL
{
    public class BLL_HoaDon
    {
        private int hocky;
        private static string mahd;
        private int year;
        private int tongtien;

        public BLL_HoaDon() 
        { 
        
        }

        public BLL_HoaDon(string MaHoaDon)
        {
            mahd = MaHoaDon;
            DataTable dt = DataProvider.Instance.ExecuteQuery("Select TinhTrang, HocKy, Nam, TongTien from HoaDonHocPhi where MaHoaDon = '"+mahd+"'");
            hocky = Convert.ToInt32(dt.Rows[0]["HocKy"].ToString());
            year = Convert.ToInt32(dt.Rows[0]["Nam"].ToString());
            tongtien = Convert.ToInt32(dt.Rows[0]["TongTien"].ToString());
        }

        public BLL_HoaDon(int hk, string MaHoaDon, int nam, int sum_m) 
        {
            hocky = hk;
            mahd = MaHoaDon;
            year = nam;
            tongtien = sum_m;
        }

        public static DataTable LayDSHoaDon()
        {
            return DataProvider.Instance.ExecuteQuery("Select * from HoaDonHocPhi");
        }

        public static DataTable LayDSHoaDonDaTra()
        {
            return DataProvider.Instance.ExecuteQuery("Select * from HoaDonHocPhi where upper(TinhTrang) = 'DA TRA' or upper(TinhTrang) = 'ĐÃ TRẢ'");
        }

        public static DataTable layCTHoaDon(string Mahd)
        {
            mahd = Mahd;
            string query = "Select hp.* from HoaDonHocPhi hdhp, HocPhi hp, ChiTietHoaDon cthd where cthd.MaHocPhi = hp.MaHocPhi and cthd.MaHocPhi = hp.MaHocPhi and hdhp.MaHoaDon = '" + Mahd + "'";
            return DataProvider.Instance.ExecuteQuery(query);
        }

        public static int updateTTHoaDon(object[] para)
        {
            mahd = para[0].ToString();
            DataProvider.Instance.ExecuteNonQuery("DONG_HOC_PHI_ALL", para);
            return 1;
        }
    }
}
