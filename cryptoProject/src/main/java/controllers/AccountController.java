package controllers;

import java.util.Scanner;

import models.users;

public class AccountController {
	Scanner sc;
	public AccountController(Scanner sc) {
		this.sc=sc;
	}
	public void getAccountOptions() {
		String choice="-1";
		while(!choice.equals("5")) {
			System.out.println("\n\n1) Display account Info\n5)Exit");
			choice=sc.nextLine();
			switch (choice) {
			case "1":
				this.createAccount();
				break;
//			case "2":
//				new Search(sc);
//				break;
//			case "3":
//				new AddEmployee(sc);
//				break;
//			case "4":
//				new Modify(sc);
//				break;
			case "5":
				break;
			default:
				break;
			}
		}
	}
//	private void displayAccountDetails() {
//		
//		users u=new users(0, 0, null, null, null, null, null);
//		
//	}
	public void createAccount() {
		users u=new users("1232","devansh", "ewr", "ppsd", "sds", "sdsd","a");
		u.insert();
	}

}
