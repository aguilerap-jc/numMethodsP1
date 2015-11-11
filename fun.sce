function fun()

	disp("Executing Linear_Regression_Method");
	disp("Type your table in matrix 2xN {1,2;3,4;5,6;7,8;9,10}")
	matrixA = input("insert you table : ")
	valueToFind = input("Introduce the value you want to find : ")
	order = input("Introduce the order you want to use : ")

	
	nearestValue = abs(matrixA(1,1) - valueToFind)
	nearestValuePos = 1
	numOfRows = size (matrixA, "r")
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
	disp(x0)

	rowInx0 = rowInCoefficients
	total = 0
	//get the value of the function after the substitution of the value that we want to find
	for rowInx0 = 1 : sizeOfsolveMatrix
	  	exponent = rowInx0 - 1
	  	total = total + ( x0(rowInx0) * valueToFind^exponent)
	end
	
	//display the value
	disp("value of the function evaluated ")
	disp(total)


endfunction
