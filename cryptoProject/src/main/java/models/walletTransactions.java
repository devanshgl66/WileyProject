package models;

public class walletTransactions {
	
	String type,status,mode,createdAt;
	int walletId;
	float amount; 
	
	
	public walletTransactions(String type, String status, String mode, int walletId, float amount,String createdAt) {
		this.type = type;
		this.status = status;
		this.mode = mode;
		this.walletId = walletId;
		this.amount = amount;
	}
	
	

}
