/*
    CHAMP (CHerednik Algebra Magma Package)
    Copyright (C) 2013–2015 Ulrich Thiel
    Licensed under GNU GPLv3, see COPYING.
    thiel@mathematik.uni-stuttgart.de
*/

/*
	Bocs reduction with respect to dimension vector.
	
	Joint with Julian Külshammer.
*/

/*
	Minimal Magma Version: [2,19,0]
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
	
	if Debug then
		debugfile := CHAMP_GetDir()*"Tmp/Reduction.html";
	end if;
		
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
	
	if Debug then
		Write(debugfile, "<br><br><h3>Cleanup 0: Removing superfluous and zero entries</h3>");
		for j:=1 to #BocsXList do
			Write(debugfile, "<h4>Bocs "*Sprint(j)*"</h4>"); 
			Draw(BocsXList[j][1] : Format:="png", Filename:=CHAMP_GetDir()*"Tmp/0-"*Sprint(j)*"-clean", Quiet:=true);
			Write(debugfile, "<img src=\"0-"*Sprint(j)*"-clean.png\"><br>");
			Write(debugfile, "Dimension vector: "*Sprint(BocsXList[j][2])*"<br><br>");
		end for;
	end if;

	foundreducible, i, e := FindReducibleEdge(BocsXList);
	
	count := 0;
	while foundreducible do
		count +:= 1;
		if Debug then
			Write(debugfile, "<br><br><h3 id=\"round-"*Sprint(count)*"\">Round "*Sprint(count)*" (reduction  with reducible edge "*Sprint(e)*" of Bocs "*Sprint(i)*" in recent box list)</h3>");
		end if;
		B := BocsXList[i][1];
		X := BocsXList[i][2];
		Remove(~BocsXList, i);
		BXnewlist := Reduction(B, X, e);
		
		if Debug then
			Write(debugfile, "Bocs list contains "*Sprint(#BXnewlist)*" boxes after reduction");
			for j:=1 to #BXnewlist do
				Write(debugfile, "<br><br><h4>Bocs "*Sprint(j)*"</h4>"); 
				Draw(BXnewlist[j][1] : Format:="png", Filename:=CHAMP_GetDir()*"Tmp/"*Sprint(count)*"-"*Sprint(j)*"-red", Quiet:=true);
				Write(debugfile, "<img src=\""*Sprint(count)*"-"*Sprint(j)*"-red.png\"><br>");
				Write(debugfile, "Dimension vector: "*Sprint(BXnewlist[j][2]));
			end for;
		end if;
		
		
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
		
		
		if Debug then
			Write(debugfile, "<br><br>Bocs list contains "*Sprint(#BocsXList)*" boxes after cleanup");
			for j:=1 to #BocsXList do
				Write(debugfile, "<br><br><h4>Bocs "*Sprint(j)*"</h4>"); 
				Draw(BocsXList[j][1] : Format:="png", Filename:=CHAMP_GetDir()*"Tmp/"*Sprint(count)*"-"*Sprint(j)*"-clean", Quiet:=true);
				Write(debugfile, "<img src=\""*Sprint(count)*"-"*Sprint(j)*"-clean.png\"><br>");
				Write(debugfile, "Dimension vector: "*Sprint(BocsXList[j][2]));
			end for;
		end if;
		
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
	
	if Debug then
		debugfile := CHAMP_GetDir()*"Tmp/Reduction.html";
		WriteHTMLStart(debugfile);
		
		for i:=1 to Rounds do
			Write(debugfile, "<a href=\"#round-"*Sprint(i)*"\">Round "*Sprint(i)*"</a><br>");
		end for;
		
		Write(debugfile, "<br><br><h3>Initial Bocs</h3>");
		Draw(B : Format:="png", Filename:=CHAMP_GetDir()*"Tmp/0", Quiet:=true);
		Write(debugfile, "<img src=\"0.png\">");
		Write(debugfile, "Vertex enumeration: "*Sprint(B`VertexLabels)*"<br>");
		Write(debugfile, "Initial dimension vector: "*Sprint(X));
	end if;
	
	red := Reduction([<B,X>] : Rounds:=Rounds, Debug:=Debug);
		
	if Debug then
		WriteHTMLEnd(debugfile);
	end if;		
	
	return red;
	
end intrinsic;