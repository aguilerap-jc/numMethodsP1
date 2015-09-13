clear;
// Ask for required data
disp("Escriba la función que desa evaluar con el siguiente formato:");
disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., donde a, b, c son constantes");
user_function = input("","string");
xl            = input("valor de xl: ");
xu            = input("valor de xu: ");
max_error     = input("valor máximo de error en %")/100.0;

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