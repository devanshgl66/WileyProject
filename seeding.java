package wiley.programs.dp;

public class seeding {

	public static void main(String[] args) {
		String[] type= {"debit","credit"};
		String[] type1= {"buy","sell"};
		String[] status= {"pending","complete","failed"};
		
		for(int i=1;i<=50;++i) {
			System.out.println("Insert into wallet_transactions values ("+i+",\""+type[i%2]+"\","+i+","+i*1000+",\""+status[i%3]+"\","+"\"UPI\""+",now());");
		}
		
//		for(int i=1;i<=50;++i) {
//			System.out.println("Insert into trade_transactions values ("+i+","+i+",\""+type1[i%2]+"\",\""+status[i%3]+"\","+(i%5+1)+","+(i+1)+","+((i*1000)%20000+1000)+");");
//		}
	}

}
