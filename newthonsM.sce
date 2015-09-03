clear()
      x1= input("valor de x1: ")
      x2 = x1
      function y=f(x1)
            y=(x1^7)-1000
      endfunction
      for i = 0:9
            x2 = x1-(f(x2)/numderivative(f,x2))
            y1 = numderivative(f,x1)
            disp(x2,"el valor de"+ string(i)+ " :" )
            x1 = x2
      end
      exec("proyecto1.sce");