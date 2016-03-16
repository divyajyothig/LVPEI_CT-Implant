close all;

imgPath = dir('/home/divya/Documents/LVPEI/CT data/SE1/*.dcm');

% inf = zeros(1, 40);
% im = zeros(1, 372);
for i = 1 : length(imgPath)
    file_name = imgPath(i).name;
    full_file_name = fullfile('/home/divya/Documents/LVPEI/CT data/SE1',file_name);  
    inf(i) = dicominfo(full_file_name);
    x = dicomread(full_file_name);
    im{i} = {x};
end

[loc idx] = sort([inf.SliceLocation]);
I_front = zeros(372, 512);
I_side = zeros(512, 372);

figure;
for i = 1 : length(imgPath)
    for j = 1 : length(idx)
        k = idx(j);
        I_front(j,:) = im{k}{1}(i,:);
        I_side(:,j) = im{k}{1}(:,i);
    end 
    If = imrotate(I_front, 180);
    Is = imrotate(I_side,90);
    m = idx(i);
    subplot(1,3,1)
    imshow(im{m}{1},[])
    subplot(1,3,2)
    imshow(If,[]);
    subplot(1,3,3)
    imshow(Is,[]);
    pause(0.01)
end
