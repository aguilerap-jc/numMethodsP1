
k=1

while k==1 
	disp("Select one of the following methods:");
	disp("1) Bisection Method");
	disp("2) Secant Method");
	disp("3) Newthon-Raphson Method");
	disp("4) Bairstow Method")
	disp("5) For going out of the program press 0");
	disp('');
	m = input("Insert the number of the method you want to use:")

	if m == 1 then
		disp("Executing Bisection Method");
		exec ("bisectionM.sce")
	elseif m == 2 then
		disp("Executing Secant Method");
		exec("secantMethod.sce")
	elseif m == 3 then
		disp("Executing Newthon-Raphson Method")
		exec ("newthonsM.sce");
	elseif m == 4 then
		disp('Executing Bairstow Method');
	elseif m == 5 then
		disp("Ending program")
		k = 0;
	else disp('There is no method for that option');	
	end
end