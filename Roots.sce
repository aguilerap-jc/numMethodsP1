//Initialize possible constant values on users functions
e = 2.718281;

function index_menu = display_menu()
    disp("Select one of the following methods:");
	disp("1) Roots Methods");
	disp("2) Non Linear Methods");
	disp("3) Linear Regression Method ")
	disp("4) Interpolation Direct Method")
	disp("5) Integration Trapezoidal")
	disp("6) Integration Roomberg")
    index_menu = input("Type the number of the numeric method you want to use: ");
    funcprot(0);
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

function index_submenu_non_linear = display_menu_non_linear()
    disp("Select one of the following methods:");
	disp("1) Gauss Elimination With Partial Pivoting");
	disp("2) Gauss Jordan");
	disp("3) LU Decomposition");
	disp("4) Gauss Seidel");
	disp("0) For going out of the program");
	disp("");

    index_submenu_non_linear = input("Type the number of the numeric method you want to use: ");
endfunction;

function Index_Integration = display_menu_Integration()
	disp("Choose how do you want to type the Integration_Method");
	disp("1) Enter the function to evaluate");
	disp("2) Enther the values of the segments");
	Index_Integration = input("Type how you want to enter the values for the Integration_Method: ");
endfunction

function Index_Romberg = display_menu_Romberg()
	disp("Choose how do you want to type the Romberg_Method");
	disp("1) Enter the  number of Iterations");
	disp("2) Enther the minimum expected error");
	Index_Romberg = input("Type how you want to enter the values for the Integration_Method: ");
endfunction

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

	//Now that we have the lower part with 0's, we must do the needed operations. starting from the bottom. 
	for i = n : -1	: 1;
		for j = i+1 : n
			matrix_B(i) = matrix_B(i)-matrix_A(i,j)*matrix_B(j);
		end
		matrix_B(i) = matrix_B(i)/matrix_A(i,i);
	end

    disp("The solution for x is:")
	disp(matrix_B);
	//Partial_Pivotin_method
endfunction

function Gauss_Jordan_Method()
	//Gauss Jordan Method
	disp("Gauss_Jordan_Method Function Executing");
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

	//Now that we have the lower part with zeros and the diagonal with 1s we must reduce the upper part and substract rows beginning from the bottom
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
	disp("For example: {A,B,C;D,E,F;G,H,I} representig a [3x3] matrix")
    matrixA = input("Matrix A : ");
	//get the size of the matrix
	_size = size (matrixA, "r")
	//ask for the equation in vector format
	disp("introduce the other side of the equaility")
	disp("For example: {A;B;C} for a matrix[1x3]")
	matrixB = input("Matrix B : ");
	_error = input("max error value in % ")/100.0;
	max_iterations = input("insert the max number of iterations");
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
		while maxError > _error & iteration <= max_iterations then 
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
    disp("Could not proceed with the method, The main matrix is not Diagonally dominant");
	end
endfunction

function Linear_Regression_Method()
	disp("Executing Linear_Regression_Method");
	matrix_data = input("Insert a matrix of two columns, the first one for x values and the other one for y values. The number of rows is equal to the number of data points");

	//Initialize the needed variables
	sum_xy       = 0;
	sum_x        = 0;
	sum_y        = 0;
	sum_square_x = 0;
	n            = size(matrix_data, "r");
	a1           = 0;
	a0           = 0;

	for i = 1 : n
		sum_x        = sum_x + matrix_data(i,1);
		sum_y        = sum_y + matrix_data(i,2);
		sum_xy       = sum_xy + matrix_data(i,1) * matrix_data(i,2);
		sum_square_x = sum_square_x + matrix_data(i,1) * matrix_data(i,1);
		plot(matrix_data(i,1), matrix_data(i,2), "ro");

	end

	a1 = (n * sum_xy - sum_x * sum_y) / (n * sum_square_x - sum_x * sum_x);
	a0 = sum_y/n - a1 * sum_x/n;

	y_data = zeros(1,n);

	for i = 1 : n
		y_data(i) = matrix_data(i,1)*a1 + a0;
	end

	plot(matrix_data(:,1),y_data);
	disp("The result for a1 is ");
	disp(a1);
	disp("The result for a0 is ");
	disp(a0);
endfunction

function Interpolation_Direct_Method()
	disp("Executing Interpolation_DirectM");
	disp("Type your table in matrix 2xN {1,2;3,4;5,6;7,8;9,10}")

	matrixA = input("insert you table : ")
	numOfRows = size (matrixA, "r")

	disp("MAX VALUE to chose " + string(matrixA(numOfRows,1)) + ", MIN VALUE to chose " + string(matrixA(1,1)))
	valueToFind = input("Introduce the value you want to find : ")

	order = input("Introduce the order you want to use, MAX ORDER = " + string(numOfRows - 1) + " : ")
	nearestValue = abs(matrixA(1,1) - valueToFind)
	nearestValuePos = 1

	//extend 1 column matrix A to save wich are the neares values
	matrixA = cat(2, matrixA, zeros (numOfRows, 1))
	matrixA(1,3) = nearestValue

	//finding the neareast values	
	for i = 2 : numOfRows
		//get values from the x axis
	  	value = matrixA(i,1) - valueToFind 
		matrixA(i,3) = value
		//compare them and try to find wich one is the closest to the value we want to find
		if abs(value) < nearestValue then
		  	nearestValue = abs(value)
			nearestValuePos = i
		end
	end
	//sort values in order to get the neareast values
	[sortedNeareastValues, originalPos] = gsort(abs(matrixA(:,3)),'g' ,'i')

	sizeOfsolveMatrix = order + 1
	coefficients = zeros(sizeOfsolveMatrix, 1) 
	b = zeros (sizeOfsolveMatrix, 1)
	solveMatrix = zeros (sizeOfsolveMatrix, sizeOfsolveMatrix)
	
	//get the coefficients of the polynomials
	for rowInCoefficients = 1 : sizeOfsolveMatrix
		
	  	coefficients(rowInCoefficients) = matrixA(originalPos(rowInCoefficients), 1) 
		b(rowInCoefficients) =  matrixA(originalPos(rowInCoefficients), 2)
		maxColumns = order + 1

		for columns = 2 : maxColumns

			exponent = columns - 1 
			//coefficientes in column 1 will always be 1
			solveMatrix(rowInCoefficients, 1) = 1
			solveMatrix(rowInCoefficients, columns) = coefficients(rowInCoefficients)^(exponent)
		end
			
	end

	//solve the matrix
	x0 = inv(solveMatrix) * b
	//display value of the coefficientes of the polynomial
	disp("Coefficientes for the polynomial")
	for l = 1 : sizeOfsolveMatrix
		disp("a" + string(l) + " = " + string(x0(l)))
	end

	rowInx0 = rowInCoefficients
	total = 0
	//get the value of the function after the substitution of the value that we want to find
	for rowInx0 = 1 : sizeOfsolveMatrix
	  	exponent = rowInx0 - 1
	  	total = total + ( x0(rowInx0) * valueToFind^exponent)
	end
	
	//plot the equation
		x = matrixA(:,1)
		stringToDisplay = sprintf("X: %d, Y: %d", valueToFind, total);
    	xstring( valueToFind, total, stringToDisplay );
		plot(x, matrixA(:,2))
	//plot the point we find where its X = valueToFind and Y = total
		plot(valueToFind, total, 'o')
	//display the value
	disp("value of the function evaluated ")
	disp(total)

endfunction

function Integration_Trapezoidal()
	disp("Executing Integration_Trapezoidal");
	sel_menu = display_menu_Integration();
	if sel_menu == 1 then
		disp("Type the function to evaluate with the following format:");
		disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., where a, b, c are constants");
		user_function = input("","string");
		deff('[y] = ffunction(x)', user_function);
		lower_lim = input("Insert the lower limit of the Integral : ");
	   	upper_lim = input("Insert the upper limit of the Integral : ");
	   	n_segments= input("Insert the number of segments :");
	   	integral_range = upper_lim - lower_lim;
	   	h = integral_range/n_segments;
	   	// I = (b-a)/(2*n) {sumation functions} 
	   	formula_h = h/2;  //formula_h = (b-a)/(2*n) 
	   	acum_function = 0;
	   	primerValorPol = 0;
	   	nValorPol = 0;
	   	sumation_functions = 0;
	   	
	   	for j = lower_lim : h : upper_lim
		   			acum_function = acum_function + ffunction(j);
		   	if j == lower_lim then
		   		primerValorPol = acum_function;
		   	//Guarda el valor de la funcion en el n valor
		   	elseif  j == upper_lim then
		   		nValorPol = acum_function;
		   	//Guarda el valor de las funciones intermedias	
		   	else 
		   		sumation_functions = sumation_functions + acum_function;
		   	end
		   	acum_function = 0;
		end

		final_result = formula_h *(primerValorPol+(2*sumation_functions)+nValorPol);
		disp("Solution is");
		disp(final_result);
		//plot
		x_values = lower_lim:.1:upper_lim
		x_values2 = lower_lim:h:upper_lim
		plot(x_values, ffunction)
		plot(x_values2, ffunction, '--')

		//Linea 44
	elseif sel_menu == 2 then
		//n_segments= input("Insert the number of segments :");
	    x_values  = input("Enter the X segments as following [1,2,3,...,n] :  ");
	    y_values  = input("Enter the Y segments as following [1,2,3,...,n] :  ");
	   	[x,n_segments] = size(x_values);
	   	if size(x_values) <> size(y_values) then
	   		disp("The segments of X are different that segments of Y Insert them again please");
	   	elseif (size(x_values) == size(y_values)) then
			lower_X_lim = x_values(1,1);
			upper_X_lim = x_values(1,n_segments);
			lower_Y_lim = y_values(1,1);
		   	upper_Y_lim = y_values(1,n_segments);
		   	funct_h = (upper_X_lim - lower_X_lim)/(n_segments*2);
		   	sumation_middle_values = 0;
	   		for i = 2 : n_segments - 1
	   			sumation_middle_values = sumation_middle_values + y_values(1,i);
	   		end
	   	
	   		final_result = funct_h * (lower_Y_lim + sumation_middle_values*2 + upper_Y_lim);

	   		disp("The result is");
	   		disp(final_result);
			plot(x_values, y_values)

	   		//disp(upper_Y_lim,sumation_middle_values,lower_Y_lim);
	   		//disp(funct_h);
	    else disp("Not a Correct Input");
	   	end
	else disp("Not a Correct Input");
	end
endfunction

function Integration_Romberg()
	//disp("Executing Integration_Trapezoidal");
	//sel_menu = display_menu_Integration();
	//if sel_menu == 1 then
		disp("Type the function to evaluate with the following format:");
		disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., where a, b, c are constants");
		user_function = input("","string");
		deff('[y] = ffunction(x)', user_function);
		lower_lim = input("Insert the lower limit of the Integral : ");
	   	upper_lim = input("Insert the upper limit of the Integral : ");
	   	iterations = input("Enter the number of Iterations : ");
	   	h_vector = zeros(iterations);
	   	i_matrix = zeros(iterations,iterations);
	   	prev_r_values = zeros(iterations);
	   	errors = zeros(iterations);

	   	for j = 1 : iterations
		   	cont_r_values = 0;
		   	h = upper_lim -lower_lim;
	   		if j == 1 then
		   		h_vector(1) = upper_lim - lower_lim;
		   	else 
		   		h_vector(j) = h_vector(j-1)/2
		   	end

		   	for i = 1 : iterations
				if i == 1 then
					   	acum_function = 0;
					   	primerValor = 0;
					   	nValor = 0;
					   	sumation_functions = 0;
					   	segments = 0;
					   	segments = (upper_lim - lower_lim) / h_vector(j);

					   	for r = lower_lim : h_vector(j) : upper_lim
					   	   			acum_function = acum_function + ffunction(r);
						   	if r == lower_lim then
						   		primerValor = acum_function;
						   	elseif  r == upper_lim then
						   		nValor = acum_function;
						   	else 
						   		sumation_functions = sumation_functions + acum_function;
							end
							   	acum_function = 0;
								cont_r_values = cont_r_values +1;
						end
						final_result = (h/(2*segments)) * (primerValor+(2*sumation_functions)+nValor);	
						i_matrix(j,i) = final_result;
						i_results(j) = i_matrix(j,i);
				else	
					if j <> 1 & i <= j then
						i_matrix(j,i) = (((4*(i-1))*(i_matrix(j,i-1))) - i_matrix(j-1,i-1))/ (4*(i-1)-1);
						i_results(j) = i_matrix(j,i);
					end
				end   		
		   	end
		   	if j > 1 then
		  		errors(j) = (i_results(j)-i_results(j-1))/i_results(j);
		  	end
	   	end	
	   	
	   	x_values = lower_lim:.1:upper_lim
		plot(x_values, ffunction)
	   	for r = 1 :iterations
			x_values2 = lower_lim:h_vector(r):upper_lim
			plot(x_values2,ffunction,'--')
		end

	   	disp(i_matrix,"I Matrix :");
	   	disp(i_matrix(iterations,iterations), "Final Result = ")
	   	disp(errors(iterations), "The error is : ")



	//elseif sel_menu == 2 then
		//disp("Type the function to evaluate with the following format:");
		//disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., where a, b, c are constants");
		//user_function = input("","string");
		//deff('[y] = ffunction(x)', user_function);
		//lower_lim = input("Insert the lower limit of the Integral : ");
	   	//upper_lim = input("Insert the upper limit of the Integral : ");
	   	//exp_error = input("Enter the expected error : ");
	   	//h_vector = zeros(iterations);
	   	//i_matrix = zeros(iterations,iterations);
	   	//prev_r_values = zeros(iterations);
	   	//errors = zeros(iterations);
	   	//cont = 0;
	   	//final_error = 100;
		//while final_error < exp_error ,

		//End while 
		//end
	//End if
	//end
//End function
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
			disp("Gauss Seidel Method");
			Gauss_Seidel();
		elseif selected_method == 0 then
			disp("Ending program");
		end;
		//Funciones del ultimo parcial, no se agregaron en subMenu debido a las instrucciones
	elseif selected_menu == 3 then
		disp("Linear_Regression_Method");
		Linear_Regression_Method();
	elseif selected_menu == 4 then
		disp("Interpolation_Direct_Method");
		Interpolation_Direct_Method();
	elseif selected_menu == 5 then
		disp("Integration_Trapezoidal");
		Integration_Trapezoidal();
	elseif selected_menu == 6 then
		disp("Integration_Romberg");
		Integration_Romberg();
	//elseif  selected_menu == 7 then
	//	linear_regression();
	end;
endfunction;
