/*
	Bocses - A Magma package for computing with bocses.
	
	By 
	
	Julian Külshammer (julian.kuelshammer@mathematik.uni-stuttgart.de)
	
	and 
	
	Ulrich Thiel (thiel@mathematik.uni-stuttgart.de)
	
	File: Draw.i.m

*/

//============================================================================
intrinsic Draw(B::BocsType : Dir:="", File:="", Quiet:=false)
{}

	if Dir eq "" then
    	Dir := "Output/"*B`Title;
    else
    	Dir := "Output/"*Dir;
    end if;
       
    if File eq "" then
    	File := B`Title;
    else
    	File := File;
    end if;
    
    System("mkdir -p "*Replace(Dir, " ", "\\ "));
    
    
	//code
	codestr := "$(function(){ // on dom ready

var cy = cytoscape({
  container: document.getElementById('cy'),

  style: cytoscape.stylesheet()
    .selector('node')
      .css({
        'content': 'data(id)',
        'font-size' : '10',
        'background-color': '#61bffc',
        'text-valign': 'center'
      })
    .selector('edge')
      .css({
        'target-arrow-shape': 'triangle',
        'width': 1,
        'curve-style': 'bezier',
        'font-size' : '10',
        'line-style': 'data(myLineStyle)',
      }),
  
  elements: {
      nodes: [";
      
	for i:=1 to #B`VertexLabels do
		v := Sprint(B`VertexLabels[i]);
		codestr *:= "\n        { data: { id: '" * Sprint(v)*"' } }";
		if i lt #B`VertexLabels then
			codestr *:= ",";
		end if;
	end for;
	
	codestr *:= "
      ], 
      ";
      
    codestr *:= "
      edges: [";
      
      for i:=1 to #B`EdgeLabels do
      	e := B`EdgeLabels[i];
      	codestr *:= "\n        { data: { id: '"*Sprint(e)*"', source: '"*Sprint(B`EdgeSources[e])*"', target: '"*Sprint(B`EdgeTails[e])*"', degree: '"*Sprint(B`EdgeDegrees[e])*"', level: '"*Sprint(B`EdgeLevels[e])*"', differential: '"*Sprint(B`EdgeDifferentials[e])*"'";
      	
      	if B`EdgeDegrees[B`EdgeLabels[i]] eq 1 then
      		codestr *:= ", myLineStyle: 'dashed'";
      	else
      		codestr *:= ", myLineStyle: 'solid'";
      	end if;
      	
      	codestr *:= "} }";
      	if i lt #B`EdgeLabels then
      		codestr *:= ",";
      	end if;
      	
      end for;
      
      codestr *:= "
      ]
    },
  
  layout: {
    name: 'grid',
    directed: true,
    roots: '#a',
    padding: 50
  }
});";

	codestr *:= "
	cy.edges().qtip({
        content: function(){
            return '<b>Edge ' + this.data('id') + '</b><br>Source: ' + this.data('source') + '<br>Target: ' + this.data('target') + '<br>Degree: ' + this.data('degree') + '<br>Level: ' + this.data('level') + '<br>Differential: ' + this.data('differential');
        },
        position: {
            my: 'bottom left',
            at: 'bottom center'
        },
        style: {
            classes: 'qtip-bootstrap',
            tip: {
                width: 10,
                height: 8
            }
        }
    });
    ";
    
    codestr *:= "
    cy.nodes().qtip({
        content: function(){
            return '<b>Vertex ' + this.data(id);
        },
        position: {
            my: 'bottom left',
            at: 'bottom center'
        },
        style: {
            classes: 'qtip-bootstrap',
            tip: {
                width: 10,
                height: 8
            }
        }
    });
    ";
	
	codestr *:= "

}); // on dom ready
";

	//css file
	cssstr := "body { 
  font: 12px helvetica neue, helvetica, arial, sans-serif;
}

#cy {
  height: 100%;
  width: 100%;
  position: absolute;
  left: 0;
  top: 0;
}";

	htmlstr := "
	<!DOCTYPE html>
<html>
<head>
<link href=\"style.css\" rel=\"stylesheet\" />
<meta charset=utf-8 />
<meta name=\"viewport\" content=\"user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0\">
<title>"*B`Title*"</title>
<link rel=\"stylesheet\" type=\"text/css\" href=\"http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.css\">

		<script src=\"http://code.jquery.com/jquery-2.0.3.min.js\"></script>
		<script src=\"http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.js\"></script>
		<script src=\"http://cytoscape.github.io/cytoscape.js/api/cytoscape.js-latest/cytoscape.min.js\"></script>
		<script src=\"http://cdn.rawgit.com/cytoscape/cytoscape.js-qtip/master/cytoscape-qtip.js\"></script>
<script src=\""*File*".js\"></script>
</head>
<body>
<center><h1>"*B`Title*"</h1></center>
<div id=\"cy\"></div>
</body>
</html>
";

	Write(Dir*"/"*File*".html", htmlstr : Overwrite:=true);
	Write(Dir*"/style.css", cssstr : Overwrite:=true);
	Write(Dir*"/"*File*".js", codestr : Overwrite:=true);

	Dir := Replace(Dir, " ", "\\ ");
 	File := Replace(File, " ", "\\ ");
	
	if not Quiet then
		System("open "*Dir*"/"*File*".html");
	end if;

end intrinsic;

function QTip()


end function;