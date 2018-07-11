data=peaks(64); % fake data
t=-0:8; % some thersholds

tdata=bsxfun(@gt,data,permute(t,[3 1 2])); % 3d threshold
data3=repmat(data,[1 1 numel(t)]); %just copy data to the 3rd dim
A=data3.*tdata;
A(A==0)=NaN; % this will eliminate showing the zero values

% plottning
h=slice(A,[],[],1:numel(t));
set(h,'EdgeColor','none','FaceColor','interp');

alpha(0.5);