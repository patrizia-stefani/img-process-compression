close all;
clear;

syms x;
y = piecewise(x > -1.5 & x < 1.5, 1);
figure;
fplot(y,[-3,3]);ylim([-3,3]);title('Original function');xlabel('x');
ylabel('y');
print('-dpng','original_Function.png');

y = piecewise(mod(x,2) < 1 & x > -3 & x < 3, 1, mod(x,2) > 1 & x > -3 & x < 3, -1);
figure;
fplot(y,[-3,3]);ylim([-3,3]);title('Even periodization');xlabel('x');
ylabel('y');
print('-dpng','even_function.png');

y = piecewise(x > -3 & x < 3, 1);
figure;
fplot(y,[-3,3]);ylim([-3,3]);title('Odd periodization');xlabel('x');
ylabel('y');
print('-dpng','odd_function.png');
