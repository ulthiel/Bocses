/*
	Bocses - A Magma package for computing with bocses.
	
	By 
	
	Julian Külshammer (julian.kuelshammer@mathematik.uni-stuttgart.de)
	
	and 
	
	Ulrich Thiel (thiel@mathematik.uni-stuttgart.de)
	
	File: MtrxExt.i.m

*/


declare type MtrxExt;

declare attributes MtrxExt:
    rows,
    Nrows,
    Ncols,
    BaseRing;

//==============================================================================
intrinsic MatrixExtended(n::RngIntElt,m::RngIntElt,Q::SeqEnum) -> MtrxExt
{}

    M := New(MtrxExt);
    M`Nrows := n;
    M`Ncols := m;

    M`rows := [];
    for i:=1 to n do
        Append(~M`rows, [Q[j] : j in [m*(i-1)+1..m*i]]);
    end for;

    M`BaseRing := Parent(M`rows[1][1]);
    
    return M;

end intrinsic;

//==============================================================================
intrinsic Ncols(M::MtrxExt) -> RngIntElt
{}

	return M`Ncols;

end intrinsic;

//==============================================================================
intrinsic Nrows(M::MtrxExt) -> RngIntElt
{}

	return M`Nrows;

end intrinsic;

//==============================================================================
intrinsic Print(M::MtrxExt)
{}

    for i:=1 to M`Nrows do
        printf "%o", M`rows[i];
        if i lt M`Nrows then
            printf "\n";
        end if;
    end for;

end intrinsic;

//==============================================================================
intrinsic Entry(M::MtrxExt, i::RngIntElt, j::RngIntElt) -> .
{}

    return M`rows[i][j];

end intrinsic;

//==============================================================================
intrinsic '+:='(~M::MtrxExt, N::MtrxExt)
{}

    if M`Nrows ne N`Nrows or M`Ncols ne N`Ncols then
    	//print <M`Nrows, M`Ncols>, <N`Nrows, N`Ncols>;
        error "Matrices are not of the same size.";
    end if;

    for i:=1 to M`Nrows do
        for j:=1 to M`Ncols do
            M`rows[i][j] +:= N`rows[i][j];
        end for;
    end for;

end intrinsic;

//==============================================================================
intrinsic '+'(M::MtrxExt, N::MtrxExt) -> MtrxExt
{}

    O := New(MtrxExt);
    O`Nrows := M`Nrows;
    O`Ncols := M`Ncols;
    O`rows := M`rows;
    O`BaseRing := M`BaseRing;
    O +:= N;

    return O;

end intrinsic;

//==============================================================================
intrinsic '+:='(~M::MtrxExt, x::AlgFPEltOld)
{}

    for i:=1 to M`Nrows do
        for j:=1 to M`Ncols do
            M`rows[i][j] +:= x;
        end for;
    end for;

end intrinsic;

//==============================================================================
intrinsic '+'(M::MtrxExt, x::AlgFPEltOld) -> MtrxExt
{}

    O := New(MtrxExt);
    O`Nrows := M`Nrows;
    O`Ncols := M`Ncols;
    O`rows := M`rows;
    O`BaseRing := M`BaseRing;

    O+:=x;

    return O;

end intrinsic;


//==============================================================================
intrinsic '*'(M::MtrxExt, x::AlgFPEltOld) -> MtrxExt
{}

    O := New(MtrxExt);
    O`Nrows := M`Nrows;
    O`Ncols := M`Ncols;
    O`rows := M`rows;
    O`BaseRing := M`BaseRing;

    for i:=1 to O`Nrows do
        for j:=1 to O`Ncols do
            O`rows[i][j] := O`rows[i][j]*x;
        end for;
    end for;

    return O;

end intrinsic;

//==============================================================================
intrinsic '*'(x::AlgFPEltOld, M::MtrxExt) -> MtrxExt
{}

    O := New(MtrxExt);
    O`Nrows := M`Nrows;
    O`Ncols := M`Ncols;
    O`rows := M`rows;
    O`BaseRing := M`BaseRing;

    for i:=1 to O`Nrows do
        for j:=1 to O`Ncols do
            O`rows[i][j] := x*O`rows[i][j];
        end for;
    end for;


    return O;

end intrinsic;




//==============================================================================
intrinsic '-:='(~M::MtrxExt, N::MtrxExt)
{}
	
    if M`Nrows ne N`Nrows or M`Ncols ne N`Ncols then
        error "Matrices are not of the same size.";
    end if;

    for i:=1 to M`Nrows do
        for j:=1 to M`Ncols do
            M`rows[i][j] -:= N`rows[i][j];
        end for;
    end for;

end intrinsic;

//==============================================================================
intrinsic '-'(M::MtrxExt, N::MtrxExt) -> MtrxExt
{}

    O := New(MtrxExt);
    O`Nrows := M`Nrows;
    O`Ncols := M`Ncols;
    O`rows := M`rows;
    O`BaseRing := M`BaseRing;
    O -:= N;

    return O;

end intrinsic;



//==============================================================================
intrinsic '*'(M::MtrxExt, N::MtrxExt) -> MtrxExt
{}

    if M`Ncols ne N`Nrows then
        error "Matrices are of incompatible size for multiplication.";
    end if;
	
    O := New(MtrxExt);
    O`Nrows := M`Nrows;
    O`Ncols := N`Ncols;
    O`rows := [];
    O`BaseRing := M`BaseRing;

    for i:=1 to O`Nrows do
        ithrow := [];
        for j:=1 to O`Ncols do
            entry := Zero(O`BaseRing);
            for k:=1 to M`Ncols do
                entry +:= M`rows[i][k]*N`rows[k][j];
            end for;
            Append(~ithrow, entry);
        end for;
        Append(~O`rows, ithrow);
    end for;
    
    //print <M`Nrows, M`Ncols>, <N`Nrows, N`Ncols>, <O`Nrows, O`Ncols>;
	//print "OUT";
	
    return O;

end intrinsic;

//==============================================================================
intrinsic '*:='(~M::MtrxExt, N::MtrxExt)
{}

    M := M*N;

end intrinsic;




//==============================================================================
intrinsic '+'(M::ModMatRngElt, x::RngIntElt) -> ModMatRngElt
{}

    for i:=1 to Nrows(M) do
        for j:=1 to Ncols(M) do
            M[i][j] +:= x;
        end for;
    end for;

    return M;

end intrinsic;

//==============================================================================
intrinsic '+'(x::RngIntElt, M::ModMatRngElt) -> ModMatRngElt
{}

    for i:=1 to Nrows(M) do
        for j:=1 to Ncols(M) do
            M[i][j] +:= x;
        end for;
    end for;

    return M;

end intrinsic;

