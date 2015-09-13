clear;
// Ask for required data
disp("Escriba la función que desa evaluar con el siguiente formato:");
disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., donde a, b, c son constantes");
user_function = input("","string");
x0            = input("valor de x0: ")
max_error     = input("valor máximo de error en %")/100.0;

//Initialize user function and required values
deff('[y] = newton_raphson(x)', user_function);
_error    = 1;
iteration = 0;
output    = ["iteration", "xi", "f(xi)", "derivate f(xi)", "error"];
disp(output);

//Iterations
while abs(_error) >= max_error then
    iteration  = iteration + 1;
    f_x0       = newton_raphson(x0);
    deriv_f_x0 = numderivative(newton_raphson, x0);
    x1         = x0 - f_x0/deriv_f_x0;
    _error     = (x1 - x0)/x1;

    //Display values
    if(iteration <> 1) then
        output = ["  " + string(iteration), string(x0), string(f_x0), string(deriv_f_x0), string(abs(_error)*100) + "%"];
    else 
        output = ["  " + string(iteration), string(x0), string(f_x0), string(deriv_f_x0), " --- "];
    end;

    disp(output);
    x0 = x1;
end
