package models;
import java.sql.*;
import java.util.Arrays;
public abstract class Modal {
	String table;
	String []fillable;
	boolean insert(Modal modal) {
		String table=modal.table;
		String[] columns=modal.fillable;
		String joined=String.join(",", columns);
		String q="q";
		String[] questionmarks=new String[columns.length];
		Arrays.fill("?", questionmarks);
		String joinedq=String.join(",", questionmarks);

		String q="Insert into"+table+"("+joined+")"+"values("+joinedq+")";
		return false;
	}
	boolean delete() {
		
	}
	boolean update() {
		
	}
	ResultSet raw() {
	};
}
