/*
    CHAMP (CHerednik Algebra Magma Package)
    Copyright (C) 2013–2015 Ulrich Thiel
    Licensed under GNU GPLv3, see COPYING.
    thiel@mathematik.uni-stuttgart.de
*/

/*
	Box reduction.
	
	Joint with Julian Külshammer.
*/

/*
	Minimal Magma Version: [2,19,0]
*/

//==============================================================================
function EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, d)
// d element of path algebra, return F(d)

    termevals := [];
    mons,coeffs := MonomialsAndCoefficients(d);
    
    for j:=1 to #mons do
        code := Eltseq(mons[j]);
        code1label := G`EdgeLabels[code[1]];
        prod := Fedges[code1label];
        for k:=2 to #code do
        	codeklabel := G`EdgeLabels[code[k]];
            prod := prod * Fedges[codeklabel]; //careful *:= overwrites Fedges!
        end for;
        prod *:= tmpEdgeAlgebra!coeffs[j];
        //convert scalars
        if Type(prod) eq AlgFPEltOld then
            prod := MatrixExtended(1,1,[prod]);
        end if;
        Append(~termevals, prod);
    end for;

    if IsEmpty(termevals) then
        return Zero(tmpEdgeAlgebra);
    else
        return &+termevals;
    end if;

end function;

//==============================================================================
intrinsic Reduction(G::BoxType, e::.) -> BoxType
/*
	Reduction of G with edge labelled by Label
*/
{}

    edgenum := Position(G`EdgeLabels, e);
    
    esource := G`EdgeSources[e];
    etail := G`EdgeTails[e];

    if not G`EdgeDifferentials[e] eq 0 then
        error "Edge for reduction has to have zero differential.";
    end if;

    //copy G
    Gred := CopyBox(G);

	//label for new vertex
	if Universe(G`VertexLabels) eq Universe({1}) then
		newvertex := Maximum(G`VertexLabels)+1;
	else
		newvertex := Tempname("");
	end if;
	
	AddVertex(~Gred, newvertex);
	Gred`VertexDimensionVectors[newvertex] := G`VertexDimensionVectors[esource] + G`VertexDimensionVectors[etail];
	Gred`VertexHistories[newvertex] := <e, G`VertexHistories[esource], G`VertexHistories[etail]>;
	
    //Julians komische Idee
    for f in Gred`EdgeLabels do
        Gred`EdgeLevels[f] *:= 3;
    end for;

    //first step: vertices of Gred; two new
    AddEdge(~Gred, <etail,newvertex,Sprint(e)*"_t"> : Degree:=1, Level:=1);
    AddEdge(~Gred, <newvertex,esource,Sprint(e)*"_s"> : Degree:=1, Level:=1);    
    
    //second step: edges of Gred
    for i in SequenceToSet(G`EdgeLabels) diff {e} do
    
    	isource := G`EdgeSources[i];
    	itail := G`EdgeTails[i];
    	idegree := G`EdgeDegrees[i];
    	ilevel := Gred`EdgeLevels[i];
    
        if isource eq esource and itail notin {esource,etail} then
            AddEdge(~Gred, <newvertex, itail, Sprint(i)*"_"*Sprint(itail)*","*Sprint(newvertex)> : Degree := idegree, Level:=ilevel);
            Gred`EdgeLevels[i] -:= 1;

        elif isource eq etail and itail notin {esource,etail} then
            AddEdge(~Gred, <newvertex, itail, Sprint(i)*"_"*Sprint(itail)*","*Sprint(newvertex)> : Degree := idegree,  Level:=ilevel-1);

        elif isource notin {esource,etail} and itail eq esource then
            AddEdge(~Gred, <isource, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(isource)> : Degree := idegree, Level:=ilevel-1);

        elif isource notin {esource,etail} and itail eq etail then
            AddEdge(~Gred, <isource, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(isource)> : Degree:=idegree, Level:=ilevel);
            Gred`EdgeLevels[i] -:= 1;

        elif isource eq esource and itail eq esource then
            AddEdge(~Gred, <newvertex, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel-1);
            AddEdge(~Gred, <newvertex, esource, Sprint(i)*"_"*Sprint(esource)*","*Sprint(newvertex)> : Degree := idegree, Level:=ilevel);
            AddEdge(~Gred, <esource, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(esource)> : Degree:=idegree, Level:=ilevel-2);
            Gred`EdgeLevels[i] -:= 1;

        elif isource eq etail and itail eq etail then
            AddEdge(~Gred, <newvertex, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel-1);
            AddEdge(~Gred, <newvertex, etail, Sprint(i)*"_"*Sprint(etail)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel-2);
            AddEdge(~Gred, <etail, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(etail)> : Degree:=idegree, Level:=ilevel);
            Gred`EdgeLevels[i] -:= 1;

        elif isource eq etail and itail eq esource then
            AddEdge(~Gred, <etail, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(etail)> : Degree:=idegree, Level:=ilevel-1);
            AddEdge(~Gred, <newvertex, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel-2);
            AddEdge(~Gred, <newvertex, esource, Sprint(i)*"_"*Sprint(esource)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel-1);

        elif isource eq esource and itail eq etail then
            AddEdge(~Gred, <newvertex, etail, Sprint(i)*"_"*Sprint(etail)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel-1);
            AddEdge(~Gred, <newvertex, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex)> : Degree:=idegree, Level:=ilevel);
            AddEdge(~Gred, <esource, newvertex, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(esource)> : Degree:=idegree, Level:=ilevel-1);
            Gred`EdgeLevels[i] -:= 2;
        end if;
    end for;

    //print Gred`Edges;


    //third step: differential of Gred

    //F operator
    tmpEdgeAlgebra := FreeAlgebraOld(Rationals(), #Gred`EdgeLabels + #Gred`VertexLabels);
    AssignNames(~tmpEdgeAlgebra, Gred`EdgeLabels cat ["omega_"*Sprint(i) : i in Gred`VertexLabels]);
    embedding := Homomorphism(Gred`EdgeAlgebra, tmpEdgeAlgebra, [tmpEdgeAlgebra.i : i in [1..#Gred`EdgeLabels]]);
    projection := Homomorphism(tmpEdgeAlgebra, Gred`EdgeAlgebra, [Gred`EdgeAlgebra.i : i in [1..#Gred`EdgeLabels]] cat [Zero(Gred`EdgeAlgebra) : i in [1..#Gred`VertexLabels]]);

    //F for vertices
    Fvertices := AssociativeArray(G`VertexLabels);
    for i:=1 to #G`VertexLabels do
        Fvertices[G`VertexLabels[i]] := tmpEdgeAlgebra.(#Gred`EdgeLabels+i);
    end for;

    //e_s
    pos := Position(Gred`EdgeLabels, Sprint(e)*"_s");
    Fvertices[esource] := MatrixExtended(2, 2, [tmpEdgeAlgebra.Ngens(tmpEdgeAlgebra), Zero(tmpEdgeAlgebra), tmpEdgeAlgebra.pos, tmpEdgeAlgebra.(#Gred`EdgeLabels+Position(G`VertexLabels,G`EdgeSources[e]))]);

    //e_t
    pos := Position(Gred`EdgeLabels, Sprint(e)*"_t");
    Fvertices[etail] := MatrixExtended(2, 2, [tmpEdgeAlgebra.(#Gred`EdgeLabels+Position(G`VertexLabels,G`EdgeTails[e])), Zero(tmpEdgeAlgebra), tmpEdgeAlgebra.pos, tmpEdgeAlgebra.Ngens(tmpEdgeAlgebra)]);

    //F for edges
    Fedges := AssociativeArray(G`EdgeLabels);
    for i:=1 to #G`EdgeLabels do
        Fedges[G`EdgeLabels[i]] := tmpEdgeAlgebra.i;
    end for;

    for i in G`EdgeLabels do
    
    	isource := G`EdgeSources[i];
    	itail := G`EdgeTails[i];
    	idegree := G`EdgeDegrees[i];
    	ilevel := Gred`EdgeLevels[i];
    	ipos := Position(G`EdgeLabels, i);

        if itail eq esource and not (isource eq esource or isource eq etail) then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(isource));
            
            Fedges[i] := MatrixExtended(2, 1, [ tmpEdgeAlgebra.pos1, tmpEdgeAlgebra.ipos  ]);

        elif itail eq etail and not (isource eq esource or isource eq etail) then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(isource));
            Fedges[i] := MatrixExtended(2, 1, [ tmpEdgeAlgebra.ipos, tmpEdgeAlgebra.pos1  ]);

        elif isource eq esource and not (itail eq esource or itail eq etail) then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(itail)*","*Sprint(newvertex));
            Fedges[i] := MatrixExtended(1, 2, [ tmpEdgeAlgebra.pos1, tmpEdgeAlgebra.ipos ]);

        elif isource eq etail and not (itail eq esource or itail eq etail) then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(itail)*","*Sprint(newvertex));
            Fedges[i] := MatrixExtended(1, 2, [ tmpEdgeAlgebra.ipos, tmpEdgeAlgebra.pos1 ]);

        elif isource eq esource and itail eq esource then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(esource));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(esource)*","*Sprint(newvertex));
            Fedges[i] := MatrixExtended(2, 2, [ tmpEdgeAlgebra.pos1, tmpEdgeAlgebra.pos2, tmpEdgeAlgebra.pos3, tmpEdgeAlgebra.ipos]);

        elif isource eq etail and itail eq etail then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(etail));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(etail)*","*Sprint(newvertex));
            Fedges[i] := MatrixExtended(2, 2, [ tmpEdgeAlgebra.ipos, tmpEdgeAlgebra.pos3, tmpEdgeAlgebra.pos2, tmpEdgeAlgebra.pos1]);

        elif (isource eq esource and itail eq etail) and i ne e then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(etail)*","*Sprint(newvertex));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(esource));
            Fedges[i] := MatrixExtended(2, 2, [ tmpEdgeAlgebra.pos1, tmpEdgeAlgebra.ipos, tmpEdgeAlgebra.pos2, tmpEdgeAlgebra.pos3]);

        elif isource eq etail and itail eq esource then
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(etail));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(esource)*","*Sprint(newvertex));
            Fedges[i] := MatrixExtended(2, 2, [ tmpEdgeAlgebra.pos1, tmpEdgeAlgebra.pos2, tmpEdgeAlgebra.ipos, tmpEdgeAlgebra.pos3]);

        elif i eq e then
            Fedges[i] := MatrixExtended(2, 2, [ Zero(tmpEdgeAlgebra), Zero(tmpEdgeAlgebra), One(tmpEdgeAlgebra), Zero(tmpEdgeAlgebra)]);

        end if;

    end for;

    for i in G`EdgeLabels do
    
    	isource := G`EdgeSources[i];
    	itail := G`EdgeTails[i];
    	idegree := G`EdgeDegrees[i];
    	ilevel := Gred`EdgeLevels[i];
    	ipos := Position(G`EdgeLabels, i);
    	idiff := Gred`EdgeDifferentials[i];
        
        if IsEmpty( {isource, itail} meet {esource, etail} ) then

            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 1)";

            d := EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);
    
            if Type(d) ne MtrxExt then
                Gred`EdgeDifferentials[i] := projection(d); //Zero(Gred`EdgeAlgebra);
            else
                Gred`EdgeDifferentials[i] := projection(Entry(d,1,1));
            end if;



        elif isource notin {esource, etail} and itail eq esource then


            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(isource));
            
            pos1label := Gred`EdgeLabels[pos1];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 2)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 2)";

            //not nec as projected to zero
            //v := MatrixExtended(2, 1, [ tmpEdgeAlgebra.Ngens(tmpEdgeAlgebra)*tmpEdgeAlgebra.pos1 - tmpEdgeAlgebra.pos1*tmpEdgeAlgebra.(#Gred`Edges + isource), tmpEdgeAlgebra.(#Gred`Edges + esource)*tmpEdgeAlgebra.i - tmpEdgeAlgebra.i*tmpEdgeAlgebra.(#Gred`Edges + isource)]);

			newdiff := Fvertices[esource]*Fedges[i] - Fedges[i]*Fvertices[isource] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);
			
            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,2,1));



        elif itail eq etail and isource notin {esource, etail} then
        
            newdiff := Fvertices[etail]*Fedges[i] - Fedges[i]*Fvertices[isource] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);

            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(isource));
            
            pos1label := Gred`EdgeLabels[pos1];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 3)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 3)";

            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,2,1));

        elif isource eq esource and itail notin {esource, etail} then

            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(itail)*","*Sprint(newvertex));
            
            pos1label := Gred`EdgeLabels[pos1];

            //not nec as projected to zero
            //v := MatrixExtended(1, 2, [ tmpEdgeAlgebra.(#Gred`Edges + itail)*tmpEdgeAlgebra.pos1 - tmpEdgeAlgebra.pos1*tmpEdgeAlgebra.Ngens(tmpEdgeAlgebra), tmpEdgeAlgebra.(#Gred`Edges + itail)*tmpEdgeAlgebra.i - tmpEdgeAlgebra.i*tmpEdgeAlgebra.(#Gred`Edges + esource)]);

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 4)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 4)";
            
            newdiff := Fvertices[itail]*Fedges[i] - Fedges[i]*Fvertices[esource] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);

            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,1,2));



        elif isource eq etail and itail notin {esource, etail} then

            newdiff := Fvertices[itail]*Fedges[i] - Fedges[i]*Fvertices[etail] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);

            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(itail)*","*Sprint(newvertex));
            
            pos1label := Gred`EdgeLabels[pos1];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 5)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 5)";

            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,2));

        elif isource eq esource and itail eq esource then

            newdiff := Fvertices[esource]*Fedges[i] - Fedges[i]*Fvertices[esource] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);
		
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(esource));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(esource)*","*Sprint(newvertex));
            
            pos1label := Gred`EdgeLabels[pos1];
            pos2label := Gred`EdgeLabels[pos2];
            pos3label := Gred`EdgeLabels[pos3];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 6)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos2])*" changed (case 6)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos3])*" changed (case 6)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 6)";

            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[pos2label] := projection(Entry(newdiff,1,2));
            Gred`EdgeDifferentials[pos3label] := projection(Entry(newdiff,2,1));
            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,2,2));

        elif isource eq etail and itail eq etail then
			
            newdiff := Fvertices[etail]*Fedges[i] - Fedges[i]*Fvertices[etail] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);
			
            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(etail)*","*Sprint(newvertex));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(etail));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            
            pos1label := Gred`EdgeLabels[pos1];
            pos2label := Gred`EdgeLabels[pos2];
            pos3label := Gred`EdgeLabels[pos3];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 7)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos2])*" changed (case 7)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos3])*" changed (case 7)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 7)";

            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,2));
            Gred`EdgeDifferentials[pos2label] := projection(Entry(newdiff,2,1));
            Gred`EdgeDifferentials[pos3label] := projection(Entry(newdiff,2,2));

        elif isource eq esource and itail eq etail and i ne e then

            newdiff := Fvertices[etail]*Fedges[i] - Fedges[i]*Fvertices[esource] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);

            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(etail)*","*Sprint(newvertex));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(esource));
            
            pos1label := Gred`EdgeLabels[pos1];
            pos2label := Gred`EdgeLabels[pos2];
            pos3label := Gred`EdgeLabels[pos3];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 8)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos2])*" changed (case 8)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos3])*" changed (case 8)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 8)";

            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,1,2));
            Gred`EdgeDifferentials[pos2label] := projection(Entry(newdiff,2,1));
            Gred`EdgeDifferentials[pos3label] := projection(Entry(newdiff,2,2));



        elif isource eq etail and itail eq esource then

            newdiff := Fvertices[esource]*Fedges[i] - Fedges[i]*Fvertices[etail] + EvaluateFOperatorForEdges(G, Fedges, tmpEdgeAlgebra, idiff);

            pos1 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(etail));
            pos2 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(newvertex)*","*Sprint(newvertex));
            pos3 := Position(Gred`EdgeLabels, Sprint(i)*"_"*Sprint(esource)*","*Sprint(newvertex));
            
            pos1label := Gred`EdgeLabels[pos1];
            pos2label := Gred`EdgeLabels[pos2];
            pos3label := Gred`EdgeLabels[pos3];

            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos1])*" changed (case 9)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos2])*" changed (case 9)";
            vprint BoxType, 5: "Differential of "*Sprint(Gred`EdgeLabels[pos3])*" changed (case 9)";
            vprint BoxType, 5: "Differential of "*Sprint(Sprint(i))*" changed (case 9)";

            Gred`EdgeDifferentials[pos1label] := projection(Entry(newdiff,1,1));
            Gred`EdgeDifferentials[pos2label] := projection(Entry(newdiff,1,2));
            Gred`EdgeDifferentials[i] := projection(Entry(newdiff,2,1));
            Gred`EdgeDifferentials[pos3label] := projection(Entry(newdiff,2,2));
        end if;
    end for;

    RemoveEdge(~Gred, e);
    
    CheckForRepresentativeInfinite(Gred);

    return Gred;

end intrinsic;

//==============================================================================
intrinsic CheckForRepresentativeInfinite(B::BoxType)
{}

	for i in B`EdgeLabels do
        if B`EdgeSources[i] eq B`EdgeTails[i] and B`EdgeDifferentials[i] eq 0 and B`EdgeDegrees[i] eq 0 then
        	error "Representation-infinite (CheckForRepresentativeInfinite)!\nBox:\n "*Sprint(B);
        end if;
    end for;

end intrinsic;

//==============================================================================
intrinsic RemoveSuperfluous(G::BoxType, e::.) -> BoxType
{}

    edgenum := Position(G`EdgeLabels, e);
    
    if G`EdgeDifferentials[e] eq 0 then
        error "Edge has to have non-zero differential";
    end if;
    if G`EdgeDegrees[e] ne 0 then
        error "Edge has to have zero weight";
    end if;

    //copy G
    Grem := CopyBox(G);
    
    mons, coeffs := MonomialsAndCoefficients(G`EdgeDifferentials[e]);
    monsandcoeffsoflength1 := [ <coeffs[i],Eltseq(mons[i])[1]> : i in [1..#mons] | #mons[i] eq 1 and G`EdgeDegrees[G`EdgeLabels[Eltseq(mons[i])[1]]] eq 1];

    c := monsandcoeffsoflength1[1][1];
    x := monsandcoeffsoflength1[1][2];
    xlabel := G`EdgeLabels[x];

    for j:=1 to #monsandcoeffsoflength1 do
        k := monsandcoeffsoflength1[j][2];
        klabel := G`EdgeLabels[k];
        if G`EdgeLevels[klabel] gt G`EdgeLevels[xlabel] then
            x := k;
            xlabel := klabel;
            c := monsandcoeffsoflength1[j][1];
        end if;
    end for;

    killer := Homomorphism(Grem`EdgeAlgebra, Grem`EdgeAlgebra, [Grem`EdgeAlgebra.i : i in [1..edgenum-1]] cat [Zero(Grem`EdgeAlgebra)] cat [Grem`EdgeAlgebra.i : i in [edgenum+1..#G`EdgeLabels]]);

    for f in SequenceToSet(G`EdgeLabels) diff {e} do
        Grem`EdgeDifferentials[f] := killer(Grem`EdgeDifferentials[f]);
    end for;

    replace := Homomorphism(Grem`EdgeAlgebra, Grem`EdgeAlgebra, [Grem`EdgeAlgebra.i : i in [1..x-1]] cat [-1/c*(Grem`EdgeDifferentials[e]-c*Grem`EdgeAlgebra.x)] cat [Grem`EdgeAlgebra.i : i in [x+1..#G`EdgeLabels]]);

    for f in G`EdgeLabels do
        Grem`EdgeDifferentials[f] := replace(Grem`EdgeDifferentials[f]);
    end for;

    RemoveEdge(~Grem, e);
    RemoveEdge(~Grem, xlabel);
    
    return Grem;

end intrinsic;

//==============================================================================
intrinsic FindSuperfluousEdge(G::BoxType : Method:="New") -> BoolElt, .
{}

    for e in G`EdgeLabels do
        if G`EdgeDegrees[e] eq 0 and G`EdgeDifferentials[e] ne 0 then
            mons := Monomials(G`EdgeDifferentials[e]);
            
            if Method eq "Old" then
            	for j:=1 to #mons do
                	if #mons[j] eq 1 and G`EdgeDegrees[G`EdgeLabels[Eltseq(mons[j])[1]]] eq 1 then
                    	return true, e;
                	end if;
           		end for;
            end if;
             
            if Method eq "New" then
            	superfluous := true; 
            	for j:=1 to #mons do
                	if not (#mons[j] eq 1 and G`EdgeDegrees[G`EdgeLabels[Eltseq(mons[j])[1]]] eq 1) then
                    	superfluous := false;
                    	break;
                	end if;
           	 end for;
            	if superfluous then
            		return true, e;
            	end if;
            end if;
        end if;
    end for;

    return false, _;

end intrinsic;

//==============================================================================
intrinsic RemoveSuperfluous(G::BoxType) -> BoxType, RngIntElt, SeqEnum
{}

    count := 0;
    removed := [];
    foundsuperfluous, a := FindSuperfluousEdge(G);
    while foundsuperfluous do
        vprint BoxType, 5: "Removing "*a;
        Append(~removed, a);
        G := RemoveSuperfluous(G, a);
        count +:= 1;
        foundsuperfluous, a := FindSuperfluousEdge(G);
    end while;
    
    CheckForRepresentativeInfinite(G);

    return G, count, removed;

end intrinsic;

//==============================================================================
intrinsic FindReducibleEdge(G::BoxType) -> BoolElt, RngIntElt
{}

    candidates := [ <G`EdgeLevels[G`EdgeLabels[i]], i> : i in [1..#G`EdgeLabels] | G`EdgeDegrees[G`EdgeLabels[i]] eq 0 and G`EdgeDifferentials[G`EdgeLabels[i]] eq 0 ];
    
    for X in candidates do
        e := G`EdgeLabels[X[2]];
        if G`EdgeSources[e] eq G`EdgeTails[e] then
            error "Not of finite representation type (FindReducibleEdge).";
        end if;
    end for;
    if IsEmpty(candidates) then
        return false, _;
    else
        return true, G`EdgeLabels[Minimum(candidates)[2]];
    end if;

    return false, _;

end intrinsic;

//==============================================================================
intrinsic Reduction(G::BoxType : BoxTitle:="", DrawAll:=false, Limit:=0) -> BoxType, SeqEnum
{}

    count := 0;

    if BoxTitle eq "" then
        BoxTitle := Tempname("");
    end if;
    dir := "Tmp/"*BoxTitle;
    System("mkdir -p "*dir);
    //Draw(G:Filename:=dir*"/"*Sprint(count),Quiet:=true, PrintEdgeLabels:=true, xsize:=1200, ysize:=800);
    //Draw(G:Filename:=dir*"/"*Sprint(count),Quiet:=true, Method:="Gephi");

    //htmlfile := dir*"/reduction.html";
    //Write(htmlfile, "<html>\n<style>body{font-family: verdana, serif;font-size:10pt;}</style >\n<body>" : Overwrite:=true);
    // Write(htmlfile, "<a href=\"mailto:kuelshammer@mathematik.uni-stuttgart.de\">Julian K&uuml;lshammer</a><br><a href=\"mailto:thiel@mathematik.uni-stuttgart.de\">Ulrich Thiel</a>");
    //Write(htmlfile, "<h1>Reduction of box \""*BoxTitle*"\"</h1>");
    //Write(htmlfile, Date());

    //Write(htmlfile, "<h2>Initial box</h2>");

    //Write(htmlfile, "<a href=\""*Sprint(count)*".png\"><img src=\"0.png\" style=\"max-height:400px;max-width:400px;\"; ></a>");

	steps := [G];
	
    G, removedcount, removed := RemoveSuperfluous(G);
    
    //Sprint(removed)*" removed";
    
    foundreducible, b := FindReducibleEdge(G);
    while foundreducible do
    	if Limit ne 0 and count gt Limit then
    		break;
    	end if;
        count +:= 1;
        print "";
        print "Reduction (#"*Sprint(count)*") with "*b;
        //Write(htmlfile, "<h2>Reduction "*Sprint(count)*"</h2>");
        //Write(htmlfile, "(Reduction at edge "*Sprint(G`Edges[b]`Label)*")<br>");
        G := Reduction(G, b);
        //print G;
        Append(~steps, G);
        
        	
        if DrawAll then
            Draw(G:Filename:=dir*"/"*Sprint(count)*"-full",Quiet:=true, xsize:=1200, ysize:=800);
            Draw(SimplifiedBox(G):Filename:=dir*"/"*Sprint(count)*"-simp",Quiet:=true, PrintEdgeLabels:=true, xsize:=1200, ysize:=800);
            Draw(G:Filename:=dir*"/"*Sprint(count)*"-full",Quiet:=true);
            Draw(SimplifiedBox(G):Filename:=dir*"/"*Sprint(count)*"-simp",Quiet:=true);
        end if;
        /*
        Write(htmlfile, "(Removed edges: "*Sprint(removed)*")<br>");
        Write(htmlfile, "Full box has "*Sprint(#G`Vertices)*" vertices and "*Sprint(#G`Edges)*" edges.<br>");
        Write(htmlfile, "<p style=\"float: left; font-size: 9pt; text-align: center; width: 30%; margin-right: 1%; margin-bottom: 0.5em;\">");
        Write(htmlfile, "<a href=\""*Sprint(count)*"-simp.png\"><img src=\""*Sprint(count)*"-simp.png\" style=\"max-height:400px;max-width:400px;\"; ></a>Simplified box</p>");
        Write(htmlfile, "<p style=\"float: left; font-size: 9pt; text-align: center; width: 30%; margin-right: 1%; margin-bottom: 0.5em;\">");
        Write(htmlfile, "<a href=\""*Sprint(count)*"-full.png\"><img src=\""*Sprint(count)*"-full.png\" style=\"max-height:400px;max-width:400px;\"; ></a>Full box</p>");
        Write(htmlfile, "<p style=\"clear: both;\">");
        */
        edgedegrees := {G`EdgeDegrees[e] : e in G`EdgeLabels};
        edgenums := Sort([<d,#[e : e in G`EdgeLabels | G`EdgeDegrees[e] eq d]> : d in edgedegrees]);
        print "Reduced graph has "*Sprint(#G`VertexLabels)*" vertices and "*Sprint(#G`EdgeLabels)*" edges ("*Sprint(edgenums)*")";
        //Write(htmlfile, "<br>Nonzero differentials of simplified box:<br>");
        //H := SimplifiedGraph(G);
        /*for i:=1 to #H`Edges do
            if H`Edges[i]`Differential ne 0 then
                Write(htmlfile, "&#8706;("*Sprint(H`Edges[i]`Label)*") \t = \t"*Sprint(H`Edges[i]`Differential)*"<br>");
            end if;
        end for;
        */
        
        print "";
        G, removedcount, removed := RemoveSuperfluous(G);
        //Sprint(removed)*" removed";
        foundreducible, b := FindReducibleEdge(G);
    end while;

    print "";
    print "Finished";
    print "Reductions: "*Sprint(count);
    print "Final graph has "*Sprint(#G`VertexLabels)*" vertices and "*Sprint(#G`EdgeLabels)*" edges";

   // Write(htmlfile, "</html></body>");

    return G, steps;

end intrinsic;

//==================================================================================
intrinsic SimplifiedBox(G::BoxType) -> BoxType
{}

    H := New(BoxType);
    H`VertexLabels := G`VertexLabels;
    H`VertexDimensionVectors := G`VertexDimensionVectors;
    H`VertexHistories := G`VertexHistories;
    H`EdgeLabels := [];
    H`EdgeDifferentials := AssociativeArray(Universe(Keys(G`EdgeDifferentials)));
    H`EdgeDegrees := AssociativeArray(Universe(Keys(G`EdgeDegrees)));
    H`EdgeLevels := AssociativeArray(Universe(Keys(G`EdgeLevels)));
    H`EdgeSources := AssociativeArray(Universe(Keys(G`EdgeSources)));
    H`EdgeTails := AssociativeArray(Universe(Keys(G`EdgeTails)));
    for i:=1 to #G`EdgeLabels do
    	e := G`EdgeLabels[i];
        if G`EdgeDifferentials[e] eq 0 or G`EdgeDegrees[e] eq 0 then
            Append(~H`EdgeLabels,e);
            H`EdgeDifferentials[e] := G`EdgeDifferentials[e];
            H`EdgeDegrees[e] := G`EdgeDegrees[e];
            H`EdgeSources[e] := G`EdgeSources[e];
            H`EdgeTails[e] := G`EdgeTails[e];
            H`EdgeLevels[e] := G`EdgeLevels[e];
            continue;
        end if;
        for j in {1..#G`EdgeLabels} diff {i} do
        	f := G`EdgeLabels[j];
            if G`EdgeDegrees[f] lt G`EdgeDegrees[e] and i in OccurringVaribles(G`EdgeDifferentials[f]) then
                Append(~H`EdgeLabels,e);
                H`EdgeDifferentials[e] := G`EdgeDifferentials[e];
            	H`EdgeDegrees[e] := G`EdgeDegrees[e];
            	H`EdgeSources[e] := G`EdgeSources[e];
            	H`EdgeTails[e] := G`EdgeTails[e];
            	H`EdgeLevels[e] := G`EdgeLevels[e];
                break;
            end if;
        end for;
    end for;

    return H;

end intrinsic;

