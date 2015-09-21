clear   
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
    r0 = r1;
    s0 = s1;
    output = ["iteration", "initial r", "initial s"];
    disp(output);
    output = ["    ", string(iteration), string(r0), string(s0)];
    disp(output);
    output = ["    ", "  a  ", "  b  ", "  c  "];
    disp(output);

    b_values(2) = a_values(2) + r0*b_values(1);
    c_values(2) = b_values(2) + r0*c_values(1);

        //Display n a,b, c values
        output = ["        ", string(a_values(1)), string(b_values(1)), string(c_values(1))];
        disp(output);
        //Display n-1 a,b,c values
        output = ["        ", string(a_values(2)), string(b_values(2)), string(c_values(2))];
        disp(output);

        for i = 3:matrix_y,
            b_values(i) = a_values(i) + r0*b_values(i-1) + s0*b_values(i-2);
            c_values(i) = b_values(i) + r0*c_values(i-1) + s0*c_values(i-2);
            output = ["        ", string(a_values(i)), string(b_values(i)), string(c_values(i))];
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

        output = ["  ", "  delta r  ", "  delta s  ", "  r  ", "  s  ", "error"];
        disp(output);
        output = ["    ", string(delta_r), string(delta_s), string(r1), string(s1), string(abs(_error)*100) + "%"];
        disp(output)
        iteration = iteration + 1;