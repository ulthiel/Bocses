#Bocses  
A [Magma](http://magma.maths.usyd.edu.au) package for computing with [bocses](https://arxiv.org/abs/1601.03899).  
By [Julian Külshammer](http://www.iaz.uni-stuttgart.de/LstAGeoAlg/Kuelshammer/) and [Ulrich Thiel](http://www.mathematik.uni-stuttgart.de/~thiel/).


##Prerequisites
You need [Magma](http://magma.maths.usyd.edu.au) version at least 2.19. 

##Downloading and running
You can download the latest version as a zip archive [here](https://bitbucket.org/ulthiel/bocses/downloads). Then just run ```./Bocses.sh```.

##Example 1
Below is an example of a bocs as an interactive graph (click [here](Doc/Example1.html) for a full screen view). You can zoom in, move around, move the nodes. A click on an edge reveals extra information. Let's create this bocs.

<iframe src="http://www.mathematik.uni-stuttgart.de/~thiel/Bocses/Doc/Example1.html", frameborder="0", width="350", height="350", scrolling="no", align="center"></iframe>  

```text
//First, create the underlying quiver of the bocs.
//Edge labels are passed as list at the beginning in
//the same order as the successive list of tuples defining
//the edges. The edge labels can be used to define the
//differentials later.
B<a12,a23,a13,phi12,phi23,phi13>:=Bocs([1,2,3], \
[<1,2>,<2,3>, <1,3>,<1,2>,<2,3>,<1,3>] : Title:="Example1"); 

//Set non-zero edge degrees
B`EdgeDegrees["phi12"] :=1;
B`EdgeDegrees["phi23"] :=1;
B`EdgeDegrees["phi13"] :=1;

//Set non-zero edge levels
B`EdgeLevels["phi13"] :=2;
B`EdgeLevels["a13"] :=2;

//Set non-zero edge differentials
B`EdgeDifferentials["a13"]:=phi23*a12;

//Draw the bocs.
//This creates an HTML file in the directory "Output/Example 1"
//which is opened automatically. It contains an interactive graph
//like above.
Draw(B);

//Do reduction
Bred := Reduction(B);

//Silently draw each reduction step and put in 
//output directory.
Bred := Reduction(B : DrawAll:=true);
```

The reduction looks as follows (click [here](Doc/Reduction of Example1.html) for a full screen view):

<iframe src="Doc/Reduction of Example1.html", frameborder="0", width="400", height="400", scrolling="no", align="center"></iframe>


##Example2

In this example we do a reduction of the bocs below at a specific dimension vector. The result is a whole list of bocses, each bocs representing one step in the reduction process.

<iframe src="Doc/Example2.html", frameborder="0", width="400", height="400", scrolling="no", align="center"></iframe>

```text
B<a1,a2,a3,a4,a6,a5,a7,a8,b3,b4,b6,b5,b7,c4,c6,phi4,phi6,phi7,\
phi9,phi10,psi6,psi9> := Bocs([1,2,3,4,5,6,7,8,9,10,11],\
[<1,2>,<2,3>,<3,4>,<4,6>,<6,9>,<5,7>,<7,10>,<8,11>,<3,5>,\
<4,7>,<6,10>,<5,8>,<7,11>,<4,8>,<6,11>,<4,5>,<6,7>,<7,8>,\
<9,10>,<10,11>,<6,8>,<9,11>] : Title:="Example2");

B`EdgeDegrees["phi4"] := 1;
B`EdgeDegrees["phi6"] := 1;
B`EdgeDegrees["phi9"] := 1;
B`EdgeDegrees["phi7"] := 1;
B`EdgeDegrees["phi10"] := 1;
B`EdgeDegrees["psi6"] := 1;
B`EdgeDegrees["psi9"] := 1;
B`EdgeDegrees["phi10"] := 1;

B`EdgeLevels["b3"] := 2;
B`EdgeLevels["b4"] := 2;
B`EdgeLevels["b6"] := 2;
B`EdgeLevels["b5"] := 2;
B`EdgeLevels["b7"] := 2;
B`EdgeLevels["psi6"] := 2;
B`EdgeLevels["psi9"] := 2;
B`EdgeLevels["c4"] := 3;
B`EdgeLevels["c6"] := 3;

B`EdgeDifferentials["b3"] := phi4*a3;
B`EdgeDifferentials["b4"] := phi6*a4-a5*phi4;
B`EdgeDifferentials["b6"] := phi9*a6-a7*phi6;
B`EdgeDifferentials["b5"] := phi7*a5;
B`EdgeDifferentials["b7"] := phi10*a7-a8*phi7;
B`EdgeDifferentials["c4"] := phi7*b4-b5*phi4+psi6*a4;
B`EdgeDifferentials["c6"] := phi10*b6-b7*phi6+psi9*a6-a8*psi6;
B`EdgeDifferentials["psi6"] := phi7*phi6;
B`EdgeDifferentials["psi9"] := phi10*phi9;

Bred := Reduction(B, [ 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1 ]);
```

