using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PTTK_2021
{
    public partial class fMain : Form
    {
        public fMain()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button7_Click(object sender, EventArgs e)
        {
            Thanh_toán_hóa_đơn f = new Thanh_toán_hóa_đơn();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            XemDangKyHocPhan f = new XemDangKyHocPhan();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Thihocphan f = new Thihocphan();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Close();
            fDangNhap f = new fDangNhap();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
