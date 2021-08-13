package models;


public class users extends Model {
	int id;
	String name, email, password, account_no, pan_number, phone_number,created_at;

	public String table = "users";
	public String[] fillable = { "phone_number", "name", "email", "password", "account_no",
			"pan_number" };

	public users(String phoneNumber, String name, String email, String password, String accountNo, String panNumber,String createdAt) {

//		this.id = id;
		this.phone_number = phoneNumber;
		this.name = name;
		this.email = email;
		this.password = password;
		this.account_no = accountNo;
		this.pan_number = panNumber;
		this.created_at = createdAt;
	}

}
