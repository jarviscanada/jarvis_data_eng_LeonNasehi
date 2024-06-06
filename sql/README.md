# Introduction

# SQL Quries

###### Table Setup (DDL)
CREATE TABLE cd.members (
			 memid integer NOT NULL,
			 surname VARCHAR(200) NOT NULL,
			 firstname VARCHAR(200) NOT NULL,
			 address VARCHAR(300) NOT NULL,
			 zipcode integer NOT NULL,
			 telephone VARCHAR(20) NOT NULL, 
			 recommendedby integer, 
			 joindate timestamp NOT NULL,
                         CONSTRAINT pk_members PRIMARY KEY (memid),
			 CONSTRAINT fk_recommendedby_members FOREIGN KEY (recommendedby) REFERENCES cd.members(memid) ON DELETE SET NULL);

CREATE TABLE cd.bookings ( 
			  bookid integer NOT NULL,
			  facid integer NOT NULL,
			  memid integer NOT NULL, 
			  starttime timestamp NOT NULL, 
		          slots integer NOT NULL, 
                          CONSTRAINT pk_bookings PRIMARY KEY (bookid),
                          CONSTRAINT fk_facid_bookings FOREIGN KEY (facid) REFERENCES cd.facilities(facid),
                          CONSTRAINT fk_memid_bookings FOREIGN KEY (memid) REFERENCES cd.members(memid));

CREATE TABLE cd.facilities (
			   facid integer NOT NULL,
			   name VARCHAR(100) NOT NULL,
			   membercost numeric NOT NULL,
			   guestcost numeric NOT NULL, 
                           initialoutlay numeric NOT NULL, 
          		   monthlymaintenece numeric NOT NULL, 
			   CONSTRAINT pk_facilities PRIMARY KEY (facid));
		         			 

###### Question 1: Show all members 

```sql
SELECT *
FROM cd.members
```

###### Questions 2: Lorem ipsum...

```sql
SELECT blah blah 
```


