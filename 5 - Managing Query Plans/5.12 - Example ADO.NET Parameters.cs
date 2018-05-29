using System.Data.SqlClient;

namespace UsingADONETQueries
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var conn = new SqlConnection("server=.;database=AdventureWorks2017;integrated security=yes"))
            using (var cmd = new SqlCommand("select count(*) from Production.Product where ProductID>@pid" conn))
            {
                cmd.Parameters.AddWithValue("@pid", 90000);
                conn.Open();
                var results = cmd.ExecuteReader();
            }
        }
    }
}