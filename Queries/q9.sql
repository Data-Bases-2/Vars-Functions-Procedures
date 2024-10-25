# Χρήση της ΒΔ my_accounts
USE my_accounts;

# (α) Εμφάνισε το πλήθος και το άθροισμα των υπολοίπων των πελατών 
SELECT count(*), sum(balance) FROM Accounts;

SET @COUNT_acctID = 0, @SUM_acctID = 0, @AVG_acctID = 0;

# Αποθήκευσε το πλήθος των πελατών στην μεταβλητή COUNT_acctID
# Αποθήκευσε το άθροισμα των υπολοίπων των πελατών στην μεταβλητή SUM_acctID
# Αποθήκευσε τον μέσο όρο των υπολοίπων των πελατών στην μεταβλητή AVG_acctID
SELECT count(*), sum(balance), avg(balance)
	INTO @COUNT_acctId, @SUM_acctID, @AVG_acctID
    FROM Accounts;

# (β) Εμφάνισε το περιεχόμενο της μεταβλητής COUNT_acctID,
# το περιεχόμενο της μεταβλητής SUM_acctID, 
# το περιεχόμενο της μεταβλητής AVG_acctID, 
# το περιεχόμενο της μεταβλητής MY_AVG, όπου περιέχει το αποτέλεσμα
# της διαίρεσης SUM_acctID/COUNT_acctID 
SELECT @COUNT_acctID, @SUM_acctID, @AVG_acctID, @MY_AVG := @SUM_acctID/@COUNT_acctID;