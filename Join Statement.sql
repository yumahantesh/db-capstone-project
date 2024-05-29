SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.TotalCost, Menus.Courses, Menus.Starters
FROM Customers Customers INNER JOIN
Orders Orders
ON Customers.CustomerID = Orders.OrderID
INNER JOIN Menu Menus
ON Orders.MenuID = Menus.MenuID
ORDER BY Orders.TotalCost;