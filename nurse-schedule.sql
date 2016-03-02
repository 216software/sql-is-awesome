drop table if exists credentials cascade;

create table credentials (
	title text primary key
);

insert into credentials
(title)
values
('RN'),
('Involves care for dementia patients'),
('Nurse manager'),
('LPN');

drop table if exists shifts cascade;

create table shifts (
	title text primary key
);

insert into shifts
(title)
values
('day shift'),
('night shift');

drop table if exists shift_requirements cascade;

create table shift_requirements (
	shift text references shifts (title),
	requirement text references credentials (title),
    primary key (shift, requirement)
);

insert into shift_requirements
(shift, requirement)
values
('day shift', 'RN'),
('day shift', 'Involves care for dementia patients'),
('day shift', 'Nurse manager'),
('night shift', 'LPN'),
('night shift', 'Involves care for dementia patients')
;

drop table if exists nurses cascade;

create table nurses (
	display_name text primary key
);

insert into nurses
(display_name)
values
('Matt'),
('Alice'),
('Bob');

drop table if exists nurse_credentials cascade;

create table nurse_credentials (
	nurse text references nurses (display_name),
	credential text references credentials (title),
    primary key (nurse, credential)
);

insert into nurse_credentials
(nurse, credential)
values
('Matt', 'LPN'),
('Matt', 'Involves care for dementia patients'),
('Alice', 'RN'),
('Alice', 'LPN'),
('Alice', 'Involves care for dementia patients'),
('Alice', 'Nurse manager'),
('Bob', 'RN'),
('Bob', 'Involves care for dementia patients'),
('Bob', 'Nurse manager')
;

select nurse, count(*)
from nurse_credentials
join shift_requirements
on nurse_credentials.credential = shift_requirements.requirement
and shift_requirements.shift = 'night shift'
group by 1
;

with a as (
    select nurse, count(*)
    from nurse_credentials
    join shift_requirements
    on nurse_credentials.credential = shift_requirements.requirement
    and shift_requirements.shift = 'night shift'
    group by 1

),

b as (
    select shift, count(*)
    from shift_requirements
    where shift = 'night shift'
    group by 1
)

select b.shift, a.nurse
from a
join b
on a.count = b.count;



