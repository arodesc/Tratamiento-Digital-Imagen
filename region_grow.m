imagen=imread('mamo.jpg');
H=fspecial('unsharp',0.8);
imagen_filt=imfilter(imagen, H);
%subplot(3,1,1), imshow(imagen)

imagen_filter=imcrop(imagen_filt, [2 2 222 169]);


m=max(max(imagen_filter))
m=0.9*m;
semilla=find(imagen_filter>=m);
l=length(semilla);

imagen_filter(semilla)=0;
subplot(2,1,1), imshow(imagen_filter)

vector_semilla=semilla;
%cont_semilla=l;
mascara=ones(170,223);
mascara(vector_semilla)=0;
[X,Y]=find(mascara<1);
cont_semilla=length(length([X,Y]));
ii=1;
while ii<cont_semilla && (X(ii)-1)>=0  && (Y(ii)-1)>=0 && (X(ii)+1)<=222 && (Y(ii)+1)<=169
    if ((imagen_filter(X(ii),Y(ii))-imagen_filter(X(ii)+1,Y(ii))<=1) && mascara(X(ii),Y(ii))==1)
            mascara(X(ii)+1,Y(ii))=0;
            %vector_semilla=find(mascara<1);
            cont_semilla=cont_semilla+1;
    end
    if ((imagen_filter(X(ii),Y(ii))-imagen_filter(X(ii),Y(ii)+1)<=1) && mascara(X(ii),Y(ii))==1)
            mascara(X(ii),Y(ii)+1)=0;
            %vector_semilla=find(mascara<1);
            cont_semilla=cont_semilla+1;
    end
    if ((imagen_filter(X(ii),Y(ii))-imagen_filter(X(ii)+1,Y(ii)+1)<=1) && mascara(X(ii),Y(ii))==1)
            mascara(X(ii)+1,Y(ii)+1)=0;
            %vector_semilla=find(mascara<1);
            cont_semilla=cont_semilla+1;
    end 
    ii=ii+1;
    %[X,Y]=find(mascara<1);
    %cont_semilla=length(length([X,Y]))
    subplot(2,1,2), imshow(mascara)
end
