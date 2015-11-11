function fun ()

//ask for the initial values of the X values
newX1 = input("Initia value of X1 ");
newX2 = input("Initia value of X2 ");
newX2 = input("Initia value of X2 ");
disp("introduce the constants of each equation in matrix style ")
disp("  Array{A,B,C;D,E,F;G,H,I}")
//ask for the equation in vector format
matrixA = input("Matrix A : ");
disp("introduce the other side of the equaility")
disp("  Array{A;B;C}")
matrixB = input("Matrix B : ");
maxError = input("max error value in % ")/100.0;

//verify that the matrix is Diagonally dominant
if matrixA(1,1) > matrixA(1,2)+matrixA(1,3) then
    if matrixA(2,2) > matrixA(2,1) + matrixA(2,3)then
        if matrixA(3.3) > matrixA(3,1) + matrixA(3,2) then
            while maxError < actualError
                //save values 
                oldX1 = newX1
                oldX2 = newX2
                oldX3 = newX3  
                //solution for x1
                newX1 = matrixB(1) - oldX1 * matrixA(1,2)
                        
            end
        else
            disp("not a Diagonally dominant matrix")
        end
    else
        disp("not a Diagonally dominant matrix")
    end
else
    disp("not a Diagonally dominant matrix")
end
    
endfunction


















