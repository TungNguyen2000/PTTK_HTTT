using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BLL;

namespace PTTK_2021
{
    public partial class Thanh_toán_hóa_đơn : Form
    {
        private void hien_thi() 
        {
            listView1.View = View.Details;
            listView1.Columns.Add("Ma Hoa Don", 100);
            listView1.Columns.Add("Tinh Trang", 100);
            listView1.Columns.Add("Hoc Ky", 50);
            listView1.Columns.Add("Nam", 50);
            listView1.Columns.Add("Tong Tien", 120);
            DataTable data = BLL_HoaDon.LayDSHoaDon();
            foreach (DataRow row in data.Rows)
            {
                ListViewItem item = new ListViewItem(row[0].ToString());
                for (int i = 1; i < data.Columns.Count; i++)
                {
                    item.SubItems.Add(row[i].ToString());
                }
                listView1.Items.Add(item);
            }

            listView3.View = View.Details;
            listView3.Columns.Add("Ma Hoa Don", 100);
            listView3.Columns.Add("Tinh Trang", 100);
            listView3.Columns.Add("Hoc Ky", 50);
            listView3.Columns.Add("Nam", 50);
            listView3.Columns.Add("Tong Tien", 120);
            data = BLL_HoaDon.LayDSHoaDonDaTra();
            foreach (DataRow row in data.Rows)
            {
                ListViewItem item = new ListViewItem(row[0].ToString());
                for (int i = 1; i < data.Columns.Count; i++)
                {
                    item.SubItems.Add(row[i].ToString());
                }
                listView3.Items.Add(item);
            }
        }
        public Thanh_toán_hóa_đơn()
        {
            InitializeComponent();
            hien_thi();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
            fMain f = new fMain();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.listView1.SelectedItems.Count == 0)
                return;
            string namn = this.listView1.SelectedItems[0].SubItems[0].Text;
            listView2.View = View.Details;
            listView2.Columns.Add("Ma Hoc Phi", 100);
            listView2.Columns.Add("MSSV", 100);
            listView2.Columns.Add("Ma Lop Chung Chi", 100);
            listView2.Columns.Add("Ma Lop Chuyen De", 100);
            listView2.Columns.Add("Ma Hoc Phan", 100);
            listView2.Columns.Add("Gia Tien", 100);
            listView2.Columns.Add("Tinh Trang", 100);
            listView2.Columns.Add("Ngay Phat Hanh", 100);
            DataTable dt = BLL_HoaDon.layCTHoaDon(namn);
            foreach (DataRow row in dt.Rows)
            {
                ListViewItem item = new ListViewItem(row[0].ToString());
                for (int i = 1; i < dt.Columns.Count; i++)
                {
                    item.SubItems.Add(row[i].ToString());
                }
                listView2.Items.Add(item);
            }
        }

        private void listView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string text = richTextBox1.Text;
            object[] para = new object[4];
            if (text != null)
            {
                try
                {
                    para[0] = listView2.SelectedItems[0].SubItems[0].Text;
                    para[1] = listView2.SelectedItems[0].SubItems[2].Text;
                    para[2] = listView2.SelectedItems[0].SubItems[3].Text;
                    para[3] = text;
                }
                catch (Exception ex) { MessageBox.Show("chọn hóa đơn muốn trả");
                    return;
                }
                BLL_HoaDon.updateTTHoaDon(para);
            }
        }
    }
}
