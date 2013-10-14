@EmployeeList = Backbone.Collection.extend
  model: Employee
  url: '/doctors.json'
  