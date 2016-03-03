all:	rendered/index.html rendered/sql-is-awesome.pdf

rendered/index.html:	index.txt style.css connect-4.txt nurse-schedule.txt footnotes.txt
	rst2html5 --bootstrap-css --stylesheet style.css index.txt rendered/index.html

rendered/sql-is-awesome.pdf:	index.txt connect-4.txt nurse-schedule.txt
	rst2pdf index.txt rendered/sql-is-awesome.pdf
