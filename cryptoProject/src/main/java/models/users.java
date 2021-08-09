package models;

public class users {
	int id,phoneNumber;
	String name,email,password,accountNo,panNumber,createdAt;
	
	
	
	public users(int id, int phoneNumber, String name, String email, String password, String accountNo,
			String panNumber,String createdAt) {
		
		this.id = id;
		this.phoneNumber = phoneNumber;
		this.name = name;
		this.email = email;
		this.password = password;
		this.accountNo = accountNo;
		this.panNumber = panNumber;
	}
	
	
}
