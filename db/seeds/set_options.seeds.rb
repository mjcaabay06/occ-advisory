u = UserDepartment.find(2)
u.update(advisory_category_fields: [18,4,5,31,13,16],
        category_fields: [4,5],
        reason_options: [1,2,3,4],
        remark_options: [16,17] )

u = UserDepartment.find(3)
u.update(advisory_category_fields: [9,35,27,32,6,3,31],
        category_fields: [],
        reason_options: [],
        remark_options: [15],
        has_time_and_date: true)

u = UserDepartment.find(4)
u.update(advisory_category_fields: [16,4,18,21,22,23,31],
        category_fields: [],
        reason_options: [1,2,4,5],
        remark_options: [])

u = UserDepartment.find(5)
u.update(advisory_category_fields: [4,8,18,17,31],
        category_fields: [],
        reason_options: [],
        remark_options: [30],
        has_time_and_date: true)

u = UserDepartment.find(6)
u.update(advisory_category_fields: [13,24,26,25,40,4,31,34,33,2,5],
        category_fields: [1,2,3],
        reason_options: [1,2,3,4,5],
        remark_options: [1,2,3,4])

u = UserDepartment.find(7)
u.update(advisory_category_fields: [39,38,11,4,15,12,20,10,14,30,49,7,31],
        category_fields: [],
        reason_options: [1,2,3,4,5],
        remark_options: [2,3,5,6,7,8,9,10,11,12,13,14])

u = UserDepartment.find(8)
u.update(advisory_category_fields: [13,17,18,34,33,4,8,1,31,48,45,44,47,46,43,42,41],
        category_fields: [13,15,16,17,18,11,19,12],
        reason_options: [1,2,3,4,5,6],
        remark_options: [26,27,30,31,32,33],
        has_attach_advisory: true)

u = UserDepartment.find(9)
u.update(advisory_category_fields: [13,17,18,34,33,4,8,1,37,36,29,28,31,19],
        category_fields: [6,7,8,9,10,11,12],
        reason_options: [1,2,4,5],
        remark_options: [18,19,20,21,22,23,24,25,26,27,28,29])
