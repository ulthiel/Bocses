#Bocses  
A [Magma](http://magma.maths.usyd.edu.au) package for computing with [bocses](https://arxiv.org/abs/1601.03899).  
By [Julian Külshammer](http://www.iaz.uni-stuttgart.de/LstAGeoAlg/Kuelshammer/) and [Ulrich Thiel](http://www.mathematik.uni-stuttgart.de/~thiel/).


##Prerequisites
You need [Magma](http://magma.maths.usyd.edu.au) version at least 2.19. To draw bocses, you also need [Graphviz](http://www.graphviz.org/Download..php).

##Downloading and running
You can download the latest version as a zip archive [here](https://bitbucket.org/ulthiel/bocses/downloads). Then just run ```sh Bocses.sh```.

##Example 1
We create the following bocs.

![](Example1.png)

```python
//Create the bocs (differential biquiver) with 6 edges.
//Edge labels are passed as list at the beginning in
//the same order as the successive list of tuples defining
//the edges. The edge labels can be used to define the
//differentials later.
B<a12,a23,a13,phi12,phi23,phi13>:=Bocs([<1,2>,<2,3>, <1,3>, <1,2>,<2,3>,<1,3>] : Title:="Example1"); 

//Set edge degrees
B`EdgeDegrees["phi12"] :=1;
B`EdgeDegrees["phi23"] :=1;
B`EdgeDegrees["phi13"] :=1;

//Set edge levels
B`EdgeLevels["phi13"] :=2;
B`EdgeLevels["a13"] :=2;

//Set edge differentials
B`EdgeDifferentials["a13"]:=phi23*a12;

//Draw the bocs (needs Graphviz)
//SVG file is copied to Output directory
//and opened automatically.
Draw(B);

//Do reduction
Bred := Reduction(B);

//Silently draw each reduction step and put in 
//output directory (this will take longer)
Bred := Reduction(B : DrawAll:=true);
```