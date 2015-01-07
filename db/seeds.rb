# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
types = Type.create([{ name: 'full time'}, {name: 'part time'}, {name: 'project'}])

categories = Category.create([{name: 'Developer'}, {name: 'System Administrator'}, {name: 'Designer'}, {name: 'Other'}])

orgs = Org.create([{name: 'Company A'}, {name: 'Company B'}])

jobs = Job.create([ {title: 'software developer', type: types.first, category: categories.first, jd: 'to do', org: orgs.first},
        {title: 'sr software developer', type: types.first, category: categories.first, jd: 'to do', org: orgs.first},
        {title: 'sr software tester', type: types.first, category: categories.first, jd: 'to do', org: orgs.first},
        {title: 'designer', type: types.first, category: categories.first, jd: 'to do', org: orgs.first},
        {title: 'staff engineer', type: types.first, category: categories.first, jd: 'to do', org: orgs.first},
        {title: 'architect', type: types.first, category: categories.first, jd: 'to do', org: orgs.first}])