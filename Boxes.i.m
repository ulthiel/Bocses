/*
    CHAMP (CHerednik Algebra Magma Package)
    Copyright (C) 2013–2015 Ulrich Thiel
    Licensed under GNU GPLv3, see COPYING.
    thiel@mathematik.uni-stuttgart.de
*/

/*
	Boxes.
	
	Joint with Julian Külshammer.
*/

/*
	Minimal Magma Version: [2,19,0]
*/

//=============================================================================
//Declarations
declare type BoxType;

declare attributes BoxType:
    VertexLabels,
    VertexDimensionVectors,
    VertexHistories,
    EdgeLabels,
    EdgeSources,
    EdgeTails,
    EdgeDifferentials,
    EdgeDegrees,
    EdgeLevels,
    EdgeAlgebra;
    
declare verbose BoxType, 5;

//==============================================================================
intrinsic Box(V::SeqEnum, E::SeqEnum) -> BoxType
{}

    G := New(BoxType);
    
    //vertices
    G`VertexLabels := V;
    if #SequenceToSet(G`VertexLabels) lt #G`VertexLabels then
    	error "Vertex labels must be unique!";
    end if;
    
    if not ({e[1] : e in E} join {e[2] : e in E}) subset SequenceToSet(G`VertexLabels) then
    	error "There is an edge starting or ending in an non-defined vertex";
    end if;
       
    W := RSpace(Integers(),#G`VertexLabels);
    G`VertexDimensionVectors := AssociativeArray(Universe(G`VertexLabels));
    for i:=1 to #G`VertexLabels do
    	G`VertexDimensionVectors[G`VertexLabels[i]] := W.i;
    end for;
    
    G`VertexHistories := AssociativeArray(Universe(G`VertexLabels));
    for i:=1 to #V do
    	G`VertexHistories[G`VertexLabels[i]] := i;
    end for;
    
    //edges
    G`EdgeLabels := [ e[3] : e in E ];
    if #SequenceToSet(G`EdgeLabels) lt #G`EdgeLabels then
    	error "Edge labels must be unique!";
    end if;
    
    //edges
    G`EdgeSources := AssociativeArray(Universe(G`EdgeLabels));
    G`EdgeTails := AssociativeArray(Universe(G`EdgeLabels));
    G`EdgeDegrees := AssociativeArray(Universe(G`EdgeLabels));
    G`EdgeLevels := AssociativeArray(Universe(G`EdgeLabels));
    G`EdgeDifferentials := AssociativeArray(Universe(G`EdgeLabels));
    
    for e in E do
    	G`EdgeSources[e[3]] := e[1];
    	G`EdgeTails[e[3]] := e[2];
    	G`EdgeDegrees[e[3]] := 0;
    	G`EdgeLevels[e[3]] := 1;
    end for;
    
    //edge algebra (free algebra on edges)
    G`EdgeAlgebra := FreeAlgebraOld(Rationals(), #E);
    AssignNames(~G`EdgeAlgebra, G`EdgeLabels);
    
    //differentials
    for e in G`EdgeLabels do
        G`EdgeDifferentials[e] := Zero(G`EdgeAlgebra);
    end for;
    
    return G;

end intrinsic;


//==============================================================================
intrinsic Print(G::BoxType)
{}
	print "Box with "*Sprint(#G`VertexLabels)*" vertices and "*Sprint(#G`EdgeLabels)*" edges.";
	print "";
	for v in G`VertexLabels do
        print "Vertex "*Sprint(v);
        IndentPush();
        if IsDefined(G`VertexDimensionVectors, v) then
        	print "DimensionVector := "*Sprint(G`VertexDimensionVectors[v]);
        end if;
        if IsDefined(G`VertexHistories, v) then
        	print "History := "*Sprint(G`VertexHistories[v]);
        end if;
        IndentPop();
    end for;
    print "";
    for e in G`EdgeLabels do
        print "Edge "*Sprint(e);
        IndentPush();
        print "Source := "*Sprint(G`EdgeSources[e]);
        print "Tail := "*Sprint(G`EdgeTails[e]);
        print "Differential := "*Sprint(G`EdgeDifferentials[e]);
        print "Degree := "*Sprint(G`EdgeDegrees[e]);
        print "Level := "*Sprint(G`EdgeLevels[e]);
        IndentPop();
        print "";
    end for;

end intrinsic;

//=============================================================================
intrinsic Draw(G::BoxType : Filename:="", xsize:=0, ysize:=0, Quiet:=false, PrintEdgeLabels:=true, Title:="", Format:="svg")
{}

    if Filename eq "" then
        file := Tempname(CHAMP_GetDir()*"Tmp/graph_");
    else
        file := Filename;
    end if;
    	
    	str := "digraph G {\n";
    	str *:= "graph [fontname=Verdana];\n";
    	str *:= "edge [fontname=Verdana, fontsize=8];\n";
    	str *:= "node [fontsize=8, fontname=Verdana, shape=circle, style=filled, fillcolor=\"#00FF70\"];\n";
    	//str *:= "ratio = \"fill\";\n";
    	//str *:= "splines=true;\n";
    	str *:= "nodesep=0.6;\n";
    	str *:= "overlap=scalexy;\n";
    	if not Title eq "" then
    		str *:= "label=\""*Title*"\";\n";
    		str *:= "labelloc=\"t\";\n";
    		str *:= "graph [tooltip=\""*Title*"\"];\n";
    	end if;
    	if xsize ne 0 and ysize ne 0 then
    		str *:= "size = \""*Sprint(xsize)*","*Sprint(ysize)*"\";\n";
    	end if;
    	
    	for v in G`VertexLabels do
    		str *:= Sprint(v)*" [ tooltip=\" "*Replace(Sprint(G`VertexHistories[v]), "\"", "")*"\"];\n";
    	end for;
    	
    	for e in G`EdgeLabels do
    		str *:= Sprint(G`EdgeSources[e])*" -> "*Sprint(G`EdgeTails[e]);
    		str *:= " [ ";
    		comma := false;
    		if PrintEdgeLabels then
    			str *:= " label=\""*Sprint(e)*"\" ";
    			comma := true;
    		end if;
    		if G`EdgeDegrees[e] eq 1 then
    			if comma then
    				str *:= ", ";
    			end if;
    			str *:= " style=dashed ";
    			comma := true;
    		end if;
    		if comma then
    			str *:= ", ";
    		end if;
    		str *:= " tooltip=\"Hallo\" ";
    		if comma then
    			str *:= ", ";
    		end if;
    		str *:= " labeldistance=2.5 ";
    		str *:= " ];\n";
    		    		    		
    	end for;
    	
    	str *:= "}";
    	
    	Write(file*".dot", str);

		System("dot "*file*".dot -T"*Format*" > "*file*"."*Format);
    	if not Quiet then
    		System("open "*file*"."*Format);
    	end if;
    	
end intrinsic;

//==============================================================================
intrinsic GetEdgeAlgebraVariablesDefinition(G::BoxType, GraphVar::MonStgElt) -> MonStgElt
{}

    str := "";
    for i:=1 to #G`EdgeLabels do
        str *:= G`EdgeLabels[i]*" := "*GraphVar*"`EdgeAlgebra."*Sprint(i)*";";
    end for;

    return str;

end intrinsic;

//==============================================================================
intrinsic AddEdge(~G::BoxType, e::Tup : Level:=1, Degree:=0)
{}

	if e[3] in G`EdgeLabels then
		error "Edge with this label already exists.";
	end if;
	if not (e[1] in G`VertexLabels and e[2] in G`VertexLabels) then
		error "Edge starts or ends in an undefined vertex.";
	end if;
	
	Append(~G`EdgeLabels, e[3]);
	G`EdgeSources[e[3]] := e[1];
	G`EdgeTails[e[3]] := e[2];
	G`EdgeLevels[e[3]] := Level;
	G`EdgeDegrees[e[3]] := Degree;
	
    oldEdgeAlgebra := G`EdgeAlgebra;
    G`EdgeAlgebra := FreeAlgebraOld(Rationals(), #G`EdgeLabels);
    AssignNames(~G`EdgeAlgebra, G`EdgeLabels);

    embed := Homomorphism(oldEdgeAlgebra, G`EdgeAlgebra, [G`EdgeAlgebra.i : i in [1..#G`EdgeLabels-1]]);

    for edge in G`EdgeLabels do
    	if edge eq e[3] then
    		G`EdgeDifferentials[edge] := Zero(G`EdgeAlgebra);
    	else
        	G`EdgeDifferentials[edge] := embed(G`EdgeDifferentials[edge]);
        end if;
    end for;
    
    
end intrinsic;

//==============================================================================
intrinsic AddVertex(~G::BoxType, Label::.)
{}
	if Label in G`VertexLabels then
		error "Vertex with this label already exists.";
	end if;
	
	Append(~G`VertexLabels, Label);

end intrinsic;

//==============================================================================
intrinsic RemoveEdge(~G::BoxType, Label::.)
{}
	edgenum := Position(G`EdgeLabels, Label);
	
    Remove(~G`EdgeLabels, edgenum);
    Remove(~G`EdgeLevels, Label);
    Remove(~G`EdgeSources, Label);
    Remove(~G`EdgeTails, Label);
    Remove(~G`EdgeDifferentials, Label);

    oldEdgeAlgebra := G`EdgeAlgebra;
    G`EdgeAlgebra := FreeAlgebraOld(Rationals(), #G`EdgeLabels);
    AssignNames(~G`EdgeAlgebra, G`EdgeLabels);

    project := Homomorphism(oldEdgeAlgebra, G`EdgeAlgebra, [G`EdgeAlgebra.i : i in [1..edgenum-1]] cat [Zero(G`EdgeAlgebra)] cat [G`EdgeAlgebra.(i-1) : i in [edgenum+1..#G`EdgeLabels+1]]);

    for e in G`EdgeLabels do
        G`EdgeDifferentials[e] := project(G`EdgeDifferentials[e]);
    end for;

end intrinsic;

//=============================================================================
intrinsic RemoveVertex(~B::BoxType, Label::.)
{}

	vnum := Position(B`VertexLabels, Label);
	Remove(~B`VertexLabels, vnum);
	Remove(~B`VertexHistories, Label);
	Remove(~B`VertexDimensionVectors, Label);
	
	for e in B`EdgeLabels do
		if B`EdgeSources[e] eq Label or B`EdgeTails[e] eq Label then
			RemoveEdge(~B, e);
		end if;
	end for;

end intrinsic;

//=============================================================================
intrinsic CopyBox(B::BoxType) -> BoxType
{}

	C := New(BoxType);
   	C`VertexLabels := B`VertexLabels;
    C`VertexDimensionVectors := B`VertexDimensionVectors;
    C`VertexHistories := B`VertexHistories;
    C`EdgeLabels := B`EdgeLabels;
    C`EdgeSources := B`EdgeSources;
    C`EdgeTails := B`EdgeTails;
    C`EdgeDifferentials := B`EdgeDifferentials;
    C`EdgeDegrees := B`EdgeDegrees;
    C`EdgeLevels := B`EdgeLevels;
    C`EdgeAlgebra := B`EdgeAlgebra;
    
    return C;

end intrinsic;