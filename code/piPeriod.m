syms x;
y = piecewise(mod(x,16) < 1,1,0);
fplot(x,y,[-17,17]); ylim([0,1.5]);
print('-dpng','period16Pulse.png');