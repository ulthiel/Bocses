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
        { data: { id: '3' } },
        { data: { id: '4' } },
        { data: { id: '5' } },
        { data: { id: '6' } },
        { data: { id: '7' } },
        { data: { id: '8' } },
        { data: { id: '9' } }
      ], 
      
      edges: [
        { data: { id: 'phi12', source: '1', target: '2', degree: '1', level: '230', differential: 'a23_s * phi12_6,1 + a23_s_2,8 * phi12_6,1_8,1', myLineStyle: 'dashed'} },
        { data: { id: 'phi23', source: '2', target: '3', degree: '1', level: '585', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi13', source: '1', target: '3', degree: '1', level: '1085', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a12_t', source: '2', target: '4', degree: '1', level: '216', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s', source: '4', target: '1', degree: '1', level: '162', differential: 'a13_s * a12_s_7,4 + a13_6,1_s * a12_s_8,4 + a13_5,1_s * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4', source: '4', target: '3', degree: '1', level: '1260', differential: '-1*phi13 * a12_s - phi13_3,7 * a12_s_7,4 - phi13_3,8 * a12_s_8,4 - phi13_3,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4', source: '4', target: '2', degree: '1', level: '405', differential: '-1*phi12 * a12_s + a23_s * phi12_2,4_6,4 - phi12_2,7 * a12_s_7,4 - phi12_2,8 * a12_s_8,4 + a23_s_2,8 * phi12_2,4_6,4_8,4 - phi12_2,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4', source: '4', target: '4', degree: '1', level: '648', differential: 'a12_t * phi12_2,4 - phi12_4,1 * a12_s + a23_3,4_s * phi12_4,4_5,4 + a12_t_4,6 * phi12_2,4_6,4 - phi12_4,1_4,7 * a12_s_7,4 - phi12_4,1_4,8 * a12_s_8,4 + a12_t_4,6_4,8 * phi12_2,4_6,4_8,4 - phi12_4,1_4,9 * a12_s_9,4 + a23_3,4_s_4,9 * phi12_4,4_5,4_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1', source: '1', target: '4', degree: '1', level: '473', differential: 'a12_t * phi12 + a23_3,4_s * phi12_4,1_5,1 + a12_t_4,6 * phi12_6,1 + a12_t_4,6_4,8 * phi12_6,1_8,1 + a23_3,4_s_4,9 * phi12_4,1_5,1_9,1', myLineStyle: 'dashed'} },
        { data: { id: 'a23_3,4_t', source: '3', target: '5', degree: '1', level: '80', differential: '-1*a23_3,4_t_5,6 * a23_t', myLineStyle: 'dashed'} },
        { data: { id: 'a23_3,4_s', source: '5', target: '4', degree: '1', level: '81', differential: '-1*a23_3,4_s_4,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_5,5', source: '5', target: '5', degree: '1', level: '647', differential: '-1*phi12_4,4_5,4 * a23_3,4_s - phi12_4,1_5,1 * a12_s_1,5 + a23_3,4_t_5,6 * phi12_2,4_2,5_6,5 - phi12_4,1_5,1_5,7 * a12_s_1,5_7,5 - phi12_4,1_5,1_5,8 * a12_s_1,5_8,5 - phi12_4,1_5,1_5,9 * a12_s_1,5_9,5 - phi12_4,4_5,5_5,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_4,5', source: '5', target: '4', degree: '1', level: '729', differential: 'a12_t * phi12_2,4_2,5 - phi12_4,4 * a23_3,4_s - phi12_4,1 * a12_s_1,5 + a23_3,4_s * phi12_4,4_5,5 + a12_t_4,6 * phi12_2,4_2,5_6,5 - phi12_4,1_4,7 * a12_s_1,5_7,5 - phi12_4,1_4,8 * a12_s_1,5_8,5 + a12_t_4,6_4,8 * phi12_2,4_2,5_6,5_8,5 - phi12_4,4_4,5_4,9 * a13_5,1_t - phi12_4,1_4,9 * a12_s_1,5_9,5 + a23_3,4_s_4,9 * phi12_4,4_5,5_9,5', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_5,4', source: '4', target: '5', degree: '1', level: '566', differential: '-1*phi12_4,1_5,1 * a12_s + a23_3,4_t_5,6 * phi12_2,4_6,4 - phi12_4,1_5,1_5,7 * a12_s_7,4 - phi12_4,1_5,1_5,8 * a12_s_8,4 - phi12_4,1_5,1_5,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5', source: '5', target: '3', degree: '1', level: '1341', differential: '-1*phi13 * a12_s_1,5 - phi13_3,4 * a23_3,4_s - phi13_3,7 * a12_s_1,5_7,5 - phi13_3,8 * a12_s_1,5_8,5 - phi13_3,9 * a12_s_1,5_9,5 - phi13_3,4_3,5_3,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_5,5', source: '5', target: '5', degree: '1', level: '1457', differential: 'a23_3,4_t * phi13_3,4_3,5 - phi13_3,4_5,4 * a23_3,4_s - phi13_5,1 * a12_s_1,5 + a23_3,4_t_5,6 * phi13_3,4_3,5_6,5 - phi13_5,1_5,7 * a12_s_1,5_7,5 - phi13_5,1_5,8 * a12_s_1,5_8,5 - phi13_3,4_5,5_5,9 * a13_5,1_t - phi13_5,1_5,9 * a12_s_1,5_9,5', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_5,4', source: '4', target: '5', degree: '1', level: '1376', differential: 'a23_3,4_t * phi13_3,4 - phi13_5,1 * a12_s + a23_3,4_t_5,6 * phi13_3,4_6,4 - phi13_5,1_5,7 * a12_s_7,4 - phi13_5,1_5,8 * a12_s_8,4 - phi13_5,1_5,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5', source: '5', target: '1', degree: '1', level: '243', differential: '-1*a12_s * a23_3,4_s + a13_s * a12_s_1,5_7,5 + a13_6,1_s * a12_s_1,5_8,5 + a13_5,1_s * a12_s_1,5_9,5 - a12_s_1,5_1,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_5,2', source: '2', target: '5', degree: '1', level: '701', differential: 'a23_3,4_t * phi23 + a23_3,4_t_5,6 * phi23_6,2', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1', source: '1', target: '5', degree: '1', level: '391', differential: 'a23_3,4_t_5,6 * phi12_6,1', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1', source: '1', target: '5', degree: '1', level: '1201', differential: 'a23_3,4_t * phi13 + a23_3,4_t_5,6 * phi13_6,1', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_2,5', source: '5', target: '2', degree: '1', level: '486', differential: '-1*phi12 * a12_s_1,5 - phi12_2,4 * a23_3,4_s + a23_s * phi12_2,4_2,5_6,5 - phi12_2,7 * a12_s_1,5_7,5 - phi12_2,8 * a12_s_1,5_8,5 + a23_s_2,8 * phi12_2,4_2,5_6,5_8,5 - phi12_2,9 * a12_s_1,5_9,5 - phi12_2,4_2,5_2,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'a23_t', source: '3', target: '6', degree: '1', level: '24', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a23_s', source: '6', target: '2', degree: '1', level: '27', differential: '-1*a23_s_2,8 * a13_6,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_6,4', source: '4', target: '6', degree: '1', level: '375', differential: '-1*phi12_6,1 * a12_s - phi12_6,1_6,7 * a12_s_7,4 - phi12_6,1_6,8 * a12_s_8,4 - phi12_6,1_6,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_6,4', source: '4', target: '6', degree: '1', level: '1293', differential: 'a23_t * phi13_3,4 - phi13_6,1 * a12_s - phi13_6,1_6,7 * a12_s_7,4 - phi13_6,1_6,8 * a12_s_8,4 - phi13_6,1_6,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_2,5_6,5', source: '5', target: '6', degree: '1', level: '456', differential: '-1*phi12_2,4_6,4 * a23_3,4_s - phi12_6,1 * a12_s_1,5 - phi12_6,1_6,7 * a12_s_1,5_7,5 - phi12_6,1_6,8 * a12_s_1,5_8,5 - phi12_6,1_6,9 * a12_s_1,5_9,5 - phi12_2,4_2,5_6,5_6,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1', source: '1', target: '6', degree: '1', level: '200', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1', source: '1', target: '6', degree: '1', level: '1118', differential: 'a23_t * phi13', myLineStyle: 'dashed'} },
        { data: { id: 'a23_3,4_t_5,6', source: '6', target: '5', degree: '1', level: '53', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_6,5', source: '5', target: '6', degree: '1', level: '1374', differential: 'a23_t * phi13_3,4_3,5 - phi13_3,4_6,4 * a23_3,4_s - phi13_6,1 * a12_s_1,5 - phi13_6,1_6,7 * a12_s_1,5_7,5 - phi13_6,1_6,8 * a12_s_1,5_8,5 - phi13_6,1_6,9 * a12_s_1,5_9,5 - phi13_3,4_3,5_6,5_6,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_3,6', source: '6', target: '3', degree: '1', level: '612', differential: '-1*phi23 * a23_s - phi23_3,6_3,8 * a13_6,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_6,6', source: '6', target: '6', degree: '1', level: '645', differential: 'a23_t * phi23_3,6 - phi23_6,2 * a23_s - phi23_6,6_6,8 * a13_6,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_6,2', source: '2', target: '6', degree: '1', level: '618', differential: 'a23_t * phi23', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_5,2_5,6', source: '6', target: '5', degree: '1', level: '728', differential: 'a23_3,4_t * phi23_3,6 - phi23_5,2 * a23_s + a23_3,4_t_5,6 * phi23_6,6 - phi23_5,2_5,6_5,8 * a13_6,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'a12_t_4,6', source: '6', target: '4', degree: '1', level: '243', differential: '-1*a12_t * a23_s + a23_3,4_s * a23_3,4_t_5,6 - a12_t_4,6_4,8 * a13_6,1_t + a23_3,4_s_4,9 * a23_3,4_t_5,6_9,6', myLineStyle: 'dashed'} },
        { data: { id: 'a13_t', source: '3', target: '7', degree: '1', level: '9', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a13_s', source: '7', target: '1', degree: '1', level: '9', differential: 'a13_6,1_s * a13_s_8,7 + a13_5,1_s * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_5,7', source: '7', target: '5', degree: '1', level: '1214', differential: 'a23_3,4_t * phi13_3,7 - phi13_5,1 * a13_s + a23_3,4_t_5,6 * phi13_6,1_6,7 - phi13_5,1_5,8 * a13_s_8,7 - phi13_5,1_5,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_5,7', source: '7', target: '5', degree: '1', level: '404', differential: '-1*phi12_4,1_5,1 * a13_s + a23_3,4_t_5,6 * phi12_6,1_6,7 - phi12_4,1_5,1_5,8 * a13_s_8,7 - phi12_4,1_5,1_5,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_6,7', source: '7', target: '6', degree: '1', level: '1131', differential: 'a23_t * phi13_3,7 - phi13_6,1 * a13_s - phi13_6,1_6,8 * a13_s_8,7 - phi13_6,1_6,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_6,7', source: '7', target: '6', degree: '1', level: '213', differential: '-1*phi12_6,1 * a13_s - phi12_6,1_6,8 * a13_s_8,7 - phi12_6,1_6,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_3,6_7,6', source: '6', target: '7', degree: '1', level: '621', differential: 'a13_t * phi23_3,6 - a12_s_7,4 * a12_t_4,6 - a12_s_1,5_7,5 * a23_3,4_t_5,6 - phi23_7,2 * a23_s - phi23_3,6_7,6_7,8 * a13_6,1_t - a12_s_1,5_7,5_7,9 * a23_3,4_t_5,6_9,6', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_7,4', source: '4', target: '7', degree: '1', level: '153', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_7,5', source: '5', target: '7', degree: '1', level: '234', differential: '-1*a12_s_7,4 * a23_3,4_s - a12_s_1,5_7,5_7,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_7,2', source: '2', target: '7', degree: '1', level: '594', differential: 'a13_t * phi23 - a12_s_7,4 * a12_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_7,4', source: '4', target: '7', degree: '1', level: '1269', differential: 'a13_t * phi13_3,4 - phi13_7,7 * a12_s_7,4 - phi13_7,1 * a12_s - phi13_7,1_7,8 * a12_s_8,4 - phi13_7,1_7,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,7', source: '7', target: '2', degree: '1', level: '243', differential: '-1*phi12 * a13_s + a23_s * phi12_6,1_6,7 - phi12_2,8 * a13_s_8,7 + a23_s_2,8 * phi12_6,1_6,7_8,7 - phi12_2,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_4,7', source: '7', target: '4', degree: '1', level: '486', differential: 'a12_t * phi12_2,7 - phi12_4,1 * a13_s + a23_3,4_s * phi12_4,1_5,1_5,7 + a12_t_4,6 * phi12_6,1_6,7 - phi12_4,1_4,8 * a13_s_8,7 + a12_t_4,6_4,8 * phi12_6,1_6,7_8,7 - phi12_4,1_4,9 * a13_s_9,7 + a23_3,4_s_4,9 * phi12_4,1_5,1_5,7_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_7,5', source: '5', target: '7', degree: '1', level: '1350', differential: 'a13_t * phi13_3,4_3,5 - phi13_3,4_7,4 * a23_3,4_s - phi13_7,7 * a12_s_1,5_7,5 - phi13_7,1 * a12_s_1,5 - phi13_7,1_7,8 * a12_s_1,5_8,5 - phi13_3,4_3,5_7,5_7,9 * a13_5,1_t - phi13_7,1_7,9 * a12_s_1,5_9,5', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,7', source: '7', target: '3', degree: '1', level: '1098', differential: '-1*phi13 * a13_s - phi13_3,8 * a13_s_8,7 - phi13_3,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_7,7', source: '7', target: '7', degree: '1', level: '1107', differential: 'a13_t * phi13_3,7 - phi13_7,1 * a13_s - phi13_7,1_7,8 * a13_s_8,7 - phi13_7,1_7,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_7,1', source: '1', target: '7', degree: '1', level: '1094', differential: 'a13_t * phi13', myLineStyle: 'dashed'} },
        { data: { id: 'a13_6,1_t', source: '6', target: '8', degree: '1', level: '3', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a13_6,1_s', source: '8', target: '1', degree: '1', level: '3', differential: 'a13_5,1_s * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_6,7_8,7', source: '7', target: '8', degree: '1', level: '1134', differential: 'a13_6,1_t * phi13_6,1_6,7 + a23_t_8,3 * phi13_3,7 - phi13_6,1_8,8 * a13_s_8,7 - phi13_6,1_8,1 * a13_s + a13_s_8,7 * phi13_7,7 - phi13_6,1_8,1_8,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,8', source: '8', target: '2', degree: '1', level: '234', differential: '-1*phi12 * a13_6,1_s + a23_s * phi12_6,1_6,8 + a23_s_2,8 * phi12_6,1_8,8 - phi12_2,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_5,2_5,6_5,8', source: '8', target: '5', degree: '1', level: '725', differential: 'a23_3,4_t * phi23_3,6_3,8 - phi23_5,2 * a23_s_2,8 + a23_3,4_t_5,6 * phi23_6,6_6,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_3,6_7,6_7,8', source: '8', target: '7', degree: '1', level: '618', differential: 'a13_t * phi23_3,6_3,8 - a12_s_7,4 * a12_t_4,6_4,8 - phi23_7,2 * a23_s_2,8 - a12_s_1,5_7,5_7,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,8', source: '8', target: '3', degree: '1', level: '1089', differential: '-1*phi13 * a13_6,1_s - phi13_3,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_6,5_8,5', source: '5', target: '8', degree: '1', level: '1377', differential: 'a13_6,1_t * phi13_3,4_3,5_6,5 - phi13_6,1_6,7_8,7 * a12_s_1,5_7,5 - phi13_3,4_6,4_8,4 * a23_3,4_s + a23_t_8,3 * phi13_3,4_3,5 - phi13_6,1_8,8 * a12_s_1,5_8,5 - phi13_6,1_8,1 * a12_s_1,5 + a13_s_8,7 * phi13_3,4_3,5_7,5 - phi13_6,1_8,1_8,9 * a12_s_1,5_9,5 - phi13_3,4_3,5_6,5_8,5_8,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_2,5_6,5_8,5', source: '5', target: '8', degree: '1', level: '459', differential: 'a13_6,1_t * phi12_2,4_2,5_6,5 - phi12_6,1_6,7_8,7 * a12_s_1,5_7,5 - phi12_6,1_8,8 * a12_s_1,5_8,5 - phi12_6,1_8,1 * a12_s_1,5 - phi12_2,4_6,4_8,4 * a23_3,4_s - phi12_6,1_8,1_8,9 * a12_s_1,5_9,5 - phi12_2,4_2,5_6,5_8,5_8,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_6,4_8,4', source: '4', target: '8', degree: '1', level: '1296', differential: 'a13_6,1_t * phi13_3,4_6,4 - phi13_6,1_6,7_8,7 * a12_s_7,4 + a23_t_8,3 * phi13_3,4 - phi13_6,1_8,8 * a12_s_8,4 - phi13_6,1_8,1 * a12_s + a13_s_8,7 * phi13_3,4_7,4 - phi13_6,1_8,1_8,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_5,8', source: '8', target: '5', degree: '1', level: '395', differential: '-1*phi12_4,1_5,1 * a13_6,1_s + a23_3,4_t_5,6 * phi12_6,1_6,8 - phi12_4,1_5,1_5,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_6,7_8,7', source: '7', target: '8', degree: '1', level: '216', differential: 'a13_6,1_t * phi12_6,1_6,7 - phi12_6,1_8,8 * a13_s_8,7 - phi12_6,1_8,1 * a13_s - phi12_6,1_8,1_8,9 * a13_s_9,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_5,8', source: '8', target: '5', degree: '1', level: '1205', differential: 'a23_3,4_t * phi13_3,8 - phi13_5,1 * a13_6,1_s + a23_3,4_t_5,6 * phi13_6,1_6,8 - phi13_5,1_5,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'a23_s_2,8', source: '8', target: '2', degree: '1', level: '24', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_6,2_8,2', source: '2', target: '8', degree: '1', level: '621', differential: 'a13_6,1_t * phi23_6,2 + a23_t_8,3 * phi23 - a12_s_8,4 * a12_t + a13_s_8,7 * phi23_7,2', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_8,5', source: '5', target: '8', degree: '1', level: '240', differential: '-1*a12_s_8,4 * a23_3,4_s + a13_s_8,7 * a12_s_1,5_7,5 - a12_s_1,5_8,5_8,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_4,8', source: '8', target: '4', degree: '1', level: '477', differential: 'a12_t * phi12_2,8 - phi12_4,1 * a13_6,1_s + a23_3,4_s * phi12_4,1_5,1_5,8 + a12_t_4,6 * phi12_6,1_6,8 + a12_t_4,6_4,8 * phi12_6,1_8,8 - phi12_4,1_4,9 * a13_6,1_s_9,8 + a23_3,4_s_4,9 * phi12_4,1_5,1_5,8_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_7,1_7,8', source: '8', target: '7', degree: '1', level: '1098', differential: 'a13_t * phi13_3,8 - phi13_7,1 * a13_6,1_s - phi13_7,1_7,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'a23_t_8,3', source: '3', target: '8', degree: '1', level: '27', differential: 'a13_6,1_t * a23_t - a13_s_8,7 * a13_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_6,8', source: '8', target: '6', degree: '1', level: '1122', differential: 'a23_t * phi13_3,8 - phi13_6,1 * a13_6,1_s - phi13_6,1_6,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_8,8', source: '8', target: '8', degree: '1', level: '1125', differential: 'a13_6,1_t * phi13_6,1_6,8 + a23_t_8,3 * phi13_3,8 - phi13_6,1_8,1 * a13_6,1_s + a13_s_8,7 * phi13_7,1_7,8 - phi13_6,1_8,1_8,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_8,1', source: '1', target: '8', degree: '1', level: '1121', differential: 'a13_6,1_t * phi13_6,1 + a23_t_8,3 * phi13 + a13_s_8,7 * phi13_7,1', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_6,8', source: '8', target: '6', degree: '1', level: '204', differential: '-1*phi12_6,1 * a13_6,1_s - phi12_6,1_6,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_8,8', source: '8', target: '8', degree: '1', level: '207', differential: 'a13_6,1_t * phi12_6,1_6,8 - phi12_6,1_8,1 * a13_6,1_s - phi12_6,1_8,1_8,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_8,1', source: '1', target: '8', degree: '1', level: '203', differential: 'a13_6,1_t * phi12_6,1', myLineStyle: 'dashed'} },
        { data: { id: 'a12_t_4,6_4,8', source: '8', target: '4', degree: '1', level: '240', differential: '-1*a12_t * a23_s_2,8 + a23_3,4_s_4,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_6,4_8,4', source: '4', target: '8', degree: '1', level: '378', differential: 'a13_6,1_t * phi12_2,4_6,4 - phi12_6,1_6,7_8,7 * a12_s_7,4 - phi12_6,1_8,8 * a12_s_8,4 - phi12_6,1_8,1 * a12_s - phi12_6,1_8,1_8,9 * a12_s_9,4', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_8,4', source: '4', target: '8', degree: '1', level: '159', differential: 'a13_s_8,7 * a12_s_7,4', myLineStyle: 'dashed'} },
        { data: { id: 'a13_s_8,7', source: '7', target: '8', degree: '1', level: '6', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_6,6_8,8', source: '8', target: '8', degree: '1', level: '645', differential: 'a13_6,1_t * phi23_6,6_6,8 - phi23_6,2_8,2 * a23_s_2,8 + a23_t_8,3 * phi23_3,6_3,8 - a12_s_8,4 * a12_t_4,6_4,8 + a13_s_8,7 * phi23_3,6_7,6_7,8 - a12_s_1,5_8,5_8,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_6,6_6,8', source: '8', target: '6', degree: '1', level: '642', differential: 'a23_t * phi23_3,6_3,8 - phi23_6,2 * a23_s_2,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_6,6_8,6', source: '6', target: '8', degree: '1', level: '648', differential: 'a13_6,1_t * phi23_6,6 - phi23_6,2_8,2 * a23_s - a12_s_1,5_8,5 * a23_3,4_t_5,6 + a23_t_8,3 * phi23_3,6 - a12_s_8,4 * a12_t_4,6 + a13_s_8,7 * phi23_3,6_7,6 - phi23_6,6_8,8 * a13_6,1_t - a12_s_1,5_8,5_8,9 * a23_3,4_t_5,6_9,6', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_3,6_3,8', source: '8', target: '3', degree: '1', level: '609', differential: '-1*phi23 * a23_s_2,8', myLineStyle: 'dashed'} },
        { data: { id: 'a13_5,1_t', source: '5', target: '9', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a13_5,1_s', source: '9', target: '1', degree: '1', level: '1', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a13_s_9,7', source: '7', target: '9', degree: '1', level: '8', differential: 'a13_6,1_s_9,8 * a13_s_8,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_5,2_5,6_9,6', source: '6', target: '9', degree: '1', level: '729', differential: 'a13_5,1_t * phi23_5,2_5,6 + a13_s_9,7 * phi23_3,6_7,6 + a13_6,1_s_9,8 * phi23_6,6_8,6 - phi23_5,2_9,2 * a23_s + a23_3,4_t_9,3 * phi23_3,6 - a12_s_9,4 * a12_t_4,6 - phi23_5,2_5,6_5,8_9,8 * a13_6,1_t + a23_3,4_t_5,6_9,6 * phi23_6,6 - a12_s_1,5_9,5 * a23_3,4_t_5,6 - a12_s_1,5_9,9 * a23_3,4_t_5,6_9,6', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_6,9', source: '9', target: '6', degree: '1', level: '1119', differential: 'a23_t * phi13_3,9 - phi13_6,1 * a13_5,1_s', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_5,7_9,7', source: '7', target: '9', degree: '1', level: '1215', differential: 'a13_5,1_t * phi13_5,1_5,7 + a13_s_9,7 * phi13_7,7 + a13_6,1_s_9,8 * phi13_6,1_6,7_8,7 + a23_3,4_t_9,3 * phi13_3,7 - phi13_5,1_5,8_9,8 * a13_s_8,7 - phi13_5,1_9,9 * a13_s_9,7 - phi13_5,1_9,1 * a13_s + a23_3,4_t_5,6_9,6 * phi13_6,1_6,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_5,9', source: '9', target: '5', degree: '1', level: '392', differential: '-1*phi12_4,1_5,1 * a13_5,1_s + a23_3,4_t_5,6 * phi12_6,1_6,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_9,9', source: '9', target: '9', degree: '1', level: '393', differential: 'a13_5,1_t * phi12_4,1_5,1_5,9 - phi12_4,1_5,1_9,1 * a13_5,1_s + a13_6,1_s_9,8 * phi12_6,1_8,1_8,9 + a23_3,4_t_5,6_9,6 * phi12_6,1_6,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_9,1', source: '1', target: '9', degree: '1', level: '392', differential: 'a13_5,1_t * phi12_4,1_5,1 + a13_6,1_s_9,8 * phi12_6,1_8,1 + a23_3,4_t_5,6_9,6 * phi12_6,1', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,9', source: '9', target: '2', degree: '1', level: '231', differential: '-1*phi12 * a13_5,1_s + a23_s * phi12_6,1_6,9 + a23_s_2,8 * phi12_6,1_8,1_8,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_7,5_7,9', source: '9', target: '7', degree: '1', level: '1349', differential: 'a13_t * phi13_3,4_3,5_3,9 - phi13_3,4_7,4 * a23_3,4_s_4,9 - phi13_7,7 * a12_s_1,5_7,5_7,9 - phi13_7,1 * a12_s_1,5_1,9 - phi13_7,1_7,8 * a12_s_1,5_8,5_8,9 - phi13_7,1_7,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'a13_6,1_s_9,8', source: '8', target: '9', degree: '1', level: '2', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,9', source: '9', target: '3', degree: '1', level: '1086', differential: '-1*phi13 * a13_5,1_s', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_5,7_9,7', source: '7', target: '9', degree: '1', level: '405', differential: 'a13_5,1_t * phi12_4,1_5,1_5,7 - phi12_4,1_5,1_9,9 * a13_s_9,7 - phi12_4,1_5,1_9,1 * a13_s + a13_6,1_s_9,8 * phi12_6,1_6,7_8,7 - phi12_4,1_5,1_5,8_9,8 * a13_s_8,7 + a23_3,4_t_5,6_9,6 * phi12_6,1_6,7', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_5,5_9,9', source: '9', target: '9', degree: '1', level: '1457', differential: 'a13_5,1_t * phi13_3,4_5,5_5,9 + a13_s_9,7 * phi13_3,4_3,5_7,5_7,9 - phi13_5,1_5,7_9,7 * a12_s_1,5_7,5_7,9 + a13_6,1_s_9,8 * phi13_3,4_3,5_6,5_8,5_8,9 - phi13_3,4_5,4_9,4 * a23_3,4_s_4,9 + a23_3,4_t_9,3 * phi13_3,4_3,5_3,9 - phi13_5,1_5,8_9,8 * a12_s_1,5_8,5_8,9 - phi13_5,1_9,9 * a12_s_1,5_9,9 - phi13_5,1_9,1 * a12_s_1,5_1,9 + a23_3,4_t_5,6_9,6 * phi13_3,4_3,5_6,5_6,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_5,5_5,9', source: '9', target: '5', degree: '1', level: '1456', differential: 'a23_3,4_t * phi13_3,4_3,5_3,9 - phi13_3,4_5,4 * a23_3,4_s_4,9 - phi13_5,1 * a12_s_1,5_1,9 + a23_3,4_t_5,6 * phi13_3,4_3,5_6,5_6,9 - phi13_5,1_5,7 * a12_s_1,5_7,5_7,9 - phi13_5,1_5,8 * a12_s_1,5_8,5_8,9 - phi13_5,1_5,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_5,5_9,5', source: '5', target: '9', degree: '1', level: '1458', differential: 'a13_5,1_t * phi13_3,4_5,5 + a13_s_9,7 * phi13_3,4_3,5_7,5 - phi13_5,1_5,7_9,7 * a12_s_1,5_7,5 + a13_6,1_s_9,8 * phi13_3,4_3,5_6,5_8,5 - phi13_3,4_5,5_9,9 * a13_5,1_t - phi13_3,4_5,4_9,4 * a23_3,4_s + a23_3,4_t_9,3 * phi13_3,4_3,5 - phi13_5,1_5,8_9,8 * a12_s_1,5_8,5 - phi13_5,1_9,9 * a12_s_1,5_9,5 - phi13_5,1_9,1 * a12_s_1,5 + a23_3,4_t_5,6_9,6 * phi13_3,4_3,5_6,5', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_4,5_4,9', source: '9', target: '4', degree: '1', level: '728', differential: 'a12_t * phi12_2,4_2,5_2,9 - phi12_4,4 * a23_3,4_s_4,9 - phi12_4,1 * a12_s_1,5_1,9 + a23_3,4_s * phi12_4,4_5,5_5,9 + a12_t_4,6 * phi12_2,4_2,5_6,5_6,9 - phi12_4,1_4,7 * a12_s_1,5_7,5_7,9 - phi12_4,1_4,8 * a12_s_1,5_8,5_8,9 + a12_t_4,6_4,8 * phi12_2,4_2,5_6,5_8,5_8,9 - phi12_4,1_4,9 * a12_s_1,5_9,9 + a23_3,4_s_4,9 * phi12_4,4_5,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_5,4_9,4', source: '4', target: '9', degree: '1', level: '1377', differential: 'a13_5,1_t * phi13_3,4_5,4 + a13_s_9,7 * phi13_3,4_7,4 - phi13_5,1_5,7_9,7 * a12_s_7,4 + a13_6,1_s_9,8 * phi13_3,4_6,4_8,4 + a23_3,4_t_9,3 * phi13_3,4 - phi13_5,1_5,8_9,8 * a12_s_8,4 - phi13_5,1_9,9 * a12_s_9,4 - phi13_5,1_9,1 * a12_s + a23_3,4_t_5,6_9,6 * phi13_3,4_6,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_6,9', source: '9', target: '6', degree: '1', level: '201', differential: '-1*phi12_6,1 * a13_5,1_s', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_2,5_2,9', source: '9', target: '2', degree: '1', level: '485', differential: '-1*phi12 * a12_s_1,5_1,9 - phi12_2,4 * a23_3,4_s_4,9 + a23_s * phi12_2,4_2,5_6,5_6,9 - phi12_2,7 * a12_s_1,5_7,5_7,9 - phi12_2,8 * a12_s_1,5_8,5_8,9 + a23_s_2,8 * phi12_2,4_2,5_6,5_8,5_8,9 - phi12_2,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_5,2_9,2', source: '2', target: '9', degree: '1', level: '702', differential: 'a13_5,1_t * phi23_5,2 + a13_s_9,7 * phi23_7,2 + a13_6,1_s_9,8 * phi23_6,2_8,2 + a23_3,4_t_9,3 * phi23 - a12_s_9,4 * a12_t + a23_3,4_t_5,6_9,6 * phi23_6,2', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_5,1_5,8_9,8', source: '8', target: '9', degree: '1', level: '396', differential: 'a13_5,1_t * phi12_4,1_5,1_5,8 - phi12_4,1_5,1_9,9 * a13_6,1_s_9,8 - phi12_4,1_5,1_9,1 * a13_6,1_s + a13_6,1_s_9,8 * phi12_6,1_8,8 + a23_3,4_t_5,6_9,6 * phi12_6,1_6,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,1_4,9', source: '9', target: '4', degree: '1', level: '474', differential: 'a12_t * phi12_2,9 - phi12_4,1 * a13_5,1_s + a23_3,4_s * phi12_4,1_5,1_5,9 + a12_t_4,6 * phi12_6,1_6,9 + a12_t_4,6_4,8 * phi12_6,1_8,1_8,9 + a23_3,4_s_4,9 * phi12_4,1_5,1_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'a23_3,4_s_4,9', source: '9', target: '4', degree: '1', level: '80', differential: '0', myLineStyle: 'dashed'} },
        { data: { id: 'a23_3,4_t_9,3', source: '3', target: '9', degree: '1', level: '81', differential: 'a13_5,1_t * a23_3,4_t - a13_s_9,7 * a13_t - a13_6,1_s_9,8 * a23_t_8,3 - a23_3,4_t_5,6_9,6 * a23_t', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_9,4', source: '4', target: '9', degree: '1', level: '161', differential: 'a13_s_9,7 * a12_s_7,4 + a13_6,1_s_9,8 * a12_s_8,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_6,1_8,1_8,9', source: '9', target: '8', degree: '1', level: '204', differential: 'a13_6,1_t * phi12_6,1_6,9 - phi12_6,1_8,1 * a13_5,1_s', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_6,1_8,1_8,9', source: '9', target: '8', degree: '1', level: '1122', differential: 'a13_6,1_t * phi13_6,1_6,9 + a23_t_8,3 * phi13_3,9 - phi13_6,1_8,1 * a13_5,1_s + a13_s_8,7 * phi13_7,1_7,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_6,5_6,9', source: '9', target: '6', degree: '1', level: '1373', differential: 'a23_t * phi13_3,4_3,5_3,9 - phi13_3,4_6,4 * a23_3,4_s_4,9 - phi13_6,1 * a12_s_1,5_1,9 - phi13_6,1_6,7 * a12_s_1,5_7,5_7,9 - phi13_6,1_6,8 * a12_s_1,5_8,5_8,9 - phi13_6,1_6,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_7,1_7,9', source: '9', target: '7', degree: '1', level: '1095', differential: 'a13_t * phi13_3,9 - phi13_7,1 * a13_5,1_s', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_8,5_8,9', source: '9', target: '8', degree: '1', level: '239', differential: '-1*a12_s_8,4 * a23_3,4_s_4,9 + a13_s_8,7 * a12_s_1,5_7,5_7,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi23_5,2_5,6_5,8_9,8', source: '8', target: '9', degree: '1', level: '726', differential: 'a13_5,1_t * phi23_5,2_5,6_5,8 + a13_s_9,7 * phi23_3,6_7,6_7,8 + a13_6,1_s_9,8 * phi23_6,6_8,8 - phi23_5,2_9,2 * a23_s_2,8 + a23_3,4_t_9,3 * phi23_3,6_3,8 - a12_s_9,4 * a12_t_4,6_4,8 + a23_3,4_t_5,6_9,6 * phi23_6,6_6,8 - a12_s_1,5_9,9 * a13_6,1_s_9,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_5,5_9,9', source: '9', target: '9', degree: '1', level: '647', differential: 'a13_5,1_t * phi12_4,4_5,5_5,9 - phi12_4,1_5,1_9,9 * a12_s_1,5_9,9 - phi12_4,1_5,1_9,1 * a12_s_1,5_1,9 + a13_6,1_s_9,8 * phi12_2,4_2,5_6,5_8,5_8,9 - phi12_4,1_5,1_5,7_9,7 * a12_s_1,5_7,5_7,9 - phi12_4,1_5,1_5,8_9,8 * a12_s_1,5_8,5_8,9 - phi12_4,4_5,4_9,4 * a23_3,4_s_4,9 + a23_3,4_t_5,6_9,6 * phi12_2,4_2,5_6,5_6,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_5,5_5,9', source: '9', target: '5', degree: '1', level: '646', differential: '-1*phi12_4,4_5,4 * a23_3,4_s_4,9 - phi12_4,1_5,1 * a12_s_1,5_1,9 + a23_3,4_t_5,6 * phi12_2,4_2,5_6,5_6,9 - phi12_4,1_5,1_5,7 * a12_s_1,5_7,5_7,9 - phi12_4,1_5,1_5,8 * a12_s_1,5_8,5_8,9 - phi12_4,1_5,1_5,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_5,5_9,5', source: '5', target: '9', degree: '1', level: '648', differential: 'a13_5,1_t * phi12_4,4_5,5 - phi12_4,1_5,1_9,9 * a12_s_1,5_9,5 - phi12_4,1_5,1_9,1 * a12_s_1,5 + a13_6,1_s_9,8 * phi12_2,4_2,5_6,5_8,5 - phi12_4,1_5,1_5,7_9,7 * a12_s_1,5_7,5 - phi12_4,1_5,1_5,8_9,8 * a12_s_1,5_8,5 - phi12_4,4_5,5_9,9 * a13_5,1_t - phi12_4,4_5,4_9,4 * a23_3,4_s + a23_3,4_t_5,6_9,6 * phi12_2,4_2,5_6,5', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_5,8_9,8', source: '8', target: '9', degree: '1', level: '1206', differential: 'a13_5,1_t * phi13_5,1_5,8 + a13_s_9,7 * phi13_7,1_7,8 + a13_6,1_s_9,8 * phi13_6,1_8,8 + a23_3,4_t_9,3 * phi13_3,8 - phi13_5,1_9,9 * a13_6,1_s_9,8 - phi13_5,1_9,1 * a13_6,1_s + a23_3,4_t_5,6_9,6 * phi13_6,1_6,8', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_3,9', source: '9', target: '3', degree: '1', level: '1340', differential: '-1*phi13 * a12_s_1,5_1,9 - phi13_3,4 * a23_3,4_s_4,9 - phi13_3,7 * a12_s_1,5_7,5_7,9 - phi13_3,8 * a12_s_1,5_8,5_8,9 - phi13_3,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_4,4_5,4_9,4', source: '4', target: '9', degree: '1', level: '567', differential: 'a13_5,1_t * phi12_4,4_5,4 - phi12_4,1_5,1_9,9 * a12_s_9,4 - phi12_4,1_5,1_9,1 * a12_s + a13_6,1_s_9,8 * phi12_2,4_6,4_8,4 - phi12_4,1_5,1_5,7_9,7 * a12_s_7,4 - phi12_4,1_5,1_5,8_9,8 * a12_s_8,4 + a23_3,4_t_5,6_9,6 * phi12_2,4_6,4', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_5,9', source: '9', target: '5', degree: '1', level: '1202', differential: 'a23_3,4_t * phi13_3,9 - phi13_5,1 * a13_5,1_s + a23_3,4_t_5,6 * phi13_6,1_6,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_9,9', source: '9', target: '9', degree: '1', level: '1203', differential: 'a13_5,1_t * phi13_5,1_5,9 + a13_s_9,7 * phi13_7,1_7,9 + a13_6,1_s_9,8 * phi13_6,1_8,1_8,9 + a23_3,4_t_9,3 * phi13_3,9 - phi13_5,1_9,1 * a13_5,1_s + a23_3,4_t_5,6_9,6 * phi13_6,1_6,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_5,1_9,1', source: '1', target: '9', degree: '1', level: '1202', differential: 'a13_5,1_t * phi13_5,1 + a13_s_9,7 * phi13_7,1 + a13_6,1_s_9,8 * phi13_6,1_8,1 + a23_3,4_t_9,3 * phi13 + a23_3,4_t_5,6_9,6 * phi13_6,1', myLineStyle: 'dashed'} },
        { data: { id: 'phi13_3,4_3,5_6,5_8,5_8,9', source: '9', target: '8', degree: '1', level: '1376', differential: 'a13_6,1_t * phi13_3,4_3,5_6,5_6,9 - phi13_6,1_6,7_8,7 * a12_s_1,5_7,5_7,9 - phi13_3,4_6,4_8,4 * a23_3,4_s_4,9 + a23_t_8,3 * phi13_3,4_3,5_3,9 - phi13_6,1_8,8 * a12_s_1,5_8,5_8,9 - phi13_6,1_8,1 * a12_s_1,5_1,9 + a13_s_8,7 * phi13_3,4_3,5_7,5_7,9 - phi13_6,1_8,1_8,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_7,5_7,9', source: '9', target: '7', degree: '1', level: '233', differential: '-1*a12_s_7,4 * a23_3,4_s_4,9', myLineStyle: 'dashed'} },
        { data: { id: 'a23_3,4_t_5,6_9,6', source: '6', target: '9', degree: '1', level: '54', differential: 'a13_5,1_t * a23_3,4_t_5,6 - a13_6,1_s_9,8 * a13_6,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_2,5_6,5_8,5_8,9', source: '9', target: '8', degree: '1', level: '458', differential: 'a13_6,1_t * phi12_2,4_2,5_6,5_6,9 - phi12_6,1_6,7_8,7 * a12_s_1,5_7,5_7,9 - phi12_6,1_8,8 * a12_s_1,5_8,5_8,9 - phi12_6,1_8,1 * a12_s_1,5_1,9 - phi12_2,4_6,4_8,4 * a23_3,4_s_4,9 - phi12_6,1_8,1_8,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'phi12_2,4_2,5_6,5_6,9', source: '9', target: '6', degree: '1', level: '455', differential: '-1*phi12_2,4_6,4 * a23_3,4_s_4,9 - phi12_6,1 * a12_s_1,5_1,9 - phi12_6,1_6,7 * a12_s_1,5_7,5_7,9 - phi12_6,1_6,8 * a12_s_1,5_8,5_8,9 - phi12_6,1_6,9 * a12_s_1,5_9,9', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_9,5', source: '5', target: '9', degree: '1', level: '242', differential: 'a13_s_9,7 * a12_s_1,5_7,5 + a13_6,1_s_9,8 * a12_s_1,5_8,5 - a12_s_9,4 * a23_3,4_s - a12_s_1,5_9,9 * a13_5,1_t', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_9,9', source: '9', target: '9', degree: '1', level: '241', differential: 'a13_s_9,7 * a12_s_1,5_7,5_7,9 + a13_6,1_s_9,8 * a12_s_1,5_8,5_8,9 - a12_s_9,4 * a23_3,4_s_4,9', myLineStyle: 'dashed'} },
        { data: { id: 'a12_s_1,5_1,9', source: '9', target: '1', degree: '1', level: '242', differential: '-1*a12_s * a23_3,4_s_4,9 + a13_s * a12_s_1,5_7,5_7,9 + a13_6,1_s * a12_s_1,5_8,5_8,9 + a13_5,1_s * a12_s_1,5_9,9', myLineStyle: 'dashed'} }
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

