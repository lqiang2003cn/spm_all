

clear;


x = -2: 0.2 : 2; 
y = (-1: 0.15 : 1)';
z = x .* exp(-x.^2 - y.^2);
[px,py] = gradient(z, 0.2, 0.2);
contour(x,y,z), hold on
quiver(x,y,px,py), hold off




%g123


X(:, :, 1) = [
    1, 2;
    3, 4;
    5, 6
];

X(:, :, 2) = [
    11, 12;
    13, 14;
    15, 16
];

X(:, :, 3) = [
    111, 112;
    113, 114;
    115, 116
];

X(:, :, 4) = [
    1111, 1112;
    1113, 1114;
    1115, 1116
];

x{1} = [8, 9]; 
x{2} = [10, 20, 30, 40];


rc = cell_md_dot(X, x);



for i = 1:4
    r(:,i) = X(:,:,i) * x{1}';
end

rr = r * x{2}';

function X = cell_md_dot(X,x)
    % initialize dimensions
    DIM = (1:numel(x)) + ndims(X) - numel(x);
    
    % compute dot product using recursive sums (and bsxfun)
    for d = 1:numel(x)
        s         = ones(1,ndims(X));
        s(DIM(d)) = numel(x{d});
        X         = bsxfun(@times,X,reshape(full(x{d}),s));
        X         = sum(X,DIM(d));
    end
    
    % eliminate singleton dimensions
    X = squeeze(X);
end 



