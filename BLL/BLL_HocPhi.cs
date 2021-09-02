using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace BLL
{
    public class BLL_HocPhi
    {
        private int GiaTien;
        private string MaHocPhi;
        private string MSSV;
        public BLL_HocPhi(string mssv, string mahocphi, int giatien)
        {
            MSSV = mssv;
            MaHocPhi = mahocphi;
            GiaTien = giatien;
        }

        public static DataTable LayHocPhi()
        {
            return DataProvider.Instance.ExecuteQuery("Select * from HocPhi");
        }

        public static int updateTT(string mssv, int hocky, int year, int money)
        {
            object[] obj = new object[4];
            obj[0] = mssv;
            obj[1] = hocky;
            obj[2] = year;
            obj[3] = money;
            return DataProvider.Instance.ExecuteNonQuery("DONG_HOC_PHI", obj);
        }
    }
}
