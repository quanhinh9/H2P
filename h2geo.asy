//Một số hàm trên asymptote của Quân.T nhóm Quán Hình.
//quanhinh9@gmail.com
//https://www.facebook.com/groups/205466756603509/

//Phép vị tự

transform h2scale(pair center, real k)
{
	return shift(center)*scale(k)*shift(-center);
}

//Phép nghịch đảo

pair h2inverse(pair O, real k, pair M)
{
	return (O + k*unit(M-O)/abs(M-O));
}

//Trọng tâm G
pair h2centroid(pair A,pair B,pair C)
{
	return (A+B+C)/3;
}

//Hình chiếu vuông góc
pair h2project(pair P, pair A, pair B)
{
	return midpoint(P--reflect(A,B)*P);
}

//Trực tâm H
pair h2orthocenter(pair A, pair B, pair C)
{
	return extension(B, reflect(C,A)*B, C, reflect(A,B)*C);
}

//Tâm ngoại tiếp O
pair h2circumcenter(pair A, pair B, pair C)
{
	pair mAB=midpoint(A--B);
	pair mAC=midpoint(A--C);
	return extension(mAB, rotate(90,mAB)*A, mAC, rotate(90,mAC)*A);
}

//Tâm nội tiếp I
pair h2incenter(pair A, pair B, pair C)
{
	return extension(A, A+dir(A--B,A--C), B, B+dir(B--A,B--C));
}

//Tâm bàng tiếp Ia
pair h2excenter(pair A, pair B, pair C)
  {
   	return extension(B, B+rotate(90)*dir(B--A,B--C),C, C+rotate(90)*dir(C--A,C--B));
  }
  
//Điểm liên hợp đẳng giác của P đối với tam giác ABC
pair h2isoconj(pair P,pair A,pair B,pair C)
{
	pair I=h2incenter(A,B,C);
	return extension(B,reflect(B,I)*P,C,reflect(C,I)*P);
}  

//Tâm đường tròn Mixtilinear nôi
pair h2inmixcenter(pair A, pair B, pair C)
{
	pair I=h2incenter(A, B,C);
	pair Z=extension(A,B,I,rotate(90,I)*A);
	return extension(A,I,Z,rotate(90,Z)*A);
}

//Tiếp điểm của đường tròn Mixtilinear nội
pair h2inmixt(pair A, pair B, pair C)
{
	pair I=h2incenter(A,B,C);
	pair P=midpoint(I--h2excenter(A,B,C));
	pair O=h2circumcenter(A,B,C);
	pair Q=rotate(180,O)*P;
	return extension(Q,I,O,h2inmixcenter(A,B,C));
}

//Đường tròn Mixtilinear nội
path h2inmixcircle(pair A, pair B, pair C)
{
	pair I=h2incenter(A, B,C);
	pair Z=extension(A,B,I,rotate(90,I)*A);
	pair K=extension(A,I,Z,rotate(90,Z)*A);
	return circle(K,abs(K-Z));
}

//Tâm Mixtilinear ngoại
pair h2exmixcenter(pair A, pair B, pair C)
{
	pair Ia=h2excenter(A, B,C);
	pair Z=extension(A,B,Ia,rotate(90,Ia)*A);
	return extension(A,Ia,Z,rotate(90,Z)*A);
}

//Tiếp điểm Mixtilinear ngoại

pair h2exmixt(pair A, pair B, pair C)
{
	pair Ia=h2excenter(A, B,C);
	pair P=midpoint(h2incenter(A,B,C)--Ia);
	pair O=h2circumcenter(A,B,C);
	pair Q=rotate(180,O)*P;
	return extension(Q,Ia,O,h2exmixcenter(A,B,C));
}

//Đường tròn Mixtilinear ngoại
path h2exmixcircle(pair A, pair B, pair C)
{
	pair Ia=h2excenter(A, B,C);
	pair Z=extension(A,B,Ia,rotate(90,Ia)*A);
	pair Ka=extension(A,Ia,Z,rotate(90,Z)*A);
	return circle(Ka,abs(Ka-Z));
}

//Điểm Feuerback nội Fe
pair h2fepoint(pair A, pair B, pair C)
{
	pair M=midpoint(B--C);
	pair I=h2incenter(A, B,C);
	pair D=midpoint(I--reflect(B,C)*I);
	pair D1=reflect(A,I)*D;
	return reflect(I,reflect(M,D1)*I)*D1;
}

//Gergonne Point Ge
pair h2gepoint(pair A,pair B,pair C)
{
	pair I=h2incenter(A,B,C);
	return extension(B,h2project(I,C,A),C,h2project(I,A,B));
}

//Nine Point Center N9
pair h2n9point(pair A,pair B,pair C)
{
	return midpoint(h2orthocenter(A,B,C)--h2circumcenter(A,B,C));
}

//Nagel Point Na
pair h2napoint(pair A,pair B,pair C)
{
	pair E=h2project(h2excenter(B,C,A),C,A);
	pair F=h2project(h2excenter(C,A,B),A,B);
	return extension(B,E,C,F);
}

//Spieker point Sp
pair h2sppoint(pair A,pair B,pair C)
{	
	pair Ma=midpoint(B--C);
	pair Mb=midpoint(C--A);
	pair Mc=midpoint(A--B);
	return h2incenter(Ma,Mb,Mc);
}

//Kosnita Point Ka
pair h2kapoint(pair A,pair B,pair C)
{	
	pair O=h2circumcenter(A,B,C);
	return extension(B,h2circumcenter(O,C,A),C,h2circumcenter(O,A,B));
}

//Schiffler point Sc
pair h2scpoint(pair A,pair B,pair C)
{	
	pair I=h2incenter(A,B,C);
	return extension(h2orthocenter(A,B,C),h2circumcenter(A,B,C),h2orthocenter(I,B,C),h2circumcenter(I,B,C));
}

//Lemoine point Le
pair h2lepoint(pair A,pair B,pair C)
{	
	return h2isoconj(h2centroid(A,B,C),A,B,C);
}

//Humpty Point Hm
pair h2hmpoint(pair A, pair B, pair C)
{
	return h2project(h2orthocenter(A,B,C),A,midpoint(B--C));
}
