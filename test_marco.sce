	matrix_A = input("Define matrix A");
	matrix_B = input("Define matrix B");
	n   = size(matrix_A, "r");

	for i=1: n
		actual_row_A = matrix_A(i,:);
		value_1_A = matrix_A(i,i);
		actual_row_B = matrix_B(i,:);

		for j=i+1: n
            disp(i);
            disp(j);
			next_row_A = matrix_A(j, :);
			value_2_A = matrix_A(j,i);
			matrix_A(j, :) = next_row_A - actual_row_A*value_2_A/value_1_A;
			next_row_B = matrix_B(j, :);
			matrix_B(j, :) = next_row_B - actual_row_B*value_2_A/value_1_A;
		end

		matrix_A(i, :) = actual_row_A/actual_row_A(i);
        matrix_B(i, :) = actual_row_B/actual_row_A(i);
	end

    for i=n:-1:1
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

