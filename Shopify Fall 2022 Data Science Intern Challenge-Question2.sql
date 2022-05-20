-- (a)
Select ShipperName as "Shipping Company", count(distinct(OrderID)) as "Order Count"
from 
  Orders as o 
  LEFT JOIN Shippers as s 
  using (ShipperID) 
where s.ShipperName = 'Speedy Express' ;

-- (b)
Select LastName, count(distinct(OrderId)) as "Order Count" 
from Orders 
  LEFT JOIN Employees 
  using (EmployeeID) 
group by EmployeeID 
order by "Order Count" desc
limit 1;

-- (c)
Select ProductName as "Most Purchased Product from customers in Germany"
from (
  Select od.ProductID, SUM(od.Quantity) as count 
  from OrderDetails as od 
  where od.OrderID in (
    Select OrderID 
    from Orders as o 
    where o.CustomerID in (
      Select CustomerID 
      from Customersas c 
      where c.Country == 'Germany'
    )
  ) 
    group by od.ProductID 
    order by count desc 
    limit 1
)
LEFT JOIN Products 
using (ProductID);