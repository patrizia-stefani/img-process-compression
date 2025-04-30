video = VideoWriter('svdComp','Archival'); %create the video object
 %open the file for writing

    
for i = 2:201
    directory = strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\svdCompression\', num2str(i), '.jpg');
    img = imread(directory);
     open(video);
    writeVideo(video,im2frame(img));
    close(video);
end
implay(video);
