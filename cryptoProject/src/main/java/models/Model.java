package models;

import java.sql.*;
import java.util.Arrays;

public abstract class Model {
	private String table;
	private String[] fillable;
	private Model model;

	private Boolean execute(String preparedInsertQuery) {
		return true;
//		return st.execute(preparedInsertQuery);
	}

	public boolean insert(Model model) {
		this.setFields(model);
		System.out.println(table);
		return this.execute(this.fillPreparedStatement(this.getPreparedInsertQuery()));
	}

	private PreparedStatement fillPreparedStatement(PreparedStatement preparedInsertQuery) {
		try {
			int i=0;
			for (String field : this.fillable) {
				preparedInsertQuery.setString(0, (String) this.model.getClass().getField("table").get(this.model));
				i++;
			}
		} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return preparedInsertQuery;
		
	}

//	abstract boolean delete();
//	abstract boolean update();
//	abstract public  ResultSet raw() ;

	private void setFields(Model modal) {
		try {
			this.table = (String) modal.getClass().getField("table").get(modal);
			this.fillable = (String[]) modal.getClass().getField("fillable").get(modal);
		} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}

	private String getPreparedInsertQuery() {
		String joined = String.join(",", this.fillable);
		String[] questionmarks = new String[this.fillable.length];
		Arrays.fill(questionmarks, "?");
		String joinedq = String.join(",", questionmarks);
		System.out.println("Insert into" + this.table + "(" + joined + ")" + "values(" + joinedq + ")");
		return "Insert into " + this.table + " (" + joined + ") " + "values (" + joinedq + ")";
	}
}