import geometry;

//Hàm real distance(point M, line l) trả lại khoảng cách từ điểm M đến đường thẳng l

//Đường tròn tâm O, bán kinh OA
circle g2circle1p(point O, point A)
{
	return circle(O,abs(O-A));
}

//Đường tròn tâm O và tiếp xúc với đường thẳng m

circle g2circlePL(point O, line m)
{
	circle pl;
	if (O @ m) 
	{
		return pl;
	}
	else
	{
		pl=circle(O,distance(O,m));
	}
	return pl;
}

//Đường tròn đi qua A, B (không nằm trên m) và tiếp xúc với đường thẳng m
circle[] g2ppl(point A, point B, line m)
{
	circle[] ppl;
	if((A @ m) && (B @ m)) return ppl;
	
	if (A @ m)
	{
		int count=0;
		point[] temp=intersectionpoints(parabola(B,m),perpendicular(A,m));
		for (int n=0; n<temp.length; ++n)
		{
			ppl[count]=g2circle1p(temp[n],A); ++count;		
		}
	}
	
	else
	{
		if (B @ m)
		{
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),perpendicular(B,m));
			for (int n=0; n<temp.length; ++n)
			{
				ppl[count]=g2circle1p(temp[n],A); ++count;		
			}
		}
		else
		{
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),parabola(B,m));
			for (int n=0; n<temp.length; ++n)
			{
				ppl[count]=g2circle1p(temp[n],A); ++count;		
			}
		}
	}
		
	return ppl;	

}

//Đường tròn đi qua A và tiếp xúc với hai đường thẳng m, n

circle[] g2pll(point A, line m, line n)
{
	circle[] pll;

	if((A @ m) && (A @ n)) return pll;
	
	if (A @ m)
	{
		int count=0;
		point[] temp=intersectionpoints(parabola(A,n),perpendicular(A,m));
		for (int n=0; n<temp.length; ++n)
		{
			pll[count]=g2circle1p(temp[n],A); ++count;		
		}
	}
	else
	{
		if (A @ n)
		{
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),perpendicular(A,n));
			for (int n=0; n<temp.length; ++n)
			{
				pll[count]=g2circle1p(temp[n],A); ++count;		
			}
		}
		else
		{
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),parabola(A,n));
			for (int n=0; n<temp.length; ++n)
			{
				pll[count]=g2circle1p(temp[n],A); ++count;		
			}
		}
	}
	return pll;

}
