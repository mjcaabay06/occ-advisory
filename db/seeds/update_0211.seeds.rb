r = Remark.find(16)
r.update(remark: 'Aircraft Flight Schedule Business')

r = Remark.find(17)
r.update(remark: 'Aircraft Flight Schedule Economy')

u = UserDepartment.where(id: [2,8,9])
u.update_all("category_fields = array_append(category_fields, '3')")
