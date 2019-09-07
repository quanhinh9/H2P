//Một số hàm trên asymptote của Quân.T nhóm Quán Hình.

//Phép vị tự 
transform scale(pair center, real k)
{
	return shift(center)*scale(k)*shift(-center);
}

//Trọng tâm G
pair centroid(pair A,pair B,pair C)
{
	return (A+B+C)/3;
}

//Hình chiếu vuông góc
pair project(pair P, pair A, pair B)
{
	return midpoint(P--reflect(A,B)*P);
}

//Trực tâm H
pair orthocenter(pair A, pair B, pair C)
{
	return extension(B, reflect(C,A)*B, C, reflect(A,B)*C);
}

//Tâm ngoại tiếp O
pair circumcenter(pair A, pair B, pair C)
{
	pair mAB=midpoint(A--B);
	pair mAC=midpoint(A--C);
	return extension(mAB, rotate(90,mAB)*A, mAC, rotate(90,mAC)*A);
}

//Tâm nội tiếp I
pair incenter(pair A, pair B, pair C)
{
	return extension(A, A+dir(A--B,A--C), B, B+dir(B--A,B--C));
}

//Tâm bàng tiếp Ia, Ib, Ic
pair excenter(pair A, pair B, pair C)
  {
   	return extension(B, B+rotate(90)*dir(B--A,B--C),C, C+rotate(90)*dir(C--A,C--B));
  }
  
//Điểm liên hợp đẳng giác của P đối với tam giác ABC  
pair isoconj(pair P,pair A,pair B,pair C)
{
	pair I=incenter(A,B,C);
	return extension(B,reflect(B,I)*P,C,reflect(C,I)*P);
}  

//Tâm đường tròn Mixtilinear nội
pair inmixcenter(pair A, pair B, pair C)
{
	pair I=incenter(A, B,C);
	pair Z=extension(A,B,I,rotate(90,I)*A);
	return extension(A,I,Z,rotate(90,Z)*A);
}

//Tiếp điểm của đường tròn Mixtilinear nội
pair inmixt(pair A, pair B, pair C)
{
	pair I=incenter(A,B,C);
	pair P=midpoint(I--excenter(A,B,C));
	pair O=circumcenter(A,B,C);
	pair Q=rotate(180,O)*P;
	return extension(Q,I,O,inmixcenter(A,B,C));
}

//Đường tròn Mixtilinear nội
path inmixcircle(pair A, pair B, pair C)
{
	pair I=incenter(A, B,C);
	pair Z=extension(A,B,I,rotate(90,I)*A);
	pair K=extension(A,I,Z,rotate(90,Z)*A);
	return circle(K,abs(K-Z));
}

//Tâm đường tròn Mixtilinear ngoại
pair exmixcenter(pair A, pair B, pair C)
{
	pair Ia=excenter(A, B,C);
	pair Z=extension(A,B,Ia,rotate(90,Ia)*A);
	return extension(A,Ia,Z,rotate(90,Z)*A);
}

//Tiếp điểm của đường tròn Mixtilinear ngoại
pair exmixt(pair A, pair B, pair C)
{
	pair Ia=excenter(A, B,C);
	pair P=midpoint(incenter(A,B,C)--Ia);
	pair O=circumcenter(A,B,C);
	pair Q=rotate(180,O)*P;
	return extension(Q,Ia,O,exmixcenter(A,B,C));
}

//Đường tròn Mixtilinear ngoại
path exmixcircle(pair A, pair B, pair C)
{
	pair Ia=excenter(A, B,C);
	pair Z=extension(A,B,Ia,rotate(90,Ia)*A);
	pair Ka=extension(A,Ia,Z,rotate(90,Z)*A);
	return circle(Ka,abs(Ka-Z));
}

//Điểm Feuerback nội
pair fepoint(pair A, pair B, pair C)
{
	pair M=midpoint(B--C);
	pair I=incenter(A, B,C);
	pair D=midpoint(I--reflect(B,C)*I);
	pair D1=reflect(A,I)*D;
	return reflect(I,reflect(M,D1)*I)*D1;
}

//Điểm Gergonne Ge
pair gepoint(pair A,pair B,pair C)
{
	pair I=incenter(A,B,C);
	return extension(B,project(I,C,A),C,project(I,A,B));
}

//Tâm của đường tròn 9 điểm Nine Point Center
pair n9point(pair A,pair B,pair C)
{
	return midpoint(orthocenter(A,B,C)--circumcenter(A,B,C));
}

//Điểm Nagel Na
pair napoint(pair A,pair B,pair C)
{
	pair E=project(excenter(B,C,A),C,A);
	pair F=project(excenter(C,A,B),A,B);
	return extension(B,E,C,F);
}

//Điểm Spieker Sp
pair sppoint(pair A,pair B,pair C)
{	
	pair Ma=midpoint(B--C);
	pair Mb=midpoint(C--A);
	pair Mc=midpoint(A--B);
	return incenter(Ma,Mb,Mc);
}

//Điểm Kosnita Ka
pair kapoint(pair A,pair B,pair C)
{	
	pair O=circumcenter(A,B,C);
	return extension(B,circumcenter(O,C,A),C,circumcenter(O,A,B));
}

//Điểm Schiffler Sc
pair scpoint(pair A,pair B,pair C)
{	
	pair I=incenter(A,B,C);
	return extension(orthocenter(A,B,C),circumcenter(A,B,C),orthocenter(I,B,C),circumcenter(I,B,C));
}

//Điểm Lemoine Le (điểm Symmedian)
pair lepoint(pair A,pair B,pair C)
{	
	return isoconj(centroid(A,B,C),A,B,C);
}

//Điểm Humpty
pair hmpoint(pair A, pair B, pair C)
{
	return project(orthocenter(A,B,C),A,midpoint(B--C));
}
