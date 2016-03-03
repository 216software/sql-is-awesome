create table garages (
    title text primary key,
    location geography
);

create table reservations (
    garage text references garages (title),
    start timestamp,
    end timestamp
);

create table rules
(
    garage text references garages (title),
    starts time not null,
    ends time not null,
    price numeric not null
);
