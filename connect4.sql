drop table if exists moves cascade;

create table moves (
    player text not null check (player = 'red' or player = 'black'),
    move_column integer not null check (move_column between 0 and 7),
    move_row integer not null check (move_row between 0 and 6),

    unique (move_column, move_row)

);

-- There should be a constraint to verify that no move is just floating
-- in space.  In other words, the row of any piece must either be zero,
-- or must be the max + 1 of all the other moves in the same column.

-- Also, we could add a constraint to verify that one player doesn't
-- ever move twice before the other person moves once..  For example,
-- if black has 0 moves inserted, and red has 1 move inserted, it is
-- black's turn, so we should block red making another move until black
-- makes a move.

insert into moves
(player, move_column, move_row)
values
('red', 0, 0),
('black', 1, 0),
('black', 1, 1),
('black', 2, 0),
('red', 2, 1),
('red', 2, 2),
('black', 3, 0),
('black', 3, 1),
('red', 3, 2),
('red', 4, 0),
('black', 4, 1)
;

-- Check for 2-in-a-row vertical matches
create or replace view v2
as
select m1.player, m1.move_column, m1.move_row
from moves m1

join moves m2
on m1.player = m2.player

where m1.move_column = m2.move_column
and m1.move_row + 1 = m2.move_row;

-- Check for 4 in a row, any direction

create or replace view winning_games
as
select m1.player, m1.move_column, m1.move_row
from moves m1

join moves m2
on m1.player = m2.player

join moves m3
on m2.player = m3.player

join moves m4
on m3.player = m4.player

where
-- vert (column, row) (0, 0) matches (0, 1)
(
    m1.move_column = m2.move_column
    and m1.move_row + 1 = m2.move_row

    and m2.move_column = m3.move_column
    and m2.move_row + 1 = m3.move_row

    and m3.move_column = m4.move_column
    and m3.move_row + 1 = m4.move_row
)

-- horiz (0, 0) matches (1, 0)
or (

    m1.move_column + 1 = m2.move_column
    and m1.move_row = m2.move_row

    and m2.move_column + 1 = m3.move_column
    and m2.move_row = m3.move_row

    and m3.move_column + 1 = m4.move_column
    and m3.move_row = m4.move_row

)

-- diag up (0, 0) matches (1, 1)
or (

    m1.move_column + 1 = m2.move_column
    and m1.move_row + 1 = m2.move_row

    and m2.move_column + 1 = m3.move_column
    and m2.move_row + 1 = m3.move_row

    and m3.move_column + 1 = m4.move_column
    and m3.move_row + 1 = m4.move_row

)

-- diag dn (0, 1) matches (1, 0)
or (

    m1.move_column + 1 = m2.move_column
    and m1.move_row - 1 = m2.move_row

    and m2.move_column + 1 = m3.move_column
    and m2.move_row - 1 = m3.move_row

    and m3.move_column + 1 = m4.move_column
    and m3.move_row - 1 = m4.move_row

)
;


-- So, lets insert two more red checkers in column two:

insert into moves
(player, move_column, move_row)
values
('red', 2, 3),
('red', 2, 4);



