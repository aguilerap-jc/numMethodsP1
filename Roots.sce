//Initialize possible constant values on users functions
e = 2.718281;

function index_menu = display_menu()
    disp("Select one of the following methods:");
	disp("1) Roots Methods");
	disp("2) Non Linear Methods");
    index_menu = input("Type the number of the numeric method you want to use: ");
endfunction;

function index_sub_menu_roots = display_menu_roots()
    disp("Select one of the following methods:");
	disp("1) Bisection Method");
	disp("2) Secant Method");
	disp("3) Newthon-Raphson Method");
	disp("4) Bairstow Method");
	disp("0) For going out of the program");
	disp("");

    index_sub_menu_roots = input("Type the number of the numeric method you want to use: ");
endfunction;

function index_sub_menu_non_linear = display_menu_non_linear()
    disp("Select one of the following methods:");
	disp("1) Gauss Elimination With Partial Pivoting");
	disp("2) Gauss Jordan");
	disp("3) LU Decomposition");
	disp("4) Gauss Seidel");
	disp("5) Newton´s for Non Linear Equation");
	disp("0) For going out of the program");
	disp("");

    index_sub_menu_non_linear = input("Type the number of the numeric method you want to use: ");
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

	ri = xl-3:0.01:xu+3;
	plot(ri,bisection(ri));
	plot(xm,bisection(xm),'o')
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

	ri = x0-3:0.01:x1+3;
	plot2d(ri,secant(ri));
	plot(x1,0,'o');
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
	iteration  = 1;
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

	ri = x0-3:0.01:x0+3;
	plot(ri,newton_raphson(ri));
	plot(x1,0,'o');
endfunction

function bairstow_method()
    // Ask for required data
    disp("Type the coefficients of the polynomial in a decreasing order of the function degree :");
    disp("[1, 2, 3, 4] means 1*x^3 + 2*x^2 + 3*x^1 + 4*x^0");
    a_values  = input("");
    r0        = input("r0 value: ");
    s0        = input("s0 value: ");
    max_error = input("max error value in % ")/100.0;

    //Process data
    b_values             = a_values;
    c_values             = a_values;
    [matrix_x, matrix_y] = size(a_values);
    _error               = 1;
    iteration            = 1;
    r1 = r0;
    s1 = s0;

    while abs(_error) >= max_error then
        output = ["iteration", "initial r", "initial s"];
	    disp(output);
	    output = ["    ", string(iteration), string(r0), string(s0)];
	    disp(output);
	    output = ["    ", "  a  ", "  b  ", "  c  "];
	    disp(output);
	    b_values(2) = a_values(2) + r0*b_values(1);
	    c_values(2) = b_values(2) + r0*c_values(1);

        //Display n a,b, c values
        output = ["  _1_  ", string(a_values(1)), string(b_values(1)), string(c_values(1))];
        disp(output);
        //Display n-1 a,b,c values
        output = ["  _2_  ", string(a_values(2)), string(b_values(2)), string(c_values(2))];
        disp(output);

        for i = 3:matrix_y,
            b_values(i) = a_values(i) + r0*b_values(i-1) + s0*b_values(i-2);
            c_values(i) = b_values(i) + r0*c_values(i-1) + s0*c_values(i-2);
            output = ["  _" + string(i) + "_  ", string(a_values(i)), string(b_values(i)), string(c_values(i))];
            disp(output);
        end

        b0       = b_values(matrix_y);
        b1       = b_values(matrix_y - 1);
        c1       = c_values(matrix_y - 1);
        c2       = c_values(matrix_y - 2);
        c3       = c_values(matrix_y - 3);
        delta_r  = (-b0/c1 + c2*b1/(c1*c3))/(1-(c2^2)/(c1*c3))
        delta_s  = (-b0-c1*delta_r)/c2;
        r1       = r0 + delta_r;
        s1       = s0 + delta_s;
        _error_r = (r1-r0)/r1;
        _error_s = (s1-s0)/s1;

        if(abs(_error_r) > abs(_error_s)) then
            _error = _error_r;
        else 
            _error = _error_s;
        end

        output = ["  ", "  delta r  ", "  delta s  ", "  r  ", "  s  ", "error r", "error s"];
        disp(output);
        output = ["    ", string(delta_r), string(delta_s), string(r1), string(s1), string(_error_r*100) + "%", string(_error_s*100) + "%"];
        disp(output)
        iteration = iteration + 1;
        r0 = r1;
        s0 = s1;
    end

    root_1 = r1/2 + sqrt(r1^2+4*s1)/2;
    root_2 = r1/2 - sqrt(r1^2+4*s1)/2;
    output = "Root values";
    disp(output);
    disp(root_1);
    disp(root_2);
endfunction

function Partial_Pivoting_Method()
    //Partial Pivoting Method
	disp("Partial_Pivoting_Method Function Executing");
	matrix_A = input("Define matrix A");
	matrix_B = input("Define matrix B");
    n   = size(matrix_A, "r");
	for i=1: n
		actual_row_A = matrix_A(i,:);
		value_1_A = matrix_A(i,i);
		actual_row_B = matrix_B(i,:);
		for j=i+1: n
			next_row_A = matrix_A(j, :);
			value_2_A = matrix_A(j,i);
			matrix_A(j, :) = next_row_A - actual_row_A*value_2_A/value_1_A;
			next_row_B = matrix_B(j, :);
			matrix_B(j, :) = next_row_B - actual_row_B*value_2_A/value_1_A;
		end
	end

	matrix_B(3) = matrix_B(3) /matrix_A(3,3)
    matrix_B(2) = (matrix_B(2) - matrix_A(2,3) * matrix_B(3)) / matrix_A(2,2)
    matrix_B(1) = (matrix_B(1) - matrix_A(1,2) * matrix_B(2) -  matrix_A(1,3) * matrix_B(3)) / matrix_A(1,1)
    disp("La solución para x es:")
	disp(matrix_B);
//Partial_Pivotin_method
endfunction


function Gauss_Jordan_Method()
//Gauss Jordan Method
	disp("Gauss_Jordan_Method Function Executing");
	disp("Type the function to evaluate with the following format:");
	maxIterations = input("Set the max number of iterations ");
	expectedError = input("Set the expected error you want (on porcentage) ");
	matrix_A = input("Define matrix A");
	matrix_B = input("Define matrix B");
	n = size(matrix_A, "r");

	for i=1: n
		actual_row_A = matrix_A(i,:);
		value_1_A = matrix_A(i,i);
		actual_row_B = matrix_B(i,:);

		for j=i+1: n
			next_row_A = matrix_A(j, :);
			value_2_A  = matrix_A(j,i);
			matrix_A(j, :) = next_row_A - actual_row_A*value_2_A/value_1_A;
			next_row_B = matrix_B(j, :);
			matrix_B(j, :) = next_row_B - actual_row_B*value_2_A/value_1_A;
		end

		matrix_A(i, :) = actual_row_A/actual_row_A(i);
        matrix_B(i, :) = actual_row_B/actual_row_A(i);
	end

    for i=n:-1:1
		actual_row_A = matrix_A(i,:);
		value_1_A    = matrix_A(i,i);
		actual_row_B = matrix_B(i,:);

		for j=i-1:-1:1
			next_row_A = matrix_A(j, :);
			value_2_A = matrix_A(j,i);
			matrix_A(j, :) = next_row_A - actual_row_A*value_2_A/value_1_A;
			next_row_B = matrix_B(j, :);
			matrix_B(j, :) = next_row_B - actual_row_B*value_2_A/value_1_A;
		end
	end

	disp("La solución para x es:")
	disp(matrix_B);
endfunction

function LU_Decomposition()
//LU Decomposition
	disp("LU_Decomposition Function Executing");
    //Definir Matriz A
	matrix_A = input("Define matrix A ");
	//Definir Matriz B
	matrix_B = input("Define matrix B ");
	matrix_AO = matrix_A;
	matrix_BO = matrix_B;
	//n = Renglones
	n   = size(matrix_A, "r");
	[renglon,columna] = size(matrix_A);
    //Definir matriz L con 0
    matrix_L = zeros(renglon,columna);
    //Definir matriz U con 0
    matrix_U = zeros(renglon,columna);
    matrix_X = ones(n);
    matrix_Z = ones(n);
    matrix_Temp = ones(n);
    for i = 1 : n
    	matrix_L(i,i) = 1;
    end
    for i=1: n
		//Sacar el i renglon de la matriz A
		actual_row_A = matrix_A(i,:);
		//Obtener el primer cada uno de los valores de la matriz
		value_1_A = matrix_A(i,i);
		//Sacar el i renglon de B
		actual_row_B = matrix_B(i,:);
		//Asigna los valores de la matriz U de la diagonal
		matrix_U(i,i) = value_1_A;
		for j = i+1 : n
            //Sacar el segundo renglon de A
			next_row_A = matrix_A(j, :);
			value_2_A = matrix_A(j,i);
			matrix_A(j, :) = next_row_A - actual_row_A*value_2_A/value_1_A;
			next_row_B = matrix_B(j, :);
			matrix_B(j, :) = next_row_B - actual_row_B*value_2_A/value_1_A;
			matrix_L(j,i) = value_2_A/value_1_A;
		end
	end
	matrix_U = matrix_A;

    for i=n :-1 : 1
		actual_row_A = matrix_A(i,:);
		value_1_A = matrix_A(i,i);
		actual_row_B = matrix_B(i,:);

		for j=i-1:-1:1
			next_row_A = matrix_A(j, :);
			value_2_A = matrix_A(j,i);
			matrix_A(j, :) = next_row_A - actual_row_A*value_2_A/value_1_A;
			next_row_B = matrix_B(j, :);
			matrix_B(j, :) = next_row_B - actual_row_B*value_2_A/value_1_A;
		end
	end
	matrix_Z(1) = matrix_BO(1);
	for i = 2 : n
		matrix_Z(i) = matrix_BO(i)
		for j = i-1 :-1 : 1
			matrix_Z(i)=matrix_Z(i)-matrix_L(i,j)*matrix_Z(j);
		end
	end

	for i = n : -1	: 1
		matrix_X(i) = matrix_Z(i);
		for j = i+1 : n
			matrix_X(i)=matrix_X(i)-matrix_U(i,j)*matrix_X(j);
		end
		matrix_X(i) = matrix_X(i)/matrix_U(i,i);
	end
	disp("A matrix");
	disp(matrix_AO);
	disp("B matrix");
	disp(matrix_BO);
	disp("L matrix");
	disp(matrix_L);
	disp("Z values");
	disp(matrix_Z);
	disp("U matrix");
	disp(matrix_U);
	disp("X values");
	disp(matrix_X);
endfunction

function Gauss_Seidel()
	disp("Gauss_Seidel Function Executing ...");
	disp("In vector format {x1,x2,x3,x4,...,xn}")
	//ask for the initial values of the X values
	_new = input("Initial values for you X :")
	disp("introduce the constants of each equation in matrix style ")
	disp("  Array{A,B,C;D,E,F;G,H,I}")
  matrixA = input("Matrix A : ");
	//get the size of the matrix
	_size = size (matrixA, "r")
	//ask for the equation in vector format
	disp("introduce the other side of the equaility")
	disp("  Array{A;B;C}")
	matrixB = input("Matrix B : ");
	_error = input("max error value in % ")/100.0;
	//flag to detect that the error is less than the maxError
	maxError = _error + 1
	actualError = zeros(_size,1)
	//flag to detect non Diagonal Dominant Matrix
	flagNonDiagonal = 0
	//variable to save the sum of each row
	totalInLine = zeros(_size,1)
	//array of new and old values of all X variables i.e x1,x2..xn
	_old = zeros(_size, 1)
	iteration = 1

	//verify that the matrix is Diagonally dominant
	for i = 1 : _size	
			for j = 1 : _size
					if j <> i then
							totalInLine(i) = totalInLine(i) + matrixA(i,j)
					end
			end
			if matrixA(i,i) < totalInLine(i) then
					flagNonDiagonal = 1
			end
	end
	//if its diagonal dominat proceed
	if flagNonDiagonal == 0 then
		//do the procedure until reaching a maxError value that is less than the set error
		while maxError > _error 
				for i = 1 : _size
						//save the value of to get the error value
						_old(i) = _new(i)
						tmpX = 0
						//sum of all values in row that are not in the main diagonal
						//and multiply each of them by their corresponding X value
						for j = 1 : _size
								if j <> i then
										tmpX = tmpX + _new(j) * matrixA(i,j)		
								end
						end
						//get the newest value for the X that we are trying to find
						_new(i) = (matrixB(i) - tmpX) / matrixA(i,i)
						//get the error 
						actualError(i) = abs((_new(i) - _old(i)) / _new(i)) 
						if(i == 1) then
							maxError = actualError(i)
						end
				end
				//verify if this round got the maxError
				if(actualError(i) > maxError) then
						maxError = actualError(i)
				end	
				//output setting
				sizeOfMatrixOutput = (_size + _size + 1)
				output = zeros(1,sizeOfMatrixOutput)
				output(1,1) = iteration 
				for k = 2 : sizeOfMatrixOutput 
						if k < (_size + 2) then
								//write the value of X
								output(1,k) = _new(k - 1)
						else
								//write the values of the errors
								posOfError = (k-_size-1)
								output(1,k) = actualError(posOfError) * 100	
						end
				end
				disp("| Iter | values of X {x1 .. xn} | Error {E1 .. En |}")
				disp(output)
				iteration = iteration + 1
		end
	else 
    disp("not a Diagonally dominant matrix1")
	end
endfunction

function start()
    selected_menu = display_menu();

    if selected_menu == 1 then
		disp("Roots Menu");
		selected_method = display_menu_roots();
		
		while selected_method <> 5 & selected_method <> 1 & selected_method <> 2 & selected_method <> 3 & selected_method <> 4 then 
		    disp("Invalid input, please try again");        
		    selected_method = display_menu_roots();
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
			bairstow_method();
		elseif selected_method == 5 then
			disp("Ending program");
		end;

	elseif selected_menu == 2 then
		disp("Non Linear Menu");
		selected_method = display_menu_non_linear();
		
		while selected_method <> 5 & selected_method <> 1 & selected_method <> 2 & selected_method <> 3 & selected_method <> 4 then 
		    disp("Invalid input, please try again");        
		    selected_method = display_menu_non_linear();
		end;
		    
		if selected_method == 1 then
			disp("Gauss Elimination With Partial Pivoting Method");
			Partial_Pivoting_Method();
		elseif selected_method == 2 then
			disp("Gauss Jordan Method");
			Gauss_Jordan_Method();
		elseif selected_method == 3 then
			disp("LU Decomposition Method")
			LU_Decomposition();
		elseif selected_method == 4 then
			disp('Gauss Seidel Method');
			Gauss_Seidel();
		elseif selected_method == 0 then
			disp("Ending program");
		end;
	end;
endfunction;

//la de arriba se resta
