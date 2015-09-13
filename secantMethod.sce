clear;
// Ask for required data
disp("Escriba la función que desa evaluar con el siguiente formato:");
disp(" y=a*x^n + b*x^(n-1) + c*x^(n-2) ..., donde a, b, c son constantes");
user_function = input("","string");
x0            = input("valor de x0: ")
x1            = input("valor de x1: ")
max_error     = input("valor máximo de error en %")/100.0;

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
