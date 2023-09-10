create or replace table manager(empl_id varchar(10)
, empl_name varchar(10)
, manager_id varchar(10));
insert into manager values('1','Roopak',null);
insert into manager values('2','Amrit','1');
insert into manager values('3','Amal','1');
insert into manager values('4','Amal','1');
insert into manager values('5','Vimal','2');
insert into manager values('6','Jincy',null);
insert into manager values('5','Shruthy','6');
with recursive cte as
(
select empl_name, empl_id,manager_id, 1 as level, '0' as m_list from PRACTICE.SQL.MANAGER where manager_id is null
union all
select m.empl_name, m.empl_id, m.manager_id, cte.level+1, concat(concat(cte.m_list,','),m.manager_id) as m_list
from cte
join PRACTICE.SQL.MANAGER m
on cte.empl_id = m.manager_id
)
select top_manager, count(*) as number_of_employees from (
select right(left(m_list,3),1) as top_manager from cte)
group by 1
having top_manager <> '0';
