/*
    CHAMP (CHerednik Algebra Magma Package)
    Copyright (C) 2013–2015 Ulrich Thiel
    Licensed under GNU GPLv3, see COPYING.
    thiel@mathematik.uni-stuttgart.de
*/

/*
    File: String.i.m
    
    Simple extensions for string operations
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
