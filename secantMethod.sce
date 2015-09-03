clear()
 x0= input("valor de x0: ")
 x1= input("valor de x1: ")
function y=f(x)
    y=(x^7)-1000
endfunction
x2 = 0
    for i = 0:12
       
        if x1 == x0 then
            disp("el valor de x1 y x2 son iguales :" )
            abort
        else
            x2 = x1 - (f(x1)/((f(x1)-f(x0))/(x1-x0)))
            disp(x2,"el valor de"+ string(i)+ " :" )
            x0 = x1
            x1 = x2
        end
    end

