//Initialize possible constant values on users functions
e = 2.718281;


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

function bisection_method()
	// Ask for required data
	disp("Type the function to evaluate with the following format:");
	disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., where a, b, c are constants");
	user_function = input("","string");
	xl            = input("xl value: ");
	xu            = input("xu value: ");
	max_error     = input("max error value in %")/100.0;

	//Initialize user function and required values
	deff('[y] = bisection(x)', user_function);
	output = ["iteration", "xl", "xu", "xm", "sign", "error"];
	disp(output);
	_error = 1;

	//First iteration
	iteration   = 1;
	xm          = (xl + xu)/2;
	is_positive = bisection(xl)*bisection(xm) > 0;

	if(is_positive) then 
	    _sign = "+";
	else
	    _sign = "-";
	end

	output = ["  " + string(iteration), string(xl), string(xu), string(xm), _sign, "---"];
	disp(output);

	//Next iterations
	while abs(_error) >= max_error then
	    iteration = iteration + 1;
	    prev_xm   = xm;

	    if(is_positive) then 
	        xl = prev_xm;
	    else
	        xu = prev_xm;
	    end

	    xm     = (xl + xu)/2;
	    is_positive  = bisection(xl)*bisection(xm) > 0;

	    if(is_positive) then 
	        _sign = "+";
	    else
	        _sign = "-";
	    end

	    _error = (xm - prev_xm)/xm;

	    //Display values
	    output = ["  " + string(iteration), string(xl), string(xu), string(xm), _sign, string(abs(_error)*100) + "%"];
	    disp(output);
	end
endfunction

function secant_method()
	// Ask for required data
	disp("Type the function to evaluate with the following format:");
	disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., where a, b, c are constants");
	user_function = input("","string");
	x0            = input("x0 value: ")
	x1            = input("x1 value: ")
	max_error     = input("max error value in %")/100.0;

	//Initialize user function and required values
	deff('[y] = secant(x)', user_function);
	_error    = 1;
	x2        = 0;
	iteration = 0;
	output = ["iteration", "xi-1", "xi", "f(xi-1)", "f(xi)", "xi+1", "error"];
	disp(output);

	//Iterations
	while abs(_error) >= max_error then
	    iteration = iteration + 1;
	    f_x0 = secant(x0);
	    f_x1 = secant(x1);
	    x2   = x1 - f_x1*(x1-x0)/(f_x1-f_x0);
	    _error = (x2 - x1)/x2;

	    //Display values
	    if(iteration <> 1) then
	        output = ["  " + string(iteration), string(x0), string(x1), string(f_x0), string(f_x1), string(x2), string(abs(_error)*100) + "%"];
	    else 
	        output = ["  " + string(iteration), string(x0), string(x1), string(f_x0), string(f_x1), string(x2), " --- "];
	    end;
	    
	    disp(output);
	    x0 = x1;
	    x1 = x2;
	end
endfunction

function newton_method()
	// Ask for required data
	disp("Type the function to evaluate with the following format:");
	disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., where a, b, c are constants");
	user_function = input("","string");
	x0            = input("x0 value: ")
	max_error     = input("max error value in % ")/100.0;

	//Initialize user function and required values
	deff('[y] = newton_raphson(x)', user_function);
	_error    = 1;
	output    = ["iteration", "xi", "f(xi)", "derivate f(xi)", "error"];
	disp(output);

	//First interation
	iteration = 1;
	f_x0       = newton_raphson(x0);
	deriv_f_x0 = numderivative(newton_raphson, x0);
	x1         = x0 - f_x0/deriv_f_x0;
	output     = ["  " + string(iteration), string(x0), string(f_x0), string(deriv_f_x0), " --- "];
	disp(output);

	//Next Iterations
	while abs(_error) >= max_error then
	    iteration  = iteration + 1;
	    prev_x0    = x0;
	    x0         = x1;
	    f_x0       = newton_raphson(x0);
	    deriv_f_x0 = numderivative(newton_raphson, x0);
	    x1         = x0 - f_x0/deriv_f_x0;
	    _error     = (x0 - prev_x0)/x0;

	    //Display values
	    output = ["  " + string(iteration), string(x0), string(f_x0), string(deriv_f_x0), string(abs(_error)*100) + "%"];
	    disp(output);
	end
endfunction

function start()
    selected_method = display_menu();
    
    while selected_method <> 5 & selected_method <> 1 & selected_method <> 2 & selected_method <> 3 & selected_method <> 4 then 
        disp("Invalid input, please try again");        
        selected_method = display_menu();
    end;
    
    if selected_method == 1 then
		disp("Executing Bisection Method");
		bisection_method();
	elseif selected_method == 2 then
		disp("Executing Secant Method");
		secant_method();
	elseif selected_method == 3 then
		disp("Executing Newthon-Raphson Method")
		newton_method();
	elseif selected_method == 4 then
		disp('Executing Bairstow Method');
	elseif selected_method == 5 then
		disp("Ending program");
	end;
end;
endfunction;