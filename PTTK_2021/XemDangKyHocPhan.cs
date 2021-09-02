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
    public partial class XemDangKyHocPhan : Form
    {
        public XemDangKyHocPhan()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
            Hoadon f = new Hoadon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
