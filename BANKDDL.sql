use master
go
CREATE TABLE ACCOUNTCATEGORY(
CategoryID int not null,
CategoryType varchar(45) not null,
constraint [PK_ACCTCATEGORY] primary key(CategoryID),
constraint [CHK_CategoryType] check(CategoryType in('SAVINGS', 'CHECKINGS', 'FIXED DEPOSIT', 'TREASURY BILL', 
 'INVESTMENT', 'GOLD', 'PREMIUM'))
);
go
CREATE TABLE ACCOUNT(
AccountNumber int not null,
CategoryType varchar(45) not null,
CategoryID int not null,
InitialDeposit DECIMAL(10, 2) not null,
AccountDate DATE not null,
InterestRate FLOAT null,
InterstAccrued DECIMAL(8, 2) null,
TotalBalanceDue DECIMAL(10, 2) not null,
CustomerID int not null,
BankStaffID int not null,
constraint [PK_ACCOUNT] primary key(AccountNumber),
constraint [FK_ACCT_ACCTCATEGORY] foreign key(CategoryID)
references ACCOUNTCATEGORY(CategoryID)
);
go
CREATE TABLE BANKCUSTOMER(
CustomerID int not null,
FirstName varchar(45) not null,
LastName varchar(50) not null,
Street varchar(50) not null,
City varchar(45) not null,
RegionState varchar(45) not null,
ZipCode int not null,
BirthDate DATE not null,
TellNumber FLOAT not null,
constraint [PK_BANKCUSTOMER] primary key(CustomerID),
);
go
CREATE TABLE CUSTOMERACCOUNT(
CustomerAccountNum int not null,
AccountNumber int not null,
CustomerID int not null,
TotalBalance DECIMAL(10, 2) not null,
AccountConditionID int not null,
AccountCopyID int not null,
BranchID int not null,
constraint [PK_CUSTOMERACCT] primary key(CustomerAccountNum, AccountNumber),
constraint [FK_CUSTACCT_CUSTOMER] foreign key(CustomerID)
references BANKCUSTOMER(CustomerID),
constraint [FK_CUSTACCT_ACCT] foreign key(AccountNumber)
references ACCOUNT(AccountNumber),
); 
go
ALTER TABLE ACCOUNTCATEGORY
add constraint [CHK_CategoryType] check(CategoryType in('SAVINGS', 'CHECKINGS', 'FIXED DEPOSIT', 'TREASURY BILL',
 'INVESTMENT', 'GOLD', 'PREMIUM'))
 go
 CREATE TABLE ACCOUNTCOPY(
 AccountcopyID int not null,
 AccountNumber int not null,
 BranchID int not null,
 CategoryType varchar(45) not null,
 ConditionID int not null,
 LoanID int null,
 CustomerID int not null,
 CustomerName varchar(60) not null,
 TotalBalance DECIMAL(10, 2) not null
 constraint [PK_ACCOUNTCOPY] primary key(AccountcopyID, AccountNumber),
 constraint [FK_ACCTCOPY_ACCOUNT] foreign key(AccountNumber)
 references ACCOUNT(AccountNumber)
 );
 go
 CREATE TABLE BANKBRANCHES(
 BranchID int not null,
 BranchName varchar(50) not null,
 Street varchar(45) not null,
 City varchar(45) not null,
 RegionState varchar(45) not null,
 ZipCode int not null,
 TellNumber FLOAT not null,
 FaxNumber FLOAT not null,
 BranchManager varchar(50) not null,
 AccountcopyID int not null,
 constraint [PK_BANKBRANCHES] primary key(BranchID)
 );
 go
 alter table ACCOUNTCOPY
 drop constraint [PK_ACCOUNTCOPY]
 go
 alter table ACCOUNTCOPY
 add constraint [PK_ACCOUNTCOPY] primary key(AccountcopyID, AccountNumber)
 go
 alter table ACCOUNTCOPY
 add constraint [FK_ACCOUNTCOPY_BRANCHES] foreign key(BranchID)
 references BANKBRANCHES(BranchID)
 go
 alter table ACCOUNTCOPY
 add constraint [FK_ACCTCOPY_BRANCHES] foreign key(AccountcopyID)
 references BANKBRANCHES(AccountcopyID)
 go
 CREATE TABLE LOANACCOUNT(
 LoanAccountID int not null,
 AccountcopyID int not null,
 BankCardID int not null,
 BranchID int not null,
 LoanDate DATE not null,
 NumOfMonths int not null,
 EndDate DATE not null,
 LoanAmount DECIMAL(10, 2) not null,
 InterestRate FLOAT not null,
 InterestAccrued DECIMAL(8, 2) not null,
 Balancedue DECIMAL(10, 2) not null,
 TotalBalancedue DECIMAL(10, 2) not null,
 constraint [PK_LOANACCT] primary key(LoanAccountID),
 constraint [FK_LOANACCT_BANKBRANCHE] foreign key(BranchID)
 references BANKBRANCHES(BranchID)
 );
 go
 CREATE TABLE ACCOUNTCONDITION(
 AcctConditionID int not null,
 AccountDescription varchar(45) not null,
 AccountcopyID int not null,
 BranchID int not null,
 constraint [PK_ACCTCONDITION] primary key(AcctConditionID),
 constraint [FK_ACCTCONDITION_BANKBRANCH] foreign key(BranchID)
 references BANKBRANCHES(BranchID),
 constraint [CHK_AccountDescription] check(AccountDescription in('ACTIVE', 'SUSPENDED', 'CLOSED'))
 );
 go
 CREATE TABLE PAYMENTS(
 PaymentID int not null,
 PaymentDate DATE not null,
 AmountPaid DECIMAL(10, 2) not null,
 LoanAccountID int not null,
 constraint [PK_PAYMENTS] primary key(PaymentID),
 constraint [FK_PAYT_LOANACCT] foreign key(LoanAccountID)
 references LOANACCOUNT(LoanAccountID)
 );
 go
 CREATE TABLE BANKEMPLOYEES(
 EmployeeID int not null,
 FirstName varchar(45) not null,
 LastName varchar(50) not null,
 Street varchar(30) not null,
 City varchar(20) not null,
 RegionState varchar(45) not null,
 ZipCode int not null,
 TellNumber FLOAT not null,
 BirthDate DATE not null,
 HireDate DATE not null,
 EmpTitle varchar(45) not null,
 Salary DECIMAL(10, 2) not null,
 VacationTime int not null,
 RetirementDate DATE not null,
 Attendance varchar(45) not null,
 BranchID int not null,
 constraint [PK_BANKEMPLOYEES] primary key(EmployeeID),
 constraint [FK_EMP_BRANCHES] foreign key(BranchID)
 references BANKBRANCHES(BranchID),
 constraint [CHK_Attendance] check(Attendance in('ACTIVE', 'SICK', 'VACATION', 'LEAVE', 'RETORED'))
 );
 go
 CREATE TABLE BANKPROFESSIONALS(
 ProfessionalsID int not null,
 FirstName varchar(45) not null,
 LastName varchar(50) not null,
 DegreeType varchar(45) not null,
 DateOfDegree DATE not null,
 SchoolName varchar(50) not null,
 BranchID int not null,
 EmployeeID int not null,
 constraint [PK_BANKPROFESSIONALS] primary key(ProfessionalsID),
 constraint [FK_BANKPROF_EMPLOYEE] foreign key(EmployeeID)
 references BANKEMPLOYEES(EmployeeID)
 );
 go
 CREATE TABLE MANAGERS(
 ManagerID int not null,
 EmployeeID int not null,
 BranchID int not null,
 constraint [PK_MANAGER] primary key(ManagerID, BranchID),
 constraint [FK_MANAGER_BRANCH] foreign key(BranchID)
 references BANKBRANCHES(BranchID)
 );
 go
 CREATE TABLE BANKCARD(
 BankCardID int not null,
 CustomerName varchar(50) not null,
 CardType varchar(45) not null,
 DateIssued DATE not null,
 ExpiredDate DATE not null,
 CCVNumber int null,
 CardBalance DECIMAL(10, 2) not null,
 BranchID int not null,
 constraint [PK_BANKCARD] primary key(BankCardID),
 constraint [FK_BANKCARD_BRANCH] foreign key(BranchID)
 references BANKBRANCHES(BranchID),
 constraint [CHK_CardType] check(CardType in('CREDIT', 'DEBIT'))
 );
 go
 insert into ACCOUNTCATEGORY values
 (1, 'SAVINGS'),
 (2, 'CHECKINGS'),
 (3, 'FIXED DEPOSIT'),
 (4, 'TREASURY BILL'),
 (5, 'INVESTMENT'),
 (6, 'GOLD'),
 (7, 'PREMIUM')
 go
 select * from ACCOUNTCOPY
 go
 select CustomerID, FirstName, LastName, DATEDIFF(year, BirthDate, getdate()) AS [CUSTORMERS AGE] 
 from BANKCUSTOMER
 go
 insert into ACCOUNT
 values(10102021, 'SAVINGS', 1, 100000.00, '2021/01/12', null, 00.00, 100000.00, 150, 200)
 go
 insert into ACCOUNT
 values(10112021, 'CHECKINGS', 2, 120000.00, '2020/05/21', null, 00.00, 120000.00, 100, 200)
 go
 insert into ACCOUNT
 values(2021003, 'TREASURY BILL', 4, 160000.00, '2020/01/09', 0.5, 2300.00, 162300.00, 600, 700)
 go
 insert into BANKCUSTOMER
 values(150, 'CHARLES', 'BROBBEY', '0522 Blue Lagoon Road Sakaman', 'Accra', 'Greater Accra', 00233, '1964/12/14', 0556792915)
 go
 insert into BANKCUSTOMER
 values(100, 'DANIEL', 'ADU BROBBEY', '5877 Jackson Road Odorkor', 'Accra', 'Greater Accra', 00233, '1958/05/07', 0245863214)
 go
 insert into BANKCUSTOMER
 values(603, 'JOSEPH', 'YAW AMPAABEN', '0140 Suame Street', 'Kumasi', 'Ashanti Region', 00233, '1975/11/11', 0302151245)
 go
 insert into BANKCUSTOMER
 values(600, 'BENARD', 'AGYEKUM BOATENG', '0121 Bekyem Ave', 'Sunyani', 'Bono Region', 00233, '1962/10/12', 0245128956)
 go
 insert into CUSTOMERACCOUNT
 values(0022, 10102021, 150, 100000.00, 0010, 0022, 222)
 go
 insert into CUSTOMERACCOUNT
 values(0033, 10112021, 100, 120000.00, 0011, 0033, 221)
 insert into CUSTOMERACCOUNT
 values(0044, 2021003, 600, 160000.00, 0012, 1111, 220)
 go
 insert into ACCOUNTCOPY
 values(0022, 10102021, 222, 'SAVINGS', 0010, 4000, 150, 'Charles Brobbey', 100000.00)
 go
 insert into ACCOUNTCOPY
 values(0033, 10112021, 221, 'CHECKINGS', 0011, 4001, 100, 'Daniel Adu Brobbey', 120000.00)
 go
 insert into BANKBRANCHES
 values(222, 'Kaneshie Market', '2010 Kaneshie Street', 'Accra', 'Greater Accra', 00233, 030215469, 0302154698, 'Yaw Ampofo', 0022)
 go
 insert into BANKBRANCHES
 values(221, 'Odorkor Official Town', '205 Odorkor High Street', 'Accra', 'Greater Accra', 00233, 0242001542, 0243215468, 'Ayitey Jessica', 0033)
 go
 insert into BANKBRANCHES
 values(220, 'Accra High St', '100 Accra High St', 'Accra', 'Greater Accra', 00233, 0551203210, 0552154210, 'Benjamin Arthor', 1111)
 go
 insert into ACCOUNTCOPY
 values(1111, 2021003, 220, 'TREASURY BILL', 0012, 4019, 600, 'Agyekum Boateng', 160000.00)
 go
 insert into ACCOUNTCOPY
 values(11, 10122021, 222, 'SAVINGS', 13, null, 250, 'Jessica Johnson', 80000.00)
 go
 insert into ACCOUNT
 values(10122021, 'SAVINGS', 1, 80000.00, '2014/02/12', null, 00.00, 80000.00, 250, 150)
 go
 insert into BANKCUSTOMER
 values(250, 'Jessica', 'Johnson', '2010 Betom Street', 'Koforidua', 'Eastern Region', 233, '1972/04/24', 0244655623)
 go
 insert into CUSTOMERACCOUNT
 values(500, 10122021, 250, 80000.00, 400, 11, 222)
 go
 insert into BANKBRANCHES
 values(222, 'Kaneshie Market', '2010 Kaneshie Street', 'Accra', 'Greater Accra', 233, 30215469, 302154698, 'Yaw Ampofo', 11, 10122021)
 go
 alter table BANKBRANCHES
 add AccountNumber int
 go
 alter table BANKBRANCHES
 add constraint [FK_BRANCHES_ACCOUNT] foreign key(AccountNumber)
 references ACCOUNT(AccountNumber)
 go
 alter table ACCOUNTCOPY
 drop constraint [FK_ACCOUNTCOPY_BRANCHES]
 go
 insert into ACCOUNTCONDITION
 values(0010, 'ACTIVE', 0022, 222)
 go
 insert into ACCOUNTCONDITION
 values(0011, 'ACTIVE', 0033, 221)
 go
 insert into ACCOUNTCONDITION
 values(0012, 'SUSPENDED', 1111, 220)
 go
 insert into BANKBRANCHES
 values(203, 'Adum Mrom', '1524 Adum Street', 'Kumasi', 'Ashanti Region', 233, 0551246523, 0551245633, 'Esther Colley', 1212, null)
 go
 insert into LOANACCOUNT
 values(4000, 0022, 255455667, 222, '2020/12/14', 3, '2021/02/24', 600000.00, 1.5, 27000.00, 600000.00, 602700.00)
 go
 insert into LOANACCOUNT
 values(4001, 0033, 62254401, 221, '2020/11/28', 3, '2021/01/28', 120000.00, 1.5, 5400.00, 120000.00, 125400.00)
 go
 insert into LOANACCOUNT
 values(4019, 1111, 741174110, 220, '2020/10/23', 3, '2020/12/28', 100000.00, 1.5, 4500, 100000.00, 104500.00)
 go
 insert into LOANACCOUNT
 values(4018, 1111, 72217221, 220, '2020/12/10', 3, '2021/02/10', 50000.00, 1.5, 2250.00, 50000.00, 52250.00)
 go
 insert into PAYMENTS
 values(4500, '2021/01/05', 90000.00, 4019)
 go
 insert into PAYMENTS
 values(4501, '2021/01/06', 10000.00, 4019)
 go
 insert into BANKEMPLOYEES
 values(700, 'Charles', 'Brobbey', '1452 Blue Lagoon Street', 'Accra', 'Greater Accra', 233, 0245612356, '1969/12/12', '2018/02/08', 'Branch Manager', 
  5000.00, 15, '2029/12/12', 'ACTIVE', 222)
  go
  insert into BANKEMPLOYEES
  values(701, 'Stephany', 'Agyeiwaa', '561 South Suntreso', 'Kumasi', 'Ashanti Region', 233, 0552146325, '1988/02/12', '2019/11/02', 'Cashier', 
   3000.00, 12, '2048/02/12', 'ACTIVE', 203)
   go
   insert into BANKEMPLOYEES
   values(702, 'John', 'Akrugu', '4125 Dansoman Street', 'Accra', 'Greater Accra', 233, 0272365461, '1964/07/29', '2016/02/08', 'Janitor', 
   1500.00, 10, '2024/07/29', 'ACTIVE', 222)
   go
   insert into BANKEMPLOYEES
   values(703, 'Micheal', 'Ayitey', '2631 Suame Magazine', 'Kumasi', 'Ashanti Region', 233, 0245621254, '1967/04/05', '2012/07/07', 'Branch Manager',
    5000.00, 15, '2027/04/05', 'ACTIVE', 203)
	go
	insert into BANKEMPLOYEES
	values(704, 'James', 'Quansah', '475 East Legon', 'Accra', 'Greater Accra', 233, 0541203652, '1968/08/02', '2017/02/08', 'Accountant', 
	4500.00, 15, '2028/08/02', 'ACTIVE', 221)
	go
	insert into MANAGERS
	values(1555, 703, 203)
	go
	insert into MANAGERS
	values(1557, 700, 222)
	go
	insert into MANAGERS
	values(1556, 600, 221)
	go
	insert into BANKEMPLOYEES
	values(600, 'Genevive', 'Akwetey Armah', '566 James Town St', 'Accra', 'Greater Accra', 233, 0554875641, '1994/12/10', '2015/11/07', 
	 'Branch Manager', 5000.00, 15, '2054/12/10', 'ACTIVE', 221)
	 go
	 insert into BANKEMPLOYEES
	 values(709, 'Francis', 'Appiagyei', '5241 Ogle Street', 'Accra', 'Greater Accra', 233, 0241523625, '1992/02/03', '2014/11/02', 
	  'Branch Manager', 5000.00, 15, '2052/02/03', 'ACTIVE', 220)
	  go
	  insert into MANAGERS
	  values(1550, 709, 220)
	  go
	  insert into BANKPROFESSIONALS
	  values(3030, 'Francic', 'Appiagyei', 'Chatered Accountant', '2013/03/07', 'University of Ghana Legon', 220, 709)
	  go
	  insert into BANKPROFESSIONALS
	  values(3033, 'Genevive', 'Akwetey Armah', 'Accountant', '2014/08/05', 'Institute of Deep Accounting', 221, 600)
	  go
	  insert into BANKPROFESSIONALS
	  values(3036, 'James', 'Quansah', 'Accountant', '2016/02/11', 'Chatered Institute of Accounting', 221, 704)
	  go
	  insert into BANKPROFESSIONALS
	  values(3022, 'Machael', 'Ayitey', 'Chattered Accountant', '2012/05/05', 'Institute of Professional Studies', 203, 703)
	  go
	  insert into BANKPROFESSIONALS
	  values(3077, 'Charles', 'Brobbey', 'Chattered Accountant', '2017/05/02', 'Institute of Professional Studies', 222, 700)
	  go
	  insert into BANKCARD
	  values(5007, 'Benard Agyekum', 'DEBIT', '2020/12/03', '2030/12/03', null, 60000.00, 222)
	  go
	  insert into BANKCARD
	  values(5005, 'Charles Brobbey', 'CREDIT', '2020/08/02', '2030/08/02', null, 100000.00, 222)
	  go
	  insert into ACCOUNT
	  values(102233, 'FIXED DEPOSIT', 3, 500000.00, '2020/12/01', 0.7, 2500.00, 502500.00, 902, 150)
	  go
	  insert into BANKCUSTOMER
	  values(902, 'Sylvester', 'Soke', '522 Darkuman Street', 'Accra', 'Greater Accra', 233, '1965/05/02', 0240252563)
	  go
	  insert into CUSTOMERACCOUNT
	  values(2020030, 102233, 902, 502500.00, 609, 88, 222)
	  go
	  insert into ACCOUNTCOPY
	  values(88, 102233, 222, 'FIXED DEPOSIT', 609, null, 902, 'Sylvester Soke', 502500.00)
	  go
	  insert into ACCOUNTCONDITION
	  values(609, 'ACTIVE', 88, 222)
	  go
	  insert into BANKBRANCHES
	  values(300, 'Kotokoraba Market', '2014 Kotokoraba Road', 'Cape Coast', 'Central Region', 233, 0245212635, 0245215621, 'Blankson Ekow', 210073, null)
	  go
	  insert into BANKEMPLOYEES
	  values(800, 'Blankson', 'Ekow', '1240 White Lane Ave', 'Cape Coast', 'Central Region', 233, 02447891254, '1968/05/12', '2014/12/09', 'Branch Manager', 
	   5000.00, 15, '2028/12/09', 'Active', 300)
	   go
	   insert into BANKPROFESSIONALS
	   values(3088, 'Blankson', 'Ekow', 'Accountant', '2014/11/07', 'University Of Cape Coast', 300, 800)
	   go
	   insert into MANAGERS
	   values(1577, 800, 300)
	   go
	   insert into BANKCARD
	   values(5003, 'Blankson Ekow', 'DEBIT', '2020/08/24', '2030/08/24', 225, 120000.00, 300)
	   go
	   insert into LOANACCOUNT
	   values(4012, 212121, 5003, 300, '2020/02/24', 3, '2020/05/24', 20000.00, 1.5, 500.00, 20000.00, 20500.00)
	   go
	   insert into PAYMENTS
	   values(4579, '2020/12/12', 10000.00, 4012)
	   go
	   insert into PAYMENTS
	   values(3008, '2020/08/12', 12000.00, 4012)
	   go
	   select BANKEMPLOYEES.EmployeeID, FirstName, LastName, MANAGERS.ManagerID
	   from BANKEMPLOYEES inner join MANAGERS on BANKEMPLOYEES.EmployeeID = MANAGERS.EmployeeID
	   go
	   select BANKCUSTOMER.CustomerID, FirstName, LastName, CUSTOMERACCOUNT.CustomerAccountNum, AccountCopyID, BranchID
	   from BANKCUSTOMER inner join CUSTOMERACCOUNT on BANKCUSTOMER.CustomerID = CUSTOMERACCOUNT.CustomerID
