package models;

import java.sql.*;
import java.util.Arrays;

public abstract class Model extends DBConnection {
	public final String table;
	public final String[] fillable;
	public Model(String table,String []fillable){
		this.table=table;
		this.fillable=fillable;
	}
	public boolean insert() {
		connect();
		try {
			return this.execute(this.fillPreparedStatement(this.getPreparedInsertQuery()));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public void rawSelect(String q) {
		connect();
			ResultSet rs;
			try {
				rs = this.executeQuery(q);
				ResultSetMetaData rsmd = rs.getMetaData();
				int colCount=rsmd.getColumnCount();
				for(int i=0;i<colCount;i++)
					System.out.print(String.format("%-20s",rsmd.getColumnName(i+1)));
				System.out.println();
				while(rs.next()) {
					for(int i=0;i<colCount;i++)
						System.out.print(String.format("%-20s",rs.getString(i+1)));
					System.out.println();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	public boolean rawUpdateDelete(String q) {
		try {
			this.execute(q);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean update() {
		return false;
	}

	private PreparedStatement fillPreparedStatement(PreparedStatement preparedInsertQuery) {
		try {
			int i=1;
			for (String field : this.fillable) 
				preparedInsertQuery.setString(i++, (String) this.getClass().getField(field).get(this));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return preparedInsertQuery;
		
	}
	private PreparedStatement getPreparedInsertQuery() {
		String joined = String.join(",", this.fillable);
		String[] questionmarks = new String[this.fillable.length];
		Arrays.fill(questionmarks, "?");
		String joinedq = String.join(",", questionmarks);
		PreparedStatement addEmp = null;
		try {
			addEmp = this.con
					.prepareStatement("Insert into " + this.table + " (" + joined + ") " + "values (" + joinedq + ")");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return addEmp;
	}
}
