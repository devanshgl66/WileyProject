package models;

public class orders {
	int id,walletId;
	String status; 
	int itemId;
	String type,createdAt,executedAt;
	float orderPrice,orderQuantity;
	
	public orders(int id, int walletId, String status, int itemId, String type, float orderPrice, float orderQuantity,String createdAt,String executedAt) {
		this.id = id;
		this.walletId = walletId;
		this.status = status;
		this.itemId = itemId;
		this.type = type;
		this.orderPrice = orderPrice;
		this.orderQuantity = orderQuantity;
	}
	

}
