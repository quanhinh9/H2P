//Đường tròn tâm O, bán kinh OA
circle g2circle1p(point O, point A)
{
	return circle(O,abs(O-A));
}

//Tâm vị tự trong của (a) và (b)
point g2inhomo(circle a, circle b)
{
	point A=a.C, B=b.C;
	point P=intersectionpoint(a,(A--rotate(90,A)*B));
	point Q=intersectionpoint(b,(B--rotate(90,B)*A));
	point R=rotate(180,B)*Q;
	return extension(A,B,P,Q);
}

//Tâm vị tự ngoài của (a) và (b)
point g2exhomo(circle a, circle b)
{
	point A=a.C, B=b.C;
	point P=intersectionpoint(a,(A--rotate(90,A)*B));
	point Q=intersectionpoint(b,(B--rotate(-90,B)*A));
	point R=rotate(180,B)*Q;
	return extension(A,B,P,Q);
}

//Đường tròn đi qua A, B và tiếp xúc với đường thẳng m
//02
circle[] g2PPL(point A, point B, line m)
{
	circle[] PPL;
	int count=0;

	point[] temp=intersectionpoints(parabola(A,m),parabola(B,m));
	for (int n=0; n<temp.length; ++n)
	{
		PPL[count]=g2circle1p(temp[n],A); ++count;
	}
	return PPL;
}

