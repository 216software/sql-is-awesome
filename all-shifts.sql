with a as (

    select nurse_credentials.nurse, shift_requirements.shift,
    count(*) as credentials_count

    from nurse_credentials
    join shift_requirements
    on nurse_credentials.credential = shift_requirements.requirement
    group by 1, 2

),

b as (

    select shift_requirements.shift, count(*) as requirements_count
    from shift_requirements
    group by 1

)

select a.shift, a.nurse

from a
join b
on a.shift = b.shift
and a.credentials_count = b.requirements_count
order by 1, 2
;

