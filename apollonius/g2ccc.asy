//Một số hàm asymptote cho bài toán Apollonius
//Version 1 of 10/04/2019
//Quân.T nhóm Quán Hình. email: quanhinh9@gmail.com
//https://www.facebook.com/groups/205466756603509/
//Tham khảo:
//http://asymptote.sourceforge.net/doc/index.html
//http://www.piprime.fr/asymptote/

import geometry;

//Tâm vị tự nội
point g2homoin(circle a, circle b)
{
	point A=a.C, B=b.C;
	point P=point(a,rotate(90,A)*B);
	point Q=point(b,rotate(90,B)*A);
	return intersectionpoint(line(A,B),line(P,Q));
}

//Tâm vị tự ngoại
point g2homoex(circle a, circle b)
{
	point output;
	point A=a.C, B=b.C;
	point P=point(a,rotate(90,A)*B);
	point Q=point(b,rotate(-90,B)*A);
	if (parallel(line(A,B),line(P,Q))==false)
	{
		output=intersectionpoint(line(A,B),line(P,Q));
	}
	return output;
}

//Trục vị tự của 03 đường tròn
line g2ax(circle a, circle b, circle c)
{
	line x;
	if (b.r==c.r){
		if (b.r == a.r) {
			return x;
		} else x=line(g2homoex(a,b), g2homoex(a,c));
	} else{
		if (b.r == a.r) {
			x=line(g2homoex(c,a), g2homoex(c,b)) ;
		} else x=line(g2homoex(b,a), g2homoex(b,c));
	}
	return x;
}

point g2point(point D, point T, circle a)
{
	point K;
	if (inside(a, D)){
		real x = abs(D-T) + a.r;
		K = point(circle(D,x),T);
	}
	
	return intersectionpoint(a,(D--K));
}

bool g2intersc(point A, point B, circle c)
{
	int i,j;
	if (A @ c || inside(c,A)) i=0; else i=1;
	if (B @ c || inside(c,B)) j=0; else j=1;
	
	if ((i==1 && j==0) || (i==0 && j==1)) return true;
	else return false;
}

//Trả về đường tròn tiếp xúc trong với cả a, b, c
circle[] g2cccin(circle a, circle b, circle c)
{
	circle[] CCCin;
	point T=radicalcenter(a,b,c);
	point A=a.C, B=b.C, C=c.C;
	
	if (a.r==b.r && a.r==c.r){
		point Ta=point(a,T); point T1=rotate(180,A)*Ta; 
		point Tb=point(b,T); point T2=rotate(180,B)*Tb;
		point Tc=point(c,T); point T3=rotate(180,C)*Tc;
		CCCin[0] = circle(Ta,Tb,Tc);
		CCCin[1] = circle(T1,T2,T3);
	} else{
		line m=g2ax(a,b,c);
		point X=projection(m)*A, Y=projection(m)*B, Z=projection(m)*C;
		point D=inversion(a)*X, E=inversion(b)*Y, F=inversion(c)*Z;
		
		point Ta=g2point(D,T,a); point T1=reflect(A,reflect(T,D)*A)*Ta;
		point Tb=g2point(E,T,b); point T2=reflect(B,reflect(T,E)*B)*Tb;
		point Tc=g2point(F,T,c); point T3=reflect(C,reflect(T,F)*C)*Tc;
		CCCin.push(circle(Ta,Tb,Tc)); CCCin.push(circle(T1,T2,T3));
	}
	return CCCin;
}

//Trả về đường tròn tiếp xúc ngoài với cả a, b, c
circle[] g2ccc(circle a, circle b, circle c)
{
	circle[] CCC;
	point T=radicalcenter(a,b,c);
	point A=a.C, B=b.C, C=c.C;
	line m=line(g2homoin(a,b),g2homoin(a,c));
	point X=projection(m)*A, Y=projection(m)*B, Z=projection(m)*C;
	point D=inversion(a)*X, E=inversion(b)*Y, F=inversion(c)*Z;
	
	if (g2intersc(T,D,a) && g2intersc(T,E,b) && g2intersc(T,F,c))
	{
		point Ta=intersectionpoint(a,(T--D)); point T1=reflect(A,reflect(T,D)*A)*Ta;
		point Tb=intersectionpoint(b,(T--E)); point T2=reflect(B,reflect(T,E)*B)*Tb;
		point Tc=intersectionpoint(c,(T--F)); point T3=reflect(C,reflect(T,F)*C)*Tc;
		CCC.push(circle(T1,Tb,Tc)); CCC.push(circle(Ta,T2,T3));
	}
	return CCC;
}
