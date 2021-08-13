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
			System.out.println("\n\n1) Display account Info\n2)Create new account5)Exit");
			choice=sc.nextLine();
			switch (choice) {
			case "1":
				this.display();
				break;
			case "2":
				this.createAccount();
				break;
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
	private void display() {
		String q="select * from users where id="+50;
		new users().rawSelect(q);
	}
//	private void displayAccountDetails() {
//		
//		users u=new users(0, 0, null, null, null, null, null);
//		
//	}
	public void createAccount() {
		users u=new users("123","jatin", "ewr", "ppsd", "sds", "sdsd", "pl");
		u.insert();
	}

}
