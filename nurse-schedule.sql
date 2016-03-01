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

create table shifts (
	title text primary key
);

insert into shifts
(title)
values
('day shift'),
('night shift');

create table shift_requirements (
	shift text not null references shifts (title),
	requirement text not null references credentials (title)
);

insert into shift_requirements
(shift, requirement)
values <F4>


create table nurses (
	display_name text primary key
);

create table nurse_credentials (
	nurse text not null references nurses (display_name),
	credential text not null references credentials (title)
);
