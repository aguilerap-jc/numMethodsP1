clear
    xl= input("valor de xl: ")
    xu= input("valor de xu: ")
    xm=(xl+xu)/2
    disp(xm,"root: ")
    for i = 0:9
        disp(i,"...")
        xmt = xm
        xm=(xl+xu)/2
        fxlm= (xl^3-.165*xl^2+3.993*10^(-4))*(xm^3-.165*xm^2+3.993*10^(-4))
        if fxlm>0 then
            xl=xm
            xu=xu
            disp(xl,"xl: ")
            disp(xu,"xu: ")
            disp("sign: +")
        elseif fxlm<0 then
            xl=xl
            xu=xm
            disp(xl,"xl: ")
            disp(xu,"xu: ")
            disp("sign: -")
        else
            disp(xm,"root find it : ")
        end
        erro= (xm-xmt)/xm*100
        disp(erro,"error : ")
        disp(xm,"root: ")
        //exec("proyecto1.sce");
    end