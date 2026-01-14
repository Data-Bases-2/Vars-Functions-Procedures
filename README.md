<p align="center">
  <img src="https://www.especial.gr/wp-content/uploads/2019/03/panepisthmio-dut-attikhs.png" alt="UNIWA" width="150"/>
</p>

<p align="center">
  <strong>UNIVERSITY OF WEST ATTICA</strong><br>
  SCHOOL OF ENGINEERING<br>
  DEPARTMENT OF COMPUTER ENGINEERING AND INFORMATICS
</p>

---

<p align="center">
  <strong>Databases II</strong>
</p>

<h1 align="center">
  Variables, Functions, Procedures
</h1>

<p align="center">
  <strong>Vasileios Evangelos Athanasiou</strong><br>
  Student ID: 19390005
</p>

<p align="center">
  <a href="https://github.com/Ath21" target="_blank">GitHub</a> ·
  <a href="https://www.linkedin.com/in/vasilis-athanasiou-7036b53a4/" target="_blank">LinkedIn</a>
</p>

<p align="center">
  Supervisor: Rania Garofalaki, Laboratory Teaching Staff<br>
</p>

<p align="center">
  <a href="https://ice.uniwa.gr/en/emd_person/zacharenia-garofalaki/" target="_blank">UNIWA Profile</a> ·
  <a href="https://www.linkedin.com/in/rania-garofalaki-4761b071/" target="_blank">LinkedIn</a>
</p>

<p align="center">
  Athens, February 2024
</p>

---

# Project Overview

The exercise focuses on SQL and PL/SQL functionalities, including the use of variables, functions, and stored procedures to manipulate data across multiple databases.

---

## Table of Contents


| Section | Folder / File | Description |
|------:|---------------|-------------|
| 1 | `assign/` | Laboratory / Assignment material |
| 1.1 | `assign/laboratory_5.pdf` | Laboratory instructions (English) |
| 1.2 | `assign/εργαστήριο_5.pdf` | Laboratory instructions (Greek) |
| 2 | `docs/` | Theoretical documentation |
| 2.1 | `docs/Vars-Functions-Procedures.pdf` | Theory on variables, functions, and procedures (English) |
| 2.2 | `docs/Μεταβλητές-Συναρτήσεις-Διαδικασίες.pdf` | Theory on variables, functions, and procedures (Greek) |
| 3 | `dbs/` | ER diagrams or database images |
| 3.1 | `dbs/Accounts.png` | Accounts database ER diagram |
| 3.2 | `dbs/Personnel.png` | Personnel database ER diagram |
| 4 | `res/` | Visual query results / screenshots |
| 4.1 | `res/q1-q15*.png` | Screenshots of queries 1–15, multi-part images included |
| 5 | `src/` | SQL scripts |
| 5.1 | `src/par1–par6.sql` | Example scripts for variables, functions, and procedures |
| 5.2 | `src/q2–q15.sql` | Query scripts for exercises and labs |
| 6 | `README.md` | Repository overview and instructions |

---


## Database Schemas
The exercise utilizes two primary database structures:

### 1. Personnel Database (`personnel`)
A management database consisting of three core tables:

- **DEPT:** Department details including number, name, and location (e.g., Sales in Athens).  
- **JOB:** Job roles, descriptions, and salary scales.  
- **EMP:** Employee records linking to jobs and departments, including commission data.  

### 2. Accounts Database (`my_accounts`)
A financial database designed for transaction testing:

- **Accounts:** Stores account IDs (`acctID`) and balances.  
- **Customers:** Stores customer identification and names.  

## Key Activities & Learning Objectives
The laboratory work covers the following SQL and PL/SQL functionalities:

### Database Management
- Creating, selecting, and dropping databases and tables.

### Data Manipulation
- Inserting records and updating balances or foreign key relationships.

### Variables and Functions
- Implementing a factorial function to calculate `n!`.  
- Defining local variables within procedures for complex calculations.

### Stored Procedures
- Creating a procedure named `my_procedure_Local_Variables`.  
- Developing a `BankTransfer` procedure to handle money transfers between accounts.

### Transactions
- Demonstrating the use of `COMMIT` and `ROLLBACK` for data integrity.  
- Analyzing unreliable transactions that lack sufficiency checks (e.g., checking for adequate funds before transfer).

## Technical Environment
- The exercise is performed using **MySQL Workbench**.  
- Screenshots and results throughout the report illustrate the execution of queries, procedures, and transactions.

---

# Installation & Setup Guide

This repository contains a **personnel and accounts database project** developed for the **Databases II** course at the **University of West Attica (UNIWA)**.  
It demonstrates **SQL and PL/SQL functionalities**, including variables, functions, stored procedures, and transaction management.

---

## Prerequisites

Before starting, ensure the following software and knowledge are available:

### 1. Database Management System (DBMS)
- **MySQL 8.0** (recommended)
- Compatible alternatives:
  - MariaDB
  - PostgreSQL *(minor syntax adjustments may be required)*

### 2. SQL Client / Interface
A tool to execute `.sql` scripts and manage the database:
- **MySQL Workbench** (recommended)
- phpMyAdmin
- DBeaver
- Command-line MySQL client

### 3. Knowledge Requirements
- SQL basics: `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, `SELECT`, `UPDATE`, `DELETE`
- Understanding of **primary keys, foreign keys, and data types**
- Familiarity with aggregate functions: `SUM()`, `AVG()`, `COUNT()`
- Basic understanding of **stored procedures, functions, and variables**
- Knowledge of **transactions**, including `COMMIT` and `ROLLBACK`

---

## Installation

### 1. Clone the Repository

Open a terminal or command prompt and run:

```bash
git clone https://github.com/Data-Bases-2/Vars-Functions-Procedures.git

```

#### Alternative (Without Git)

- Open the repository URL in your browser
- Click Code → Download ZIP
- Extract the ZIP file to a local directory

### 2. Open SQL Client
- Launch your preferred SQL client (e.g., MySQL Workbench)
- Connect to your local or remote MySQL server

### 3. Create the Database
- If the databases do not exist, execute:
```sql
CREATE DATABASE IF NOT EXISTS personnel;
USE personnel;

CREATE DATABASE IF NOT EXISTS my_accounts;
USE my_accounts;
```

### 4. Create Tables

Run the provided SQL scripts in `src/`:
- Personnel database (`personnel.sql`)
```sql
CREATE TABLE DEPT (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(50),
    LOC VARCHAR(50)
);

CREATE TABLE JOB (
    JOBCODE INT PRIMARY KEY,
    JOB_DESCR VARCHAR(50),
    SAL INT
);

CREATE TABLE EMP (
    EMPNO INT PRIMARY KEY,
    NAME VARCHAR(50),
    JOBNO INT,
    DEPTNO INT,
    COMM INT,
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO),
    FOREIGN KEY (JOBNO) REFERENCES JOB(JOBCODE)
);
```
- Accounts database (`Accounts.sql` if provided)
```sql
CREATE TABLE Accounts (
    acctID INT PRIMARY KEY,
    balance DECIMAL(10,2)
);

CREATE TABLE Customers (
    custID INT PRIMARY KEY,
    custName VARCHAR(50)
);
```
> Tip: Execute the full SQL scripts in one step to ensure all tables, constraints, and initial data are created.

### 5. Insert Sample Data

Populate tables with example records using the `INSERT INTO` statements in the `src/` scripts.
Refer to `res/` for visual guidance on expected query results.

### 6. Create Functions and Procedures
Run scripts for variables, functions, and procedures (par1–par6.sql and q2–q15.sql):
- Examples include:
  - Factorial function
  - Local variable usage in procedures
  - `BankTransfer` procedure with transaction handling
  - `my_procedure_Local_Variables`

### 7. Test Transactions
- Verify correct operation of procedures with `COMMIT` and `ROLLBACK`
- Check that invalid operations (e.g., insufficient funds in `BankTransfer`) are properly handled

### 8. Verify Tables and Functions
```sql
USE personnel;
SHOW TABLES;
SELECT * FROM DEPT;
SELECT * FROM JOB;
SELECT * FROM EMP;

USE my_accounts;
SHOW TABLES;
SELECT * FROM Accounts;
SELECT * FROM Customers;

-- Test procedures/functions
CALL my_procedure_Local_Variables();
SELECT factorial(5);
```

---

## Open the Documentation
1. Navigate to the `docs/` directory
2. Open the report corresponding to your preferred language:
    - English: `Vars-Functions-Procedures.pdf`
    - Greek: `Μεταβλητές-Συναρτήσεις-Διαδικασίες.pdf`