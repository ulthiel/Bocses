/*
    CHAMP (CHerednik Algebra Magma Package)
    Copyright (C) 2013–2015 Ulrich Thiel
    Licensed under GNU GPLv3, see COPYING.
    thiel@mathematik.uni-stuttgart.de
*/

/*
	AlgFPOld.i.m
	
	Intrinsics for the old type of free algebras. These have the advantage of
	supporting arbitrarily many indeterminates.
*/

/*
	Minimal Magma Version: [2,17,0]
*/

//==============================================================================
intrinsic FreeAlgebraOld(R::Rng, n::RngIntElt) -> AlgFPOld
{}

    return FreeAlgebra(R, FreeGroup(n));

end intrinsic;

//==============================================================================
intrinsic Monomials(f::AlgFPEltOld) -> SeqEnum, SeqEnum
{}

    return Support(f);

end intrinsic;

//==============================================================================
intrinsic MonomialsAndCoefficients(f::AlgFPEltOld) -> SeqEnum, SeqEnum
{}

    mons := Support(f);
    coeffs := [ MonomialCoefficient(f, mons[i]) : i in [1..#mons]];
    return mons, coeffs;

end intrinsic;

//==============================================================================
intrinsic OccurringVaribles(f::AlgFPEltOld) -> SetEnum
{Set of all variables occuring in f.}

    vars := {};
    for mon in Monomials(f) do
        vars join:=SequenceToSet(Eltseq(mon));
    end for;

    return vars;

end intrinsic;

//==============================================================================
intrinsic Homomorphism(A::AlgFPOld, B::AlgFPOld, Q::SeqEnum) -> UserProgram
{Constructs the homomorphism defined by Q between free algebras of old type as user program.}

    phi := function(f);
        res := Zero(B);
        mons, coeffs := MonomialsAndCoefficients(f);
        for i:=1 to #mons do
            prod := coeffs[i]*One(B);
            code := Eltseq(mons[i]);
            for j:=1 to #code do
                prod *:= Q[code[j]];
            end for;
            res +:= prod;
        end for;
        return res;
    end function;

    return phi;

end intrinsic;