package models;
import java.io.*;
import java.sql.*;
import java.util.*;
public class DBConnection {
	Connection con;
	final void connect(){
		System.out.println("Starting connecting to database...");
		try {
			FileReader fr=new FileReader("src/main/java/models/config");
			Properties properties=new Properties();
			properties.load(fr);
			con=DriverManager.getConnection(properties.getProperty("dburl")+"/"+properties.getProperty("dbname"),properties.getProperty("username"),properties.getProperty("password"));
		} catch (SQLException e) {
			System.out.println("Error occured while connecting to database...");
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	final void disconnect() throws SQLException {
		con.close();
	}
	final boolean execute(String query) throws SQLException {
		Statement st=con.createStatement();
		boolean b=st.execute(query);
		disconnect();
		return b;
	}
	final boolean execute(PreparedStatement ps) throws SQLException {
		boolean b= ps.execute();
		disconnect();
		return b;
	}
	final ResultSet executeQuery(String query) throws SQLException {
		Statement st=con.createStatement();
		ResultSet b=st.executeQuery(query);
		return b;
	}
	final ResultSet executeQuery(PreparedStatement ps) throws SQLException {
		ResultSet b= ps.executeQuery();
		return b;
	}
//	public static void main(String[] args) throws IOException, SQLException {
//		DBConnection c=new DBConnection();
//		ResultSet rs=c.executeQuery("select * from users");
//		while(rs.next()) {
//			System.out.println(rs.getInt(1));
//		}
//		c.disconnect();
//	}
}
