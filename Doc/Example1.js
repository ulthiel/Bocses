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
        { data: { id: '1' } },
        { data: { id: '2' } },
        { data: { id: '3' } }
      ], 
      
      edges: [
        { data: { id: 'a12', source: '1', target: '2', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a23', source: '2', target: '3', degree: '0', level: '1', differential: '0', myLineStyle: 'solid'} },
        { data: { id: 'a13', source: '1', target: '3', degree: '0', level: '2', differential: 'phi23 * a12', myLineStyle: 'solid'} },
        { data: { id: 'phi12', source: '1', target: '2', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi23', source: '2', target: '3', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi13', source: '1', target: '3', degree: '1', level: '2', differential: '0', myLineStyle: 'dashed'} }
      ]
    },
  
  layout: {
    name: 'grid',
    directed: true,
   
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
    

}); // on dom ready

