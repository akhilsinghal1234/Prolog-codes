%% Input inl([3,6,1,2,4,7,9],nil,X).
%% X = t(3, t(1, nil, t(2, nil, nil)), t(6, t(4, nil, nil), t(7, nil, t(9, nil, nil))))

%% del(2,t(3, t(1, nil, t(2, nil, nil)), t(6, t(4, nil, nil), t(7, nil, t(9, nil, nil)))),X).
%% X = t(3, t(1, nil, nil), t(6, t(4, nil, nil), t(7, nil, t(9, nil, nil))))

%% lookup(27,t(3, t(1, nil, t(2, nil, nil)), t(6, t(4, nil, nil), t(7, nil, t(9, nil, nil))))).
%% false.

ins(I, nil, t(I, nil, nil)).
ins(I, t(X, L, R), t(Y, P, Q)) :-
    (   I < X
    ->  ins(I, L, U),
        (P, Y, Q) = (U, X, R)
    ;   I > X
    ->  ins(I, R, U),
        (P, Y, Q) = (L, X, U)
    ;   (P, Y, Q) = (L, X, R)
    ).

lookup(X,t(X,_,_)).
lookup(X,t(V,L,_)) :- X < V, lookup(X,L).
lookup(X,t(V,_,R)) :- X > V, lookup(X,R).

del(V,t(V,nil,R),R).
del(V,t(V,L,nil),L).
del(V,t(NVal,nil,nil),t(NVal,nil,nil)) :- V \= NVal.
del(V,t(NVal,L,R),t(NVal,L,DRight)) :- V > NVal, del(V,R,DRight).
del(V,t(NVal,L,R),t(NVal,DLeft,R)) :- V < NVal, del(V,L,DLeft).
del(V,t(V,L,R),t(NewVal,L,DRight)) :- getLeftMost(R,NewVal), del(NewVal,R,DRight).

getLeftMost(t(V,nil,_),V).
getLeftMost(t(_,L,_),NVal) :- getLeftMost(L,NVal).

inl([N|Ns], T0, T) :-
    ins(N, T0, T1),
    inl(Ns, T1, T).
inl([], T, T).
