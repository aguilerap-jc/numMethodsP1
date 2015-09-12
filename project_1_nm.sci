function index_menu = display_menu()
    disp("Select one of the following methods:");
	disp("1) Bisection Method");
	disp("2) Secant Method");
	disp("3) Newthon-Raphson Method");
	disp("4) Bairstow Method")
	disp("5) For going out of the program");
	disp("");

    index_menu = input("Type the number of the numeric method you want to use: ");
endfunction;

function start()
    selected_method = display_menu();
    
    while selected_method <> 5 & selected_method <> 1 & selected_method <> 2 & selected_method <> 3 & selected_method <> 4 then 
            disp("Invalid input, please try again");        
            selected_method = display_menu();
    end;
    
    if selected_method == 1 then
		disp("Executing Bisection Method");
		//exec ("bisectionM.sce")
	elseif selected_method == 2 then
		disp("Executing Secant Method");
		//exec("secantMethod.sce")
	elseif selected_method == 3 then
		disp("Executing Newthon-Raphson Method")
		//exec ("newthonsM.sce");
	elseif selected_method == 4 then
		disp('Executing Bairstow Method');
	elseif selected_method == 5 then
		disp("Ending program");
end;

endfunction;
