%%INPUT FORMAT :-
%%topper(a,b,r,[[abhijeet,sharma,15102,[100,98,99,96,91]],[mohit,sharma,15118,[97,93,100,92,100]],[akhil,singhal,15305,[99,99,100,90,96]]]).
%%EVALUATED BY PRIYADARSHINI
%%print all students with max marks(toppers).
%%Submitted by- Akhil Singhal, Abhijeet Sharma(Team - 1)

sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   Sum is H + Rest.

topper(Fname,Lname,Marks,List) :-
	topper1(Fname,Lname,Marks,List,[]).

topper1(Fname,Lname,[],[]).

topper1(Fname,Lname,Marks,[],[L|Original]):-
	nth0(3,L,M), nth0(0,L,F), nth0(1,L,La),
	sum_list(M,Sum),
	(
	Sum==Marks
	-> 
	write(F),write(' '),write(La),write(' '),write(Marks),nl,
	topper1(Fname,Lname,Marks,[],Original);
	topper1(Fname,Lname,Marks,[],Original)
	).

topper1(Fname,Lname,Marks,[L|[]],Original):-
	nth0(3,L,M),
	nth0(0,L,F),
	nth0(1,L,La),
	sum_list(M,Sum),
	Sum>Marks
	-> topper1(F,La,Sum,[],[L|Original]);
	topper1(Fname,Lname,Marks,[],[L|Original]).


topper1(Fname,Lname,Marks,[L,R|Rest],Original) :-	
	nth0(3,L,M), nth0(3,R,M2), nth0(0,L,F), nth0(1,L,La), nth0(0,R,F2), nth0(1,R,La2),
	sum_list(M,Sum), sum_list(M2,Sum2),
	(
	Sum=<Sum2
	-> topper1(F2,La2,Sum2,Rest,[L,R|Original]);
	topper1(F,La,Sum,Rest,[L,R|Original])
	).
