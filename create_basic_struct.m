% generate initial volume for RRM (here a FCC structure oriented along 001 direction)
liste=0;
n=1;
sizemax=90;% used for X, Y dimensions
ncouches=180;%180 layers 001
cutz=sizemax/2.0;
shift=6;
k=0;

for (i=-sizemax:sizemax)
    for (j=-sizemax:sizemax)
        liste(n,1)=i;
        liste(n,2)=j;
        liste(n,3)=k;
        liste(n,4)=1;
        n=n+1;
        liste(n,1)=(i+0.5);
        liste(n,2)=(j+0.5);
        liste(n,3)=k;
        liste(n,4)=1;
        n=n+1;
        liste(n,1)=(i+0.5);
        liste(n,2)=j;
        liste(n,3)=(k+0.5);
        liste(n,4)=1;
        n=n+1;
        liste(n,1)=i;
        liste(n,2)=(j+0.5);
        liste(n,3)=(k+0.5);
        liste(n,4)=1;
        n=n+1;
    end
end
listeu=liste;

for (k=1:ncouches)
listeu(:,3)=listeu(:,3)+1;
liste=[liste;listeu];
end



minx=min(liste(:,1));
miny=min(liste(:,2));
maxx=max(liste(:,1));
maxy=max(liste(:,2));
minz=min(liste(:,3));
maxz=max(liste(:,3));

centrex=(maxx+minx)/2.0;
centrey=(maxy+miny)/2.0;
centrez=(maxz+minz)/2.0;
taillez=maxz-minz;


listeu=liste;
clear liste;
radius=(sqrt(listeu(:,1).^2+listeu(:,2).^2)-0.01*(centrez-listeu(:,3)));% to generate a small shank angle
rad2=sqrt(listeu(:,1).^2+listeu(:,2).^2+(listeu(:,3)-centrez).^2);
listeu=listeu(((radius<0.9*sizemax)&(listeu(:,3)<centrez))|((rad2<0.9*sizemax)&(listeu(:,3)>=centrez)),:);

listeu=listeu(listeu(:,3)>cutz,:);

minx=min(listeu(:,1));
miny=min(listeu(:,2));
maxx=max(listeu(:,1));
maxy=max(listeu(:,2));
minz=min(listeu(:,3));
maxz=max(listeu(:,3));

listeu(:,3)=listeu(:,3)-minz;

% the bottom layer must be close to z=0

 
% for (k=1:ncouches)
%     liste=[liste;listeu];
%     listeu(:,3)=listeu(:,3)+1;
% end
% liste=0;
% liste=zeros(size(sim));
% liste(:,1)=sim(:,2)/2.9;
% liste(:,2)=sim(:,3)/2.9;
% liste(:,3)=sim(:,4)/2.9;
% liste(:,4)=sim(:,1);
% for a real structure, use adimentional xyz, so divide by the lattice
% parameter

minx=min(listeu(:,1));
miny=min(listeu(:,2));
maxx=max(listeu(:,1));
maxy=max(listeu(:,2));
minz=min(listeu(:,3));
maxz=max(listeu(:,3));

% centrex=(maxx+minx)/2.0;
% centrey=(maxy+miny)/2.0;
% 
% liste(:,1)=liste(:,1)-minx;
% liste(:,2)=liste(:,2)-miny;
% liste(:,3)=liste(:,3)-minz;
% 
% liste(sim(:,1)==0,4)=1;
% liste(sim(:,1)~=0,4)=.8;
% 
% minx=min(liste(:,1));
% miny=min(liste(:,2));
% maxx=max(liste(:,1));
% maxy=max(liste(:,2));
% maxz=max(liste(:,3));
% 
% listep=liste;
% listep(:,1)=listep(:,1)+0.5+maxx;
% liste=[liste;listep];
% listep=liste;
% listep(:,2)=listep(:,2)+0.5+maxy;
% liste=[liste;listep];
% listep=liste;
% listep(:,3)=listep(:,3)+0.5+maxz;
% liste=[liste;listep];
% 
% minx=min(liste(:,1));
% miny=min(liste(:,2));
% maxx=max(liste(:,1));
% maxy=max(liste(:,2));
% minz=min(liste(:,3));
% maxz=max(liste(:,3));
% 
% listep=liste;
% listep(:,1)=listep(:,1)+0.5+maxx;
% liste=[liste;listep];
% listep=liste;
% listep(:,2)=listep(:,2)+0.5+maxy;
% liste=[liste;listep];
% listep=liste;
% listep(:,3)=listep(:,3)+0.5+maxz;
% liste=[liste;listep];
% 
% minx=min(liste(:,1));
% miny=min(liste(:,2));
% maxx=max(liste(:,1));
% maxy=max(liste(:,2));
% minz=min(liste(:,3));
% maxz=max(liste(:,3));
% 
% centrex=(maxx+minx)/2.0;
% centrey=(maxy+miny)/2.0;
% centrez=(maxz+minz)/2.0;
% 
% 
% 
% 
% liste(:,1)=liste(:,1)-centrex;
% liste(:,2)=liste(:,2)-centrey;
% 
% 
% minx=min(liste(:,1));
% miny=min(liste(:,2));
% maxx=max(liste(:,1));
% maxy=max(liste(:,2));
% minz=min(liste(:,3));
% maxz=max(liste(:,3));
% indices=randperm(length(liste(:,1)));
% liste=liste(indices,:);
% listep=liste;
% listep(:,3)=listep(:,3)+maxz+1;
% liste=[liste;listep];

listeu=sortrows(listeu,3,'descend');

%YOUR DATASET MUST BE SORTED WITH FIRST ATOM OF THE LIST BEING AT ZMAX

% radius=sqrt(liste(:,1).^2+liste(:,2).^2);
% 
% liste=liste(radius<maxx*0.8,:);
% radius=sqrt(liste(:,1).^2+liste(:,2).^2+(liste(:,3)-centrez).^2);
% liste=liste((radius<(maxx*0.8))|(liste(:,3)<centrez),:);

listeu(:,3)=listeu(:,3)-2;
% The bottom layer in z is place à z=-2 (charge not calculated for this
% layer)

% rad3=sqrt((liste(:,1)-4).^2+(liste(:,2)-10).^2+((liste(:,3)-centrez)-43).^2);
% 
% liste(rad3<6,4)=1.25;
% 
% rad3=sqrt((liste(:,1)+10).^2+(liste(:,2)+4).^2+((liste(:,3)-centrez)-38).^2);
% 
% liste(rad3<6,4)=0.75;


top=max(listeu(:,3));
centrex=10; centrey=10;centrez=top-12;
radius=sqrt((listeu(:,1)-centrex).^2+(listeu(:,2)-centrey).^2+(listeu(:,3)-centrez).^2);
taillerayonboule=3;

alea=rand(length(radius),1);
listeu((alea>0.9),4)=1.15;
listeu((alea<0.9),4)=1;

listeu((radius<taillerayonboule)&(alea>0.15),4)=1.15; %15%
listeu((radius<taillerayonboule)&(alea<=0.15),4)=1;
% the last colon is the Evap field ratio , here a particule is introducted

liste_s=listeu(abs(listeu(:,1))<1,:);


%figure;scatter3(liste_s(:,1),liste_s(:,2),liste_s(:,3),5,liste_s(:,4),'filled');daspect([1 1 1]);

fid=fopen('simFeCr110.dat','w');
fprintf(fid,'%d\n',length(listeu(:,1)));
fprintf(fid,'%6.3f %6.3f %6.3f %6.3f\n',listeu');fclose(fid);


