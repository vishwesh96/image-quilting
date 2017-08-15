clear();
myNumOfColors = 250;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
% QUILTING
filename= 'seed1.jpg';
BlockSize=40;
OverlapSize = 6;
Original = imread(strcat('../data/textures/',filename));
Original = im2double(Original);

%output result
fig = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1), imagesc(quilting(Original,BlockSize,OverlapSize,350,350))
colorbar
colormap (myColorScale);
colormap 'jet'
title 'Result Image'
daspect ([1 1 1]);
axis tight

subplot(1,2,2), imagesc(Original)
colorbar
colormap (myColorScale);
colormap 'jet'
title 'Original Texture'
daspect ([1 1 1]);
axis tight

saveas(fig,strcat('../images/quilting/',num2str(BlockSize),'_',num2str(OverlapSize),'_',filename));
%% TEXTURE TRANSFER
filename='weave.jpg'
Tfilename='tendulkar.jpg'
Block=27
Overlap=6
NumIter=3

Original = imread(strcat('../data/textures/',filename));
Target = imread(strcat('../data/Probe/',Tfilename));
Original = im2double(Original);
Target = im2double(Target);
%Target = imresize(Target,0.8);


Result = texTransfer(Original,Target,Block,Overlap,NumIter);

fig2=figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imagesc(Result);
colorbar
colormap (myColorScale);
colormap 'jet'
title 'Result Image'
daspect ([1 1 1]);
axis tight

subplot(1,2,2), imagesc(Target),colorbar;
colormap (myColorScale);
title 'Target Image'
daspect ([1 1 1]);
axis tight

saveas(fig2,strcat('../images/transfers/',num2str(Block),'_',num2str(Overlap),'_',num2str(NumIter),'_',filename));

% filename='coffee1.jpg'
% Tfilename='obama.jpg'
% Block=25
% Overlap=6
% NumIter=3
% 
% Original = imread(strcat('../data/textures/',filename));
% Target = imread(strcat('../data/Probe/',Tfilename));
% Original = im2double(Original);
% Target = im2double(Target);
% %Target = imresize(Target,0.8);
% 
% 
% Result = texTransfer(Original,Target,Block,Overlap,NumIter);
% 
% fig2=figure('units','normalized','outerposition',[0 0 1 1])
% subplot(1,2,1), imagesc(Result);
% colorbar
% colormap (myColorScale);
% colormap 'jet'
% title 'Result Image'
% daspect ([1 1 1]);
% axis tight
% 
% subplot(1,2,2), imagesc(Target),colorbar;
% colormap (myColorScale);
% title 'Target Image'
% daspect ([1 1 1]);
% axis tight
% 
% saveas(fig2,strcat('../images/transfers/',num2str(Block),'_',num2str(Overlap),'_',num2str(NumIter),'_',filename));
% 
% filename='toadstone.png'
% Tfilename='trump.jpg'
% Block=25
% Overlap=6
% NumIter=3
% 
% Original = imread(strcat('../data/textures/',filename));
% Target = imread(strcat('../data/Probe/',Tfilename));
% Original = im2double(Original);
% Target = im2double(Target);
% %Target = imresize(Target,0.8);
% 
% 
% Result = texTransfer(Original,Target,Block,Overlap,NumIter);
% 
% fig2=figure('units','normalized','outerposition',[0 0 1 1])
% subplot(1,2,1), imagesc(Result);
% colorbar
% colormap (myColorScale);
% colormap 'jet'
% title 'Result Image'
% daspect ([1 1 1]);
% axis tight
% 
% subplot(1,2,2), imagesc(Target),colorbar;
% colormap (myColorScale);
% title 'Target Image'
% daspect ([1 1 1]);
% axis tight
% 
% saveas(fig2,strcat('../images/transfers/',num2str(Block),'_',num2str(Overlap),'_',num2str(NumIter),'_',filename));
% 
% filename='bluerock.jpg'
% Tfilename='tendulkar.jpg'
% Block=25
% Overlap=6
% NumIter=3
% 
% Original = imread(strcat('../data/textures/',filename));
% Target = imread(strcat('../data/Probe/',Tfilename));
% Original = im2double(Original);
% Target = im2double(Target);
% %Target = imresize(Target,0.8);
% 
% 
% Result = texTransfer(Original,Target,Block,Overlap,NumIter);
% 
% fig2=figure('units','normalized','outerposition',[0 0 1 1])
% subplot(1,2,1), imagesc(Result);
% colorbar
% colormap (myColorScale);
% colormap 'jet'
% title 'Result Image'
% daspect ([1 1 1]);
% axis tight
% 
% subplot(1,2,2), imagesc(Target),colorbar;
% colormap (myColorScale);
% title 'Target Image'
% daspect ([1 1 1]);
% axis tight

saveas(fig2,strcat('../images/transfers/',num2str(Block),'_',num2str(Overlap),'_',num2str(NumIter),'_',filename));