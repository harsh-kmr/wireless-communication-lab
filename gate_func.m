x = 0;
y = 1;

% Logical gate operations
z_or = x | y;    % OR gate
a_and = x & y;   % AND gate
b_not = ~x;      % NOT gate
c_xor = x ^ y;   % XOR gate

% Additional gate operations
d_nand = ~(x & y);    % NAND gate
e_nor = ~(x | y);     % NOR gate
f_xnor = ~(x ^ y);    % XNOR gate

% Displaying the results
fprintf('Input x: %d, y: %d\n', x, y);
fprintf('OR gate (x|y): %d\n', z_or);
fprintf('AND gate (x&y): %d\n', a_and);
fprintf('NOT gate (~x): %d\n', b_not);
fprintf('XOR gate (x^y): %d\n', c_xor);
fprintf('NAND gate ~(x&y): %d\n', d_nand);
fprintf('NOR gate ~(x|y): %d\n', e_nor);
fprintf('XNOR gate ~(x^y): %d\n', f_xnor);
