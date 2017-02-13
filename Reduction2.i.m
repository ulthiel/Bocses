/*
	Bocses - A Magma package for computing with bocses.
	
	By 
	
	Julian Külshammer (julian.kuelshammer@mathematik.uni-stuttgart.de)
	
	and 
	
	Ulrich Thiel (thiel@mathematik.uni-stuttgart.de)
	
	File: Reduction2.i.m

*/
	

//==========================================================================
intrinsic Reduction(B::BocsType, X::SeqEnum, e::.) -> SeqEnum
{Reduction of box B at edge e with respect to dimension vector X.}
	
    esourcenum := Position(B`VertexLabels, B`EdgeSources[e]);
    etailnum := Position(B`VertexLabels, B`EdgeTails[e]);
    x := X[esourcenum];
    y := X[etailnum];
	Bred := Reduction(B, e);
	newboxes := [];
	for i:=0 to Minimum({x,y}) do
		newX := X;
		Append(~newX, i);
		newX[esourcenum] := x-i;
		newX[etailnum] := y-i;
		Append(~newboxes, <Bred, newX>);
	end for;
				
	return newboxes;
	
end intrinsic;


//==========================================================================
intrinsic RemoveZeroEntries(B::BocsType, X::SeqEnum) -> Tup
{}
	
	Bnew := CopyBocs(B);
	removed := [];
	for i:=1 to #X do
		if X[i] eq 0 then
			RemoveVertex(~Bnew, B`VertexLabels[i]);
			Append(~removed, i);
		end if;
	end for;
	X := [ X[i] : i in [1..#X] | i notin removed ]; 

	return <Bnew, X>;
    
end intrinsic;

//==========================================================================
intrinsic FindReducibleEdge(BocsXList::SeqEnum) -> BoolElt, RngIntElt, .
{}

	for i:=1 to #BocsXList do
		B := BocsXList[i][1];
		X := BocsXList[i][2];
		foundreducible, e := FindReducibleEdge(B);
		if foundreducible then
			return true, i, e;
		end if;
	end for;
	
	return false,_,_;

end intrinsic;

//==========================================================================
intrinsic Reduction(BocsXList::SeqEnum : Rounds:=0, Debug:=false) -> SeqEnum
{}
	
	
		
	for i:=1 to #BocsXList do
		B := BocsXList[i][1];
		X := BocsXList[i][2];
		L := RemoveZeroEntries(B,X);
		Bnew := L[1];
		Xnew := L[2];
		Bnew := RemoveSuperfluous(Bnew);
		BocsXList[i][1] := Bnew;
		BocsXList[i][2] := Xnew;
	end for;
	

	foundreducible, i, e := FindReducibleEdge(BocsXList);
	
	count := 0;
	while foundreducible do
		count +:= 1;
		
		B := BocsXList[i][1];
		X := BocsXList[i][2];
		Remove(~BocsXList, i);
		BXnewlist := Reduction(B, X, e);
		
		
		
    	for j:=1 to #BXnewlist do
    		Bcur := BXnewlist[j][1];
			Xcur := BXnewlist[j][2];
    		L := RemoveZeroEntries(Bcur,Xcur);
    		Bnew := L[1];
    		Xnew := L[2];
			Bnew := RemoveSuperfluous(Bnew);
			BXnewlist[j] := <Bnew, Xnew>;
		end for;
		BocsXList cat:= BXnewlist;
		
		
		foundreducible, i, e := FindReducibleEdge(BocsXList);
		
		PrintAndDelete(Sprint(#BocsXList));
		if Rounds ne 0 and count eq Rounds then
			return BocsXList;
		end if;
		
	end while;
    			
	return BocsXList;		

end intrinsic;

//==========================================================================
intrinsic Reduction(B::BocsType, X::SeqEnum[RngIntElt] : Rounds:=0, Debug:=true) -> SeqEnum
{Reduction of box B for dimension vector X.}
	
	
	
	red := Reduction([<B,X>] : Rounds:=Rounds, Debug:=Debug);
	
	
	return red;
	
end intrinsic;