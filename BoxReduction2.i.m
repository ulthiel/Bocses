/*
    CHAMP (CHerednik Algebra Magma Package)
    Copyright (C) 2013–2015 Ulrich Thiel
    Licensed under GNU GPLv3, see COPYING.
    thiel@mathematik.uni-stuttgart.de
*/

/*
	Box reduction with respect to dimension vector.
	
	Joint with Julian Külshammer.
*/

/*
	Minimal Magma Version: [2,19,0]
*/
	

//==========================================================================
intrinsic Reduction(B::BoxType, X::SeqEnum, e::.) -> SeqEnum
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
intrinsic RemoveZeroEntries(B::BoxType, X::SeqEnum) -> Tup
{}
	
	Bnew := CopyBox(B);
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
intrinsic FindReducibleEdge(BoxXList::SeqEnum) -> BoolElt, RngIntElt, .
{}

	for i:=1 to #BoxXList do
		B := BoxXList[i][1];
		X := BoxXList[i][2];
		foundreducible, e := FindReducibleEdge(B);
		if foundreducible then
			return true, i, e;
		end if;
	end for;
	
	return false,_,_;

end intrinsic;

//==========================================================================
intrinsic Reduction(BoxXList::SeqEnum : Rounds:=0, Debug:=false) -> SeqEnum
{}
	
	if Debug then
		debugfile := CHAMP_GetDir()*"Tmp/Reduction.html";
	end if;
		
	for i:=1 to #BoxXList do
		B := BoxXList[i][1];
		X := BoxXList[i][2];
		L := RemoveZeroEntries(B,X);
		Bnew := L[1];
		Xnew := L[2];
		Bnew := RemoveSuperfluous(Bnew);
		BoxXList[i][1] := Bnew;
		BoxXList[i][2] := Xnew;
	end for;
	
	if Debug then
		Write(debugfile, "<br><br><h3>Cleanup 0: Removing superfluous and zero entries</h3>");
		for j:=1 to #BoxXList do
			Write(debugfile, "<h4>Box "*Sprint(j)*"</h4>"); 
			Draw(BoxXList[j][1] : Format:="png", Filename:=CHAMP_GetDir()*"Tmp/0-"*Sprint(j)*"-clean", Quiet:=true);
			Write(debugfile, "<img src=\"0-"*Sprint(j)*"-clean.png\"><br>");
			Write(debugfile, "Dimension vector: "*Sprint(BoxXList[j][2])*"<br><br>");
		end for;
	end if;

	foundreducible, i, e := FindReducibleEdge(BoxXList);
	
	count := 0;
	while foundreducible do
		count +:= 1;
		if Debug then
			Write(debugfile, "<br><br><h3 id=\"round-"*Sprint(count)*"\">Round "*Sprint(count)*" (reduction  with reducible edge "*Sprint(e)*" of Box "*Sprint(i)*" in recent box list)</h3>");
		end if;
		B := BoxXList[i][1];
		X := BoxXList[i][2];
		Remove(~BoxXList, i);
		BXnewlist := Reduction(B, X, e);
		
		if Debug then
			Write(debugfile, "Box list contains "*Sprint(#BXnewlist)*" boxes after reduction");
			for j:=1 to #BXnewlist do
				Write(debugfile, "<br><br><h4>Box "*Sprint(j)*"</h4>"); 
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
		BoxXList cat:= BXnewlist;
		
		
		if Debug then
			Write(debugfile, "<br><br>Box list contains "*Sprint(#BoxXList)*" boxes after cleanup");
			for j:=1 to #BoxXList do
				Write(debugfile, "<br><br><h4>Box "*Sprint(j)*"</h4>"); 
				Draw(BoxXList[j][1] : Format:="png", Filename:=CHAMP_GetDir()*"Tmp/"*Sprint(count)*"-"*Sprint(j)*"-clean", Quiet:=true);
				Write(debugfile, "<img src=\""*Sprint(count)*"-"*Sprint(j)*"-clean.png\"><br>");
				Write(debugfile, "Dimension vector: "*Sprint(BoxXList[j][2]));
			end for;
		end if;
		
		foundreducible, i, e := FindReducibleEdge(BoxXList);
		
		PrintAndDelete(Sprint(#BoxXList));
		if Rounds ne 0 and count eq Rounds then
			return BoxXList;
		end if;
		
	end while;
    			
	return BoxXList;		

end intrinsic;

//==========================================================================
intrinsic Reduction(B::BoxType, X::SeqEnum[RngIntElt] : Rounds:=0, Debug:=true) -> SeqEnum
{Reduction of box B for dimension vector X.}
	
	if Debug then
		debugfile := CHAMP_GetDir()*"Tmp/Reduction.html";
		WriteHTMLStart(debugfile);
		
		for i:=1 to Rounds do
			Write(debugfile, "<a href=\"#round-"*Sprint(i)*"\">Round "*Sprint(i)*"</a><br>");
		end for;
		
		Write(debugfile, "<br><br><h3>Initial Box</h3>");
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