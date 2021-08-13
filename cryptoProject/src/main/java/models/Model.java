package models;

import java.sql.*;
import java.util.Arrays;

public abstract class Model extends DBConnection {
	private String table;
	private String[] fillable;
	private Model model;

	public boolean insert() {
		connect();
		this.model = this;
		System.out.println(this.model);
		this.setFields(this);
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
			int i = 1;
			for (String field : this.fillable) {
				preparedInsertQuery.setString(i, (String) this.model.getClass().getField(field).get(this.model));
				System.out.println(preparedInsertQuery);
				i++;
			}
		} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return preparedInsertQuery;

	}

	private void setFields(Model modal) {
		try {
			this.table = (String) modal.getClass().getField("table").get(modal);
			this.fillable = (String[]) modal.getClass().getField("fillable").get(modal);
		} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
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
