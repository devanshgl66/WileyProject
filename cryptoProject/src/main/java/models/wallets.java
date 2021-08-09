package models;

public class wallets {

	int id,accountId; 
	String currency_type,status; 
	float amount; 
	
	public wallets(int id, int accountId, String currency_type, String status, float amount) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.currency_type = currency_type;
		this.status = status;
		this.amount = amount;
	}
	 
	
	
}
