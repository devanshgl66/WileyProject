-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wileyProject
-- -----------------------------------------------------

-- -----------------------------------------------------
Drop Database wileyProject;
-- Schema wileyProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wileyProject` ;
-- -----------------------------------------------------
-- Schema dba
-- -----------------------------------------------------
USE `wileyProject` ;

-- -----------------------------------------------------
-- Table `wileyProject`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(256) NULL,
  `account_no` VARCHAR(45) NULL,
  `pan_number` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `account_no_UNIQUE` (`account_no` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) ,
  UNIQUE INDEX `pan_number_UNIQUE` (`pan_number` ASC) )
ENGINE = InnoDB
COMMENT = 'This table is for storing user account details';


-- -----------------------------------------------------
-- Table `wileyProject`.`wallets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`wallets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `currency_type` ENUM("INR", "USD") NOT NULL,
  `amount` FLOAT NOT NULL DEFAULT 0.0,
  `status` ENUM("blocked", "active", "pending") NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  INDEX `wallets_account_id_idx` (`account_id` ASC) ,
  CONSTRAINT `wallets_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `wileyProject`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This contains data for user wallets';


-- -----------------------------------------------------
-- Table `wileyProject`.`wallet_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`wallet_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM("debit", "credit") NOT NULL,
  `wallets_id` INT NOT NULL,
  `amount` FLOAT NOT NULL,
  `status` ENUM("pending", "complete", "failed") NOT NULL,
  `mode` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `wallets_transaction_wallets_id_idx` (`wallets_id` ASC) ,
  CONSTRAINT `wallets_transaction_wallets_id`
    FOREIGN KEY (`wallets_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wileyProject`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(10) NULL,
  `is_active` TINYINT NOT NULL,
  `added_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wileyProject`.`trade_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`trade_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wallets_id` INT NOT NULL,
  `type` ENUM("buy", "sell") NULL,
  `status` ENUM("pending", "complete", "failed") NULL,
  `item_id` INT NULL,
  `unit_price` FLOAT NULL,
  `quantity` FLOAT NOT NULL DEFAULT 0.0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `trade_trans_wallets_idx` (`wallets_id` ASC) ,
  INDEX `fk_trade_transaction_item_idx` (`item_id` ASC) ,
  CONSTRAINT `trade_trans_wallets`
    FOREIGN KEY (`wallets_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_transaction_item`
    FOREIGN KEY (`item_id`)
    REFERENCES `wileyProject`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Contains data for transaction\n';


-- -----------------------------------------------------
-- Table `wileyProject`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wallets_id` INT NULL,
  `status` ENUM("pending", "complete", "cancelled") NOT NULL,
  `transaction_id` INT NULL,
  `order_price` FLOAT NULL,
  `order_quantity` FLOAT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `orders_transaction_id_idx` (`transaction_id` ASC) ,
  CONSTRAINT `orders_wallets_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orders_transaction_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `wileyProject`.`trade_transactions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wileyProject`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`inventory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `quantity` FLOAT NOT NULL DEFAULT 0.0,
  `wallets_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `inventory_wallets_id_idx` (`wallets_id` ASC) ,
  INDEX `inventory_item_id_idx` (`item_id` ASC) ,
  CONSTRAINT `inventory_wallets_id`
    FOREIGN KEY (`wallets_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inventory_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `wileyProject`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- users table popualted
insert into users(name,email,password,account_no,pan_number,phone_number)
values("Eilene  ","Eilene  12@gmail.com","654fa8f35246aae143e037252ae6acec","16439128558","wum89kt1cb","71013047009"),
("Allen  ","Allen  12@gmail.com","0bc4d73bc90629170bb21dc59ad48ef0","97652643536","4zdby5hwjv","19140480480"),
("Miguelina  ","Miguelina  12@gmail.com","f05ef4e92b58a78129cc35c73eea1343","63992392186","8e739yt9kz","61510668244"),
("Giovanni  ","Giovanni  12@gmail.com","0360484e0b0550aee79e6433427f3063","40747646280","4ch56utvfq","11833673913"),
("Nadia  ","Nadia  12@gmail.com","5f66f36b1ccd122956ad0cf259af2145","36997369318","mk448w1t6o","24500323920"),
("Zola  ","Zola  12@gmail.com","c66bd45c86644b7b5297b11672efc1e2","68259899008","y8dzbw3kwo","18346586186"),
("Jeannie  ","Jeannie  12@gmail.com","721b43005299d7991d0f0368e8ddeb94","45867315967","6fjuvfjty1","10554771219"),
("Jordon  ","Jordon  12@gmail.com","8ee658d54128d9e770e67ae729a2da42","10304191894","uzzmo26hsh","57272355176"),
("Lezlie  ","Lezlie  12@gmail.com","21c4232eb0c2494803d42f0c1084825c","43647796961","s09w09295r","52817593159"),
("Patience  ","Patience  12@gmail.com","c20d105f03869f6b99d578be3c457fdc","87748158693","06lv51w30o","89987834018"),
("Raelene  ","Raelene  12@gmail.com","787dc7cadf45940a2e253c03bb2aceba","23832226059","72q5ubp1kj","66998569384"),
("Leticia  ","Leticia  12@gmail.com","fe641e4e40ca18a6e3ecb5c6e979f6ef","58293894341","4pbik9b30l","13152008673"),
("Agatha  ","Agatha  12@gmail.com","0a38700aaa2b6259e5217659bdd5704b","54713995511","b45iai5lyu","24520215823"),
("Hershel  ","Hershel  12@gmail.com","fe284d4da88460ff6e56b7ed0e8ef171","53557073852","4gth5gqdud","96325890890"),
("Elidia  ","Elidia  12@gmail.com","74d674408428a79418f092ea89601e50","88858187309","ii9p1aoz2p","71379294017"),
("Leigh  ","Leigh  12@gmail.com","f0a8da44844bce8cfbf1f4ba949323ca","66645481259","uy1ez36w0g","20141385765"),
("Caren  ","Caren  12@gmail.com","87cdf3d89f4cad8297209d6651f4b53b","24695881322","j1lklww6lj","49301793921"),
("Lashawnda  ","Lashawnda  12@gmail.com","17bdca130ae63b3bf46b72559e168029","64862002049","58sordh5ky","44562516889"),
("Tillie  ","Tillie  12@gmail.com","451602d4890b8a6f0999c699ad567a73","98184684791","xmqeb609yu","84699088634"),
("Alvina  ","Alvina  12@gmail.com","5ca9b21cfa94a88ff4be13bc537340a5","66730823752","5um65odeg1","86706442441"),
("Isabel  ","Isabel  12@gmail.com","2d5778ecf87a45d66503308d4a068622","44483275876","p4nlti75s3","21943644864"),
("Kelli  ","Kelli  12@gmail.com","a808a980d87589cf3ebfc6cd07645fa0","54631799251","gd16elfgy1","81644698324"),
("Krystin  ","Krystin  12@gmail.com","6c94678330cabe048be07113e30ee2da","19404504269","6gbkapp75d","41771786789"),
("Marx  ","Marx  12@gmail.com","f8a6b8286668d73fa154c47ea3598b28","52818635559","zpx0aa9ifm","63585475443"),
("Angelia  ","Angelia  12@gmail.com","4046ed9691b14b965299dfd4e2b7760b","29309688758","5n8ivfh9un","78327985052"),
("Olivia  ","Olivia  12@gmail.com","4e27abc8f0ecd60c792f0ea9448354e5","52393703960","r60imxlnqj","41484485937"),
("Reta  ","Reta  12@gmail.com","495183db6c1eb2c840ae11f678230cd2","44880086155","jc09pa7snt","89316938128"),
("Chastity  ","Chastity  12@gmail.com","5b2af91956a4e57cdd255dadceb6323a","31124576260","w1x1pasxm1","45362428464"),
("Leonila  ","Leonila  12@gmail.com","153e0b60d25a803241cabb824efd012d","48840979382","gyvtifefga","79456496567"),
("Terri  ","Terri  12@gmail.com","b50b2b3e3fbf05cc7d1ecce474e9c968","77513174570","4rbq7m8j8o","69070024763"),
("Willis  ","Willis  12@gmail.com","bb9491ab8a572cf4d8f3a3e7b9b7c3a4","24199455332","cvk8fnj17s","62189328333"),
("Tanna  ","Tanna  12@gmail.com","b18d8f307596079864af127e0eb11240","40345194463","mnumc198bg","32270242489"),
("Debi  ","Debi  12@gmail.com","01cb104ccf30f7d3267282f091b1febd","20756766164","lr6go2xn9r","88295406092"),
("Lanell  ","Lanell  12@gmail.com","aa56ce7549d4d39fc8b4ea050a15772c","80527641163","1i968fi2wt","83432787472"),
("Obdulia  ","Obdulia  12@gmail.com","29bf5c4ef22a3ecc0f2fd7a33538a8e6","84473035218","682a2ohozi","41042970039"),
("Mandi  ","Mandi  12@gmail.com","fc590ff53ca08add209e4205db0f3f00","47334803035","det9ycgpaq","80306259991"),
("Raquel  ","Raquel  12@gmail.com","83bfccdc7a760e97442cf18aba65fd44","76340216662","ajzenffgrh","70560481419"),
("Adolfo  ","Adolfo  12@gmail.com","63b13009f56e51f35d3eb832b808c317","51200178659","aq5p2phbb5","45798485543"),
("Jason  ","Jason  12@gmail.com","3b969cd0d95a176c67608e99eea364f4","56973922559","kn3ba66ya9","25146092231"),
("Vanda  ","Vanda  12@gmail.com","68af12cbcc71a2650a9ce74cd4e109bf","56118169738","ywv14kqkqw","40630028830"),
("Daine  ","Daine  12@gmail.com","d2df688c161d148079cdfba619fbbcab","27564420204","uryo0y5njs","54814114927"),
("Myles  ","Myles  12@gmail.com","83ad84e2e432460e5aa8077b1ab66956","29735033671","nr15we4bui","90413533157"),
("Jesse  ","Jesse  12@gmail.com","2c31b2379206c6edeff579606b6003da","32247593989","vufb9wirtc","27457002879"),
("Hester  ","Hester  12@gmail.com","65a5aca76789bdd1f97ea10fa8892122","46086318328","1d004457vm","79847393827"),
("Sid  ","Sid  12@gmail.com","9892ad4d6e4c3e121abbf55776015c54","61047534286","4xvgciezqq","20845360327"),
("Gabrielle  ","Gabrielle  12@gmail.com","90006a0c7a40e65d3b5f70461b17acbc","74465202406","32opxxyycs","81300757830"),
("Mendy  ","Mendy  12@gmail.com","92a0555383ccbeedb60d31172595f212","29941559040","uk7xzayq8n","97867394211"),
("Concepcion  ","Concepcion  12@gmail.com","143a4ec63f163eb8fe9afd53a3108236","49134742692","3qixpy72nw","63632215775"),
("Nathan  ","Nathan  12@gmail.com","98fca7786be787f2c907f5839a1d819a","92630767045","xwqwo4svef","50800380111"),
("Jacqualine  ","Jacqualine  12@gmail.com","83a730361437694922bf61bbdc1e9829","35650123904","wezyc3qb2x","82885766155");


-- populate wallets table 
Insert into wallets values (1,1,"INR",2000,"active");
Insert into wallets values (2,2,"INR",3000,"active");
Insert into wallets values (3,3,"INR",4000,"active");
Insert into wallets values (4,4,"INR",5000,"active");
Insert into wallets values (5,5,"INR",6000,"active");
Insert into wallets values (6,6,"INR",7000,"active");
Insert into wallets values (7,7,"INR",8000,"active");
Insert into wallets values (8,8,"INR",9000,"active");
Insert into wallets values (9,9,"INR",10000,"active");
Insert into wallets values (10,10,"INR",11000,"active");
Insert into wallets values (11,11,"INR",12000,"active");
Insert into wallets values (12,12,"INR",13000,"active");
Insert into wallets values (13,13,"INR",14000,"active");
Insert into wallets values (14,14,"INR",15000,"active");
Insert into wallets values (15,15,"INR",16000,"active");
Insert into wallets values (16,16,"INR",17000,"active");
Insert into wallets values (17,17,"INR",18000,"active");
Insert into wallets values (18,18,"INR",19000,"active");
Insert into wallets values (19,19,"INR",20000,"active");
Insert into wallets values (20,20,"INR",1000,"active");
Insert into wallets values (21,21,"INR",2000,"active");
Insert into wallets values (22,22,"INR",3000,"active");
Insert into wallets values (23,23,"INR",4000,"active");
Insert into wallets values (24,24,"INR",5000,"active");
Insert into wallets values (25,25,"INR",6000,"active");
Insert into wallets values (26,26,"INR",7000,"active");
Insert into wallets values (27,27,"INR",8000,"active");
Insert into wallets values (28,28,"INR",9000,"active");
Insert into wallets values (29,29,"INR",10000,"active");
Insert into wallets values (30,30,"INR",11000,"active");
Insert into wallets values (31,31,"INR",12000,"active");
Insert into wallets values (32,32,"INR",13000,"active");
Insert into wallets values (33,33,"INR",14000,"active");
Insert into wallets values (34,34,"INR",15000,"active");
Insert into wallets values (35,35,"INR",16000,"active");
Insert into wallets values (36,36,"INR",17000,"active");
Insert into wallets values (37,37,"INR",18000,"active");
Insert into wallets values (38,38,"INR",19000,"active");
Insert into wallets values (39,39,"INR",20000,"active");
Insert into wallets values (40,40,"INR",1000,"active");
Insert into wallets values (41,41,"INR",2000,"active");
Insert into wallets values (42,42,"INR",3000,"active");
Insert into wallets values (43,43,"INR",4000,"active");
Insert into wallets values (44,44,"INR",5000,"active");
Insert into wallets values (45,45,"INR",6000,"active");
Insert into wallets values (46,46,"INR",7000,"active");
Insert into wallets values (47,47,"INR",8000,"active");
Insert into wallets values (48,48,"INR",9000,"active");
Insert into wallets values (49,49,"INR",10000,"active");
Insert into wallets values (50,50,"INR",11000,"active");

-- populate orders table
Insert into orders values (null,1,"pending",1,1000,2000,now());
Insert into orders values (null,2,"complete",2,2000,3000,now());
Insert into orders values (null,3,"pending",3,3000,4000,now());
Insert into orders values (null,4,"complete",4,4000,5000,now());
Insert into orders values (null,5,"pending",5,5000,6000,now());
Insert into orders values (null,6,"complete",6,6000,7000,now());
Insert into orders values (null,7,"pending",7,7000,8000,now());
Insert into orders values (null,8,"complete",8,8000,9000,now());
Insert into orders values (null,9,"pending",9,9000,10000,now());
Insert into orders values (null,10,"complete",10,10000,11000,now());
Insert into orders values (null,11,"pending",11,11000,12000,now());
Insert into orders values (null,12,"complete",12,12000,13000,now());
Insert into orders values (null,13,"pending",13,13000,14000,now());
Insert into orders values (null,14,"complete",14,14000,15000,now());
Insert into orders values (null,15,"pending",15,15000,16000,now());
Insert into orders values (null,16,"complete",16,16000,17000,now());
Insert into orders values (null,17,"pending",17,17000,18000,now());
Insert into orders values (null,18,"complete",18,18000,19000,now());
Insert into orders values (null,19,"pending",19,19000,20000,now());
Insert into orders values (null,20,"complete",20,20000,1000,now());
Insert into orders values (null,21,"pending",21,21000,2000,now());
Insert into orders values (null,22,"complete",22,22000,3000,now());
Insert into orders values (null,23,"pending",23,23000,4000,now());
Insert into orders values (null,24,"complete",24,24000,5000,now());
Insert into orders values (null,25,"pending",25,25000,6000,now());
Insert into orders values (null,26,"complete",26,26000,7000,now());
Insert into orders values (null,27,"pending",27,27000,8000,now());
Insert into orders values (null,28,"complete",28,28000,9000,now());
Insert into orders values (null,29,"pending",29,29000,10000,now());
Insert into orders values (null,30,"complete",30,30000,11000,now());
Insert into orders values (null,31,"pending",31,31000,12000,now());
Insert into orders values (null,32,"complete",32,32000,13000,now());
Insert into orders values (null,33,"pending",33,33000,14000,now());
Insert into orders values (null,34,"complete",34,34000,15000,now());
Insert into orders values (null,35,"pending",35,35000,16000,now());
Insert into orders values (null,36,"complete",36,36000,17000,now());
Insert into orders values (null,37,"pending",37,37000,18000,now());
Insert into orders values (null,38,"complete",38,38000,19000,now());
Insert into orders values (null,39,"pending",39,39000,20000,now());
Insert into orders values (null,40,"complete",40,40000,1000,now());
Insert into orders values (null,41,"pending",41,41000,2000,now());
Insert into orders values (null,42,"complete",42,42000,3000,now());
Insert into orders values (null,43,"pending",43,43000,4000,now());
Insert into orders values (null,44,"complete",44,44000,5000,now());
Insert into orders values (null,45,"pending",45,45000,6000,now());
Insert into orders values (null,46,"complete",46,46000,7000,now());
Insert into orders values (null,47,"pending",47,47000,8000,now());
Insert into orders values (null,48,"complete",48,48000,9000,now());
Insert into orders values (null,49,"pending",49,49000,10000,now());
Insert into orders values (null,50,"complete",50,50000,11000,now());

-- populate items table

Insert into items values (1,'bitcoin','b001',1,now());
Insert into items values (2,'Litecoin','L001',1,now());
Insert into items values (3,'XRP','x001',1,now());
Insert into items values (4,'Cardano','c001',1,now());
Insert into items values (5,'bitcoin cash','b002',1,now());
Insert into items values (6,'Tether','t001',1,now());
Insert into items values (7,'Dogecoin','d001',1,now());
Insert into items values(8,'PutinCoin','p001',1,now());
Insert into items values(9,'Polkadot','p002',0,now());
Insert into items values(10,'Whoppercoin','w001',0,now());

Insert into wallet_transactions values (1,"credit",1,1000,"failed","UPI",now());
Insert into wallet_transactions values (2,"debit",2,2000,"complete","UPI",now());
Insert into wallet_transactions values (3,"credit",3,3000,"failed","UPI",now());
Insert into wallet_transactions values (4,"debit",4,4000,"complete","UPI",now());
Insert into wallet_transactions values (5,"credit",5,5000,"failed","UPI",now());
Insert into wallet_transactions values (6,"debit",6,6000,"complete","UPI",now());
Insert into wallet_transactions values (7,"credit",7,7000,"failed","UPI",now());
Insert into wallet_transactions values (8,"debit",8,8000,"complete","UPI",now());
Insert into wallet_transactions values (9,"credit",9,9000,"failed","UPI",now());
Insert into wallet_transactions values (10,"debit",10,10000,"complete","UPI",now());
Insert into wallet_transactions values (11,"credit",11,11000,"failed","UPI",now());
Insert into wallet_transactions values (12,"debit",12,12000,"complete","UPI",now());
Insert into wallet_transactions values (13,"credit",13,13000,"failed","UPI",now());
Insert into wallet_transactions values (14,"debit",14,14000,"complete","UPI",now());
Insert into wallet_transactions values (15,"credit",15,15000,"failed","UPI",now());
Insert into wallet_transactions values (16,"debit",16,16000,"complete","UPI",now());
Insert into wallet_transactions values (17,"credit",17,17000,"failed","UPI",now());
Insert into wallet_transactions values (18,"debit",18,18000,"complete","UPI",now());
Insert into wallet_transactions values (19,"credit",19,19000,"failed","UPI",now());
Insert into wallet_transactions values (20,"debit",20,20000,"complete","UPI",now());
Insert into wallet_transactions values (21,"credit",21,21000,"failed","UPI",now());
Insert into wallet_transactions values (22,"debit",22,22000,"complete","UPI",now());
Insert into wallet_transactions values (23,"credit",23,23000,"failed","UPI",now());
Insert into wallet_transactions values (24,"debit",24,24000,"complete","UPI",now());
Insert into wallet_transactions values (25,"credit",25,25000,"failed","UPI",now());
Insert into wallet_transactions values (26,"debit",26,26000,"complete","UPI",now());
Insert into wallet_transactions values (27,"credit",27,27000,"failed","UPI",now());
Insert into wallet_transactions values (28,"debit",28,28000,"complete","UPI",now());
Insert into wallet_transactions values (29,"credit",29,29000,"failed","UPI",now());
Insert into wallet_transactions values (30,"debit",30,30000,"complete","UPI",now());
Insert into wallet_transactions values (31,"credit",31,31000,"failed","UPI",now());
Insert into wallet_transactions values (32,"debit",32,32000,"complete","UPI",now());
Insert into wallet_transactions values (33,"credit",33,33000,"failed","UPI",now());
Insert into wallet_transactions values (34,"debit",34,34000,"complete","UPI",now());
Insert into wallet_transactions values (35,"credit",35,35000,"failed","UPI",now());
Insert into wallet_transactions values (36,"debit",36,36000,"complete","UPI",now());
Insert into wallet_transactions values (37,"credit",37,37000,"failed","UPI",now());
Insert into wallet_transactions values (38,"debit",38,38000,"complete","UPI",now());
Insert into wallet_transactions values (39,"credit",39,39000,"failed","UPI",now());
Insert into wallet_transactions values (40,"debit",40,40000,"complete","UPI",now());
Insert into wallet_transactions values (41,"credit",41,41000,"failed","UPI",now());
Insert into wallet_transactions values (42,"debit",42,42000,"complete","UPI",now());
Insert into wallet_transactions values (43,"credit",43,43000,"failed","UPI",now());
Insert into wallet_transactions values (44,"debit",44,44000,"complete","UPI",now());
Insert into wallet_transactions values (45,"credit",45,45000,"failed","UPI",now());
Insert into wallet_transactions values (46,"debit",46,46000,"complete","UPI",now());
Insert into wallet_transactions values (47,"credit",47,47000,"failed","UPI",now());
Insert into wallet_transactions values (48,"debit",48,48000,"complete","UPI",now());
Insert into wallet_transactions values (49,"credit",49,49000,"failed","UPI",now());
Insert into wallet_transactions values (50,"debit",50,50000,"complete","UPI",now());


Insert into trade_transactions values (1,1,"sell","pending",1,1000,2000,now());
Insert into trade_transactions values (2,2,"buy","complete",2,2000,3000,now());
Insert into trade_transactions values (3,3,"sell","pending",3,3000,4000,now());
Insert into trade_transactions values (4,4,"buy","complete",4,4000,5000,now());
Insert into trade_transactions values (5,5,"sell","pending",5,5000,6000,now());
Insert into trade_transactions values (6,6,"buy","complete",6,6000,7000,now());
Insert into trade_transactions values (7,7,"sell","pending",7,7000,8000,now());
Insert into trade_transactions values (8,8,"buy","complete",8,8000,9000,now());
Insert into trade_transactions values (9,9,"sell","pending",9,9000,10000,now());
Insert into trade_transactions values (10,10,"buy","complete",0,10000,11000,now());
Insert into trade_transactions values (11,11,"sell","pending",1,11000,12000,now());
Insert into trade_transactions values (12,12,"buy","complete",2,12000,13000,now());
Insert into trade_transactions values (13,13,"sell","pending",3,13000,14000,now());
Insert into trade_transactions values (14,14,"buy","complete",4,14000,15000,now());
Insert into trade_transactions values (15,15,"sell","pending",5,15000,16000,now());
Insert into trade_transactions values (16,16,"buy","complete",6,16000,17000,now());
Insert into trade_transactions values (17,17,"sell","pending",7,17000,18000,now());
Insert into trade_transactions values (18,18,"buy","complete",8,18000,19000,now());
Insert into trade_transactions values (19,19,"sell","pending",9,19000,20000,now());
Insert into trade_transactions values (20,20,"buy","complete",0,20000,1000,now());
Insert into trade_transactions values (21,21,"sell","pending",1,21000,2000,now());
Insert into trade_transactions values (22,22,"buy","complete",2,22000,3000,now());
Insert into trade_transactions values (23,23,"sell","pending",3,23000,4000,now());
Insert into trade_transactions values (24,24,"buy","complete",4,24000,5000,now());
Insert into trade_transactions values (25,25,"sell","pending",5,25000,6000,now());
Insert into trade_transactions values (26,26,"buy","complete",6,26000,7000,now());
Insert into trade_transactions values (27,27,"sell","pending",7,27000,8000,now());
Insert into trade_transactions values (28,28,"buy","complete",8,28000,9000,now());
Insert into trade_transactions values (29,29,"sell","pending",9,29000,10000,now());
Insert into trade_transactions values (30,30,"buy","complete",0,30000,11000,now());
Insert into trade_transactions values (31,31,"sell","pending",1,31000,12000,now());
Insert into trade_transactions values (32,32,"buy","complete",2,32000,13000,now());
Insert into trade_transactions values (33,33,"sell","pending",3,33000,14000,now());
Insert into trade_transactions values (34,34,"buy","complete",4,34000,15000,now());
Insert into trade_transactions values (35,35,"sell","pending",5,35000,16000,now());
Insert into trade_transactions values (36,36,"buy","complete",6,36000,17000,now());
Insert into trade_transactions values (37,37,"sell","pending",7,37000,18000,now());
Insert into trade_transactions values (38,38,"buy","complete",8,38000,19000,now());
Insert into trade_transactions values (39,39,"sell","pending",9,39000,20000,now());
Insert into trade_transactions values (40,40,"buy","complete",0,40000,1000,now());
Insert into trade_transactions values (41,41,"sell","pending",1,41000,2000,now());
Insert into trade_transactions values (42,42,"buy","complete",2,42000,3000,now());
Insert into trade_transactions values (43,43,"sell","pending",3,43000,4000,now());
Insert into trade_transactions values (44,44,"buy","complete",4,44000,5000,now());
Insert into trade_transactions values (45,45,"sell","pending",5,45000,6000,now());
Insert into trade_transactions values (46,46,"buy","complete",6,46000,7000,now());
Insert into trade_transactions values (47,47,"sell","pending",7,47000,8000,now());
Insert into trade_transactions values (48,48,"buy","complete",8,48000,9000,now());
Insert into trade_transactions values (49,49,"sell","pending",9,49000,10000,now());
Insert into trade_transactions values (50,50,"buy","complete",0,50000,11000,now());

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
