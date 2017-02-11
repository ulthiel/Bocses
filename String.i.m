/*
	Bocses - A Magma package for computing with bocses.
	
	By 
	
	Julian Külshammer (julian.kuelshammer@mathematik.uni-stuttgart.de)
	
	and 
	
	Ulrich Thiel (thiel@mathematik.uni-stuttgart.de)
	
	File: String.i.m

*/

//=============================================================================
intrinsic Replace(str::MonStgElt, reg::MonStgElt, rep::MonStgElt) -> MonStgElt
/*
    Intrinsic: Replace
    
    Declaration:
        :intrinsic Replace(str::MonStgElt, reg::MonStgElt, rep::MonStgElt) -> MonStgElt
 
    Description:
        Replaces all occurences of the regular expression +reg+ by +rep+ in the string +str+.

*/
{Replaces all occurences of the regular expression reg by rep in the string str.}

	newstr := "";
	while true do
		t,m := Regexp(reg,str);
		if t eq false then
			return newstr*str;
		else
			N := Position(str,m);
			newstr *:= str[1..N-1]*rep;
			str := str[N+#m..#str];
		end if;
	end while;
		
end intrinsic;
