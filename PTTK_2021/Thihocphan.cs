using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace PTTK_2021
{
    public partial class Thihocphan : Form
    {
        public Thihocphan()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Thi f = new Thi();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
