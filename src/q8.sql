# Χρήση της ΒΔ my_accounts
USE my_accounts;

# (α) Εμφάνισε το id, το πλήθος και το άθροισμα των υπολοίπων των πελατών 
# που δεν έχουν id ίσο με 20. Εμφάνισε τα αποτελέσματα ανά πελάτη
SELECT custno, count(*), sum(balance) 
	FROM Accounts
	WHERE custno NOT IN (20)
	GROUP BY custno;

SET @CUST_NO = 20;

# (β) Εμφάνισε το id, το πλήθος και το άθροισμα των υπολοίπων των πελατών 
# που δεν έχουν id ίσο με το περιεχόμενο της μεταβλητής CUST_NO. 
# Εμφάνισε τα αποτελέσματα ανά πελάτη
SELECT custno, count(*), sum(balance) 
	FROM Accounts
	WHERE custno NOT IN (@CUST_NO)
	GROUP BY custno;