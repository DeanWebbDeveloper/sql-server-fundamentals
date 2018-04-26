from emp in Employees
from per in Contacts
where emp.ContactID==per.ContactID
orderby per.LastName, per.FirstName
select new {emp.EmployeeID, per.FirstName, per.LastName}