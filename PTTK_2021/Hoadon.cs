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
    public partial class Hoadon : Form
    {
        public Hoadon()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
            XemDangKyHocPhan f = new XemDangKyHocPhan();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
