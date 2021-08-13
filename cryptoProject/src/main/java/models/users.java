package models;

import java.util.Arrays;

public class users extends Model {
	int id;
	public String name, email, password, account_no, pan_number, phone_number,created_at;

	public String table = "users";
	public String[] fillable = { "phone_number", "name", "email", "password", "account_no",
			"pan_number" };

	public users(String phoneNumber, String name, String email, String password, String accountNo, String panNumber,String createdAt) {
		//setting table name and field name 
		super("users",new String[] {"phone_number", "name", "email", "password", "account_no",
			"pan_number" });
		this.phone_number = phoneNumber;
		this.name = name;
		this.email = email;
		this.password = password;
		this.account_no = accountNo;
		this.pan_number = panNumber;
		this.created_at = createdAt;
	}
	@Override
	public String toString() {
		return "users [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", account_no="
				+ account_no + ", pan_number=" + pan_number + ", phone_number=" + phone_number + ", created_at="
				+ created_at + ", table=" + table + ", fillable=" + Arrays.toString(fillable) + "]";
	}

	public users() {
	}

}
