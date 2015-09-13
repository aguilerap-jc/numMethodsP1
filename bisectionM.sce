clear;
// Ask for required data
disp("Escriba la función que desa evaluar con el siguiente formato:");
disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., donde a, b, c son constantes");
user_function = input("","string");
xl            = input("valor de xl: ");
xu            = input("valor de xu: ");
max_error     = input("valor máximo de error en %")/100.0;

//Initialize user function
deff('[y] = bisection(x)', user_function);

//First iteration
iteration = 1;
xm    = (xl + xu)/2;
_sign = bisection(xl)*bisection(xm) > 0;
disp(iteration, "iteration: ");
disp(xl, "xl: ");
disp(xu, "xu: ");
disp(xm, "xm: ");

if(_sign) then 
    disp("sign: +");
else
    disp("sign: -");
end

_error = 1;

//Next iterations
while _error >= max_error then
    iteration = iteration + 1;
    prev_xm   = xm;

    if(_sign) then 
        xl = xm;
    else
        xu = xu;
    end

    xm     = (xl + xu)/2;
    _sign  = bisection(xl)*bisection(xu) > 0;
    _error = (xm - prev_xm)/xm;

    //Display values
    disp(iteration, "iteration: ");
    disp(xl, "xl: ");
    disp(xu, "xu: ");
    disp(xm, "xm: ");
    
    if(_sign) then 
        disp("sign: +");
    else
        disp("sign: -");
    end

    disp(string(_error*100) + "%", "error: ");
end