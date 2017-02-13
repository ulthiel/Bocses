$(function(){ // on dom ready

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
      nodes: [
        { data: { id: '11' } },
        { data: { id: '1' } },
        { data: { id: '2' } },
        { data: { id: '3' } },
        { data: { id: '4' } },
        { data: { id: '5' } },
        { data: { id: '6' } },
        { data: { id: '7' } },
        { data: { id: '8' } },
        { data: { id: '9' } },
        { data: { id: '10' } }
      ], 
      
      edges: [
        { data: { id: 'a1', source: '1', target: '2', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a2', source: '2', target: '3', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a3', source: '3', target: '4', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a4', source: '4', target: '6', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a6', source: '6', target: '9', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a5', source: '5', target: '7', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a7', source: '7', target: '10', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a8', source: '8', target: '11', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'b3', source: '3', target: '5', degree: '0', level: '2', differential: 'phi4 * a3', myLineStyle: 'solid'} },
        { data: { id: 'b4', source: '4', target: '7', degree: '0', level: '2', differential: '-1*a5 * phi4 + phi6 * a4', myLineStyle: 'solid'} },
        { data: { id: 'b6', source: '6', target: '10', degree: '0', level: '2', differential: '-1*a7 * phi6 + phi9 * a6', myLineStyle: 'solid'} },
        { data: { id: 'b5', source: '5', target: '8', degree: '0', level: '2', differential: 'phi7 * a5', myLineStyle: 'solid'} },
        { data: { id: 'b7', source: '7', target: '11', degree: '0', level: '2', differential: '-1*a8 * phi7 + phi10 * a7', myLineStyle: 'solid'} },
        { data: { id: 'c4', source: '4', target: '8', degree: '0', level: '3', differential: '-1*b5 * phi4 + phi7 * b4', myLineStyle: 'solid'} },
        { data: { id: 'c6', source: '6', target: '11', degree: '0', level: '3', differential: '-1*b7 * phi6 + phi10 * b6', myLineStyle: 'solid'} },
        { data: { id: 'phi4', source: '4', target: '5', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi6', source: '6', target: '7', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi7', source: '7', target: '8', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi9', source: '9', target: '10', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi10', source: '10', target: '11', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'psi6', source: '6', target: '8', degree: '1', level: '2', differential: 'phi7 * phi6', myLineStyle: 'dashed'} },
        { data: { id: 'psi9', source: '9', target: '11', degree: '1', level: '2', differential: 'phi10 * phi9', myLineStyle: 'dashed'} }
      ]
    },
  
  layout: {
    name: 'grid',
    directed: true,
    roots: '#a',
    padding: 50
  }
});
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
    

}); // on dom ready

