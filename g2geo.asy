import geometry;

//Đường tròn tâm O, bán kinh OA
circle g2circle1p(point O, point A)
{
	return circle(O,abs(O-A));
}

path g2line(point A=(0,0), point B=(0,0), real a=0.1, real b=a)
{
	return (a*(A-B)+A)--(b*(B-A)+B);
}

//Đường tròn tâm O tiếp xúc với đường thẳng m
circle g2circlePL(point O, line m)
{	circle pl;
	if (O @ m == false) pl=circle(O,distance(O,m));
	return pl;
}

//Trung điểm cung BC
point g2midarc(point O, point B, point C)
{
	return midpoint(arc((pair)O,(pair)B,(pair)C));
}

//Cung AB + 10^o
path g2arc(point O, point A, point B, int a=10, real b=a)
{
	pair o=O, a=rotate(-a,o)*A, b=rotate(b,o)*B;
	return arc(o,a,b);
}

path g2perpendicular(point O, line m, real x=1)
{
	point Op = projection(m) * O;
	point A = Op == m.A ? m.B : m.A;
	return g2line(Op, rotate(90, Op) * A, x);
}

//PPL: Apollonius Problem with Two Points and a Line
circle[] g2ppl(point A, point B, line m)
{
	circle[] ppl;
	int ia, ib;
	if (A @ m) {ia=0;} else ia=1;
	if (B @ m) {ib=0;} else ib=1;
	
	if (ia==1) {
		if (ib==1){
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),parabola(B,m));
			for (int i=0; i<temp.length; ++i){
				ppl.push(g2circle1p(temp[i],A)); ++count;	
			}
		} else{
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),perpendicular(B,m));
			for (int i=0; i<temp.length; ++i){
				ppl.push(g2circle1p(temp[i],A)); ++count;	
			}
		}
	}
	
	if (ia==0){
		if (ib==1){
			int count=0;
			point[] temp=intersectionpoints(parabola(B,m),perpendicular(A,m));
			for (int i=0; i<temp.length; ++i){
				ppl.push(g2circle1p(temp[i],A)); ++count;	
			}
		}
		else return ppl;
	}
	return ppl;
}

//PLL: Apollonius Problem with a Point and Two Lines
circle[] g2pll(point A, line m, line n)
{
	circle[] pll;
	int im, in;
	if (A @ m) {im=0;} else im=1;
	if (A @ n) {in=0;} else in=1;
	
	if (im==1){
		if (in==1){
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),parabola(A,n));
			for (int i=0; i<temp.length; ++i){
				pll.push(g2circle1p(temp[i],A)); ++count;	
			}
		} else {
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),perpendicular(A,n));
			for (int i=0; i<temp.length; ++i){
				pll.push(g2circle1p(temp[i],A)); ++count;	
			}
		}
	}
	
	if (im==0){
		if (in==1){
			int count=0;
			point[] temp=intersectionpoints(parabola(A,n),perpendicular(A,m));
			for (int i=0; i<temp.length; ++i){
				pll.push(g2circle1p(temp[i],A)); ++count;
			}
		}
		else return pll;
	
	}
	return pll;
}

//PPC: Apollonius Problem with Two Points and a Circle
circle[] g2ppc(point A, point B, circle c)
{
	circle[] ppc;
	line bis = bisector(A,B);
	int ia,ib;
	if (A @ c) {ia=0;} else if (inside(c,A)) {ia=-1;} else ia=1;
	if (B @ c) {ib=0;} else if (inside(c,B)) {ib=-1;} else ib=1;
	
	if (ia==1){
		if (ib==1){
			hyperbola hypA=hyperbola(A,c.C,c.r/2); 
			int count=0;
			point[] temp=intersectionpoints(hypA,bis);
			for (int i=0; i<temp.length; ++i){
				ppc.push(g2circle1p(temp[i],A)); ++count;
			}
		} else if (ib==0) {
			if(parallel(line(B,c.C),bis)==false){
				point temp=intersectionpoint(line(B,c.C),bis);
				ppc.push(g2circle1p(temp,A));
			}

		} else return ppc;
	}
	
	if (ia==0){
		if (ib==0){
			return ppc;
		} else {
			if(parallel(line(A,c.C),bis)==false){
				point temp=intersectionpoint(line(A,c.C),bis);
				ppc.push(g2circle1p(temp,A)); 
			}
		}
	}
	
	if (ia==-1){
		if (ib==1){
			return ppc;
		} else if (ib==0) {
			if(parallel(line(B,c.C),bis)==false){
				point temp=intersectionpoint(line(B,c.C),bis);
				ppc.push(g2circle1p(temp,A));
			}

		} else {
			ellipse ellA=ellipse(A,c.C,c.r/2); 
			int count=0;
			point[] temp=intersectionpoints(ellA,bis);
			for (int i=0; i<temp.length; ++i){
				ppc.push(g2circle1p(temp[i],A)); ++count;
			}
		}
	}
	return ppc;
}

//PLC: Apollonius Problem with a point, a line, and a circle
////////////////////////////////////////////
circle[] g2plc(point A, line m, circle b)
{
	circle[] plc;
	int im,ib;
	if (A @ m) im=0; else im=1;
	if (A @ b) {ib=0;} else if (inside(b,A)) {ib=-1;} else ib=1;
	
	if (im==1)
	{
		if (ib==1){
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),hyperbola(A,b.C,b.r/2));
			for (int n=0; n<temp.length; ++n)
			{
				plc[count]=g2circle1p(temp[n],A); ++count;
			}
		} else if (ib==0) {
			int count=0;
			point[] temp=intersectionpoints(line(A,b.C),parabola(A,m));
			for (int n=0; n<temp.length; ++n)
			{
				plc[count]=g2circle1p(temp[n],A); ++count;
			}
		} else {
			int count=0;
			point[] temp=intersectionpoints(parabola(A,m),ellipse(A,b.C,b.r/2));
			for (int n=0; n<temp.length; ++n)
			{
				plc[count]=g2circle1p(temp[n],A); ++count;
			}
		}
	}
	
	if (im==0)
	{
		if (ib==1){
			int count=0;
			point[] temp=intersectionpoints(perpendicular(A,m),hyperbola(A,b.C,b.r/2));
			for (int n=0; n<temp.length; ++n)
			{
				plc[count]=g2circle1p(temp[n],A); ++count;
			}
		} else if (ib==0) {
			return plc;
		} else {
			int count=0;
			point[] temp=intersectionpoints(perpendicular(A,m),ellipse(A,b.C,b.r/2));
			for (int n=0; n<temp.length; ++n)
			{
				plc[count]=g2circle1p(temp[n],A); ++count;
			}
		}
	}
	
	return plc;
}

//PCC: Apollonius' Problem with Two Circles and a Point
circle[] g2pcc(point A, circle b, circle c)
{
	circle[] pcc;
	int ib,ic;
	if (A @ b) {ib=0;} else if (inside(b,A)) {ib=-1;} else ib=1;
	if (A @ c) {ic=0;} else if (inside(c,A)) {ic=-1;} else ic=1;
	
	if (ib==1){
		if (ic==1){
			point[] temp=intersectionpoints(hyperbola(A,b.C,b.r/2),hyperbola(A,c.C,c.r/2));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		} else if (ic==0){
			point[] temp=intersectionpoints(hyperbola(A,b.C,b.r/2),line(A,c.C));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		} else {
			point[] temp=intersectionpoints(hyperbola(A,b.C,b.r/2),ellipse(A,c.C,c.r/2));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		}
	}
	
	if (ib==0){
		if (ic==1){
			point[] temp=intersectionpoints(line(A,b.C),hyperbola(A,c.C,c.r/2));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		} else if (ic==0) {
			return pcc;
		} else {
			point[] temp=intersectionpoints(line(A,b.C),ellipse(A,c.C,c.r/2));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		}
	}
	
	if (ib==-1){
		if (ic==1){
			point[] temp=intersectionpoints(ellipse(A,b.C,b.r/2),hyperbola(A,c.C,c.r/2));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		} else if (ic==0) {
			point[] temp=intersectionpoints(ellipse(A,b.C,b.r/2),line(A,c.C));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		} else {
			point[] temp=intersectionpoints(ellipse(A,b.C,b.r/2),ellipse(A,c.C,c.r/2));
			for (int n=0; n<temp.length; ++n){
				pcc.push(g2circle1p(temp[n],A));
			}
		}
	}
	
	return pcc;
}

line[] g2cl(circle a, line m)
{
	line[] g2cl;
	point[] t=intersectionpoints(perpendicular(a.C,m),a);
	vector v0=t[0]-a.C, v1=a.C-t[0];
	//g2cl[0] = shift(v0)*m; g2cl[1] = shift(v1)*m;
	g2cl.push(shift(v0)*m); g2cl.push(shift(v1)*m);
	return g2cl;
}

//Giao của line[] A và parabola[] B
point[] g2intersect(line[] A, parabola[] B)
{
	point[] output;
	int count=0;
	for(int k=0; k<A.length; ++k)
	for(int m=0; m<B.length; ++m)
	{
		point[] temp=intersectionpoints(A[k],B[m]);
		for (int n=0; n<temp.length; ++n)
		{
			output[count]=temp[n]; ++count;		
		}
	}
	return output;
}

point[] g2intersect(line[] A, line[] B)
{
	point[] output;
	int count=0;
	for(int k=0; k<A.length; ++k)
	for(int m=0; m<B.length; ++m)
	{
		if(parallel(A[k],B[m])==false) 
		{
			output[count]=intersectionpoint(A[k],B[m]); ++count;
		}
	}
	return output;
}

point[] g2intersect(line[] A, line m, parabola p)
{
	point[] output;
	int count=0;
	for(int k=0; k<A.length; ++k)
	{
		if (parallel(A[k],m)==false)
		{
			output[count]=intersectionpoint(A[k],m); ++count;
		}
		point[] temp=intersectionpoints(A[k],p);
		for (int n=0; n<temp.length; ++n)
		{
			output[count]=temp[n]; ++count;		
		}
	
	}
	return output;
}

line[] g2bis(line m, line n)
{
	line[] g2bis;
	if (parallel(m,n)) {
		point A = m.A;
		point B = intersectionpoint(n,perpendicular(A,m));
		g2bis.push(bisector(A,B));
		//g2bis[0]=bisector(A,B);
	} else {
		g2bis.push(bisector(m,n));
		g2bis.push(bisector(m,n,90));
		//point O = intersectionpoint(m,n);
		//g2bis[0]=bisector(m,n);
		//g2bis[1]=perpendicular(O,bisector(m,n));
		
	}
	return g2bis;
}

//LLC: Apollonius Problem with Two Lines and a Circle

circle[] g2llc(line m, line n, circle a)
{
	circle[] llc;
	point A = a.C;
	line[] bic=g2bis(m,n);
	line[] x=g2cl(a,m);
	int i0,i1;
	if (A @ x[0]) {i0=0;} else i0=1;
	if (A @ x[1]) {i1=0;} else i1=1;
	
	if (i0==1){
		if (i1==1){		
			parabola[] p; 
			for (int i=0; i<x.length; ++i ){
				p.push(parabola(A,x[i]));
			}
			point[] temp=g2intersect(bic,p);
			for (int i=0; i<temp.length; ++i){
			if (temp[i] @ m==false && temp[i] @ n==false){
					llc.push(g2circlePL(temp[i],m)); ++count;
				}
			}
		
		} else {
			point[] temp=g2intersect(bic,perpendicular(A,x[1]),parabola(A,x[0]));
			for (int i=0; i<temp.length; ++i){
			if (temp[i] @ m==false && temp[i] @ n==false) {
					llc.push(g2circlePL(temp[i],m)); ++count;
				}
			}
		}	
	}
	
	if (i0==0 && i1==1){
		point[] temp=g2intersect(bic,perpendicular(A,x[0]),parabola(A,x[1]));
		for (int i=0; i<temp.length; ++i) {
			if (temp[i] @ m==false && temp[i] @ n==false){
				llc.push(g2circlePL(temp[i],m)); ++count;
			}
		}
	}
	
	return llc;
}

point[] g2intersect(parabola[] A,parabola[] B)
{
	point[] output;
	int count=0;
	for(int k=0; k<A.length; ++k)
	for(int m=0; m<B.length; ++m)
	{
		point[] temp=intersectionpoints(A[k],B[m]);
		for (int n=0; n<temp.length; ++n)
		{
			output[count]=temp[n]; ++count;
		}
	}
	return output;
}

point[] g2intersect(parabola[] pa, line m, parabola p)
{
	point[] output;
	int count=0;
	for(int k=0; k<pa.length; ++k)
	{
		point[] temp1=intersectionpoints(pa[k],m);
		for (int n=0; n<temp1.length; ++n)
		{
			output[count]=temp1[n]; ++count;		
		}
		
		point[] temp2=intersectionpoints(pa[k],p);
		for (int n=0; n<temp2.length; ++n)
		{
			output[count]=temp2[n]; ++count;		
		}
	}
	
	return output;
}

point[] g2intersect(line m, parabola p, line n, parabola q)
{
	point[] output;
	int count=0;
	if (parallel(m,n)==false)
	{
		output[count]=intersectionpoint(m,n); ++count;
	}
	
	point[] temp1=intersectionpoints(m,q);
	for (int n=0; n<temp1.length; ++n)
	{
		output[count]=temp1[n]; ++count;		
	}
	
	point[] temp2=intersectionpoints(n,p);
	for (int n=0; n<temp2.length; ++n)
	{
		output[count]=temp2[n]; ++count;		
	}
	
	point[] temp3=intersectionpoints(p,q);
	for (int n=0; n<temp3.length; ++n)
	{
		output[count]=temp3[n]; ++count;		
	}
	
	return output;
	
}

// LCC: Apollonius Problem with Two Circles and a Line
circle[] g2lcc(line m, circle a, circle b)
{
	circle[] lcc;
	point A = a.C, B = b.C;
	line[] x = g2cl(a,m), y = g2cl(b,m);
	
	int i0, i1, j0, j1;
	
	if (A @ x[0]) {i0 = 0;} else i0=1;
	if (A @ x[1]) {i1 = 0;} else i1=1;
	if (B @ y[0]) {j0 = 0;} else j0=1;
	if (B @ y[1]) {j1 = 0;} else j1=1;
	
	if (i0==1 && i1==1){
		parabola[] pa;
		for (int i=0; i<x.length; ++i ){
			pa.push(parabola(A,x[i]));
		}
		
		if (j0==1 && j1==1){
			parabola[] pb;
			for (int i=0; i<y.length; ++i ){
				pb.push(parabola(B,y[i]));
			}
			point[] temp=g2intersect(pa,pb);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
		
		if (j0==1 && j1==0){
			line mb1 = perpendicular(B,y[1]);
			parabola pb0 = parabola(B,y[0]);
			point[] temp=g2intersect(pa,mb1,pb0);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
		
		if (j0==0 && j1==1){
			line mb0 = perpendicular(B,y[0]);
			parabola pb1 = parabola(B,y[1]);
			point[] temp=g2intersect(pa,mb0,pb1);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
	
	}
	
	if (i0==1 && i1==0){
		parabola pa0 = parabola(A,x[0]);
		line ma1 = perpendicular(A,x[1]);  
	
		if (j0==1 && j1==1){
			parabola[] pb; 
			for (int i=0; i<y.length; ++i){
				pb.push(parabola(B,y[i]));
			}
			point[] temp=g2intersect(pb,ma1,pa0);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
	
		if (j0==1 && j1==0){
			line mb1 = perpendicular(B,y[1]);
			parabola pb0 = parabola(B,y[0]);
			point[] temp=g2intersect(ma1,pa0,mb1,pb0);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
		
		if (j0==0 && j1==1){
			line mb0 = perpendicular(B,y[0]);
			parabola pb1 = parabola(B,y[1]);
			point[] temp=g2intersect(ma1,pa0,mb0,pb1);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
	
	}
	
	if (i0==0 && i1==1){
		parabola pa1 = parabola(A,x[1]);
		line ma0 = perpendicular(A,x[0]);  
		
		if (j0==1 && j1==1){
			parabola[] pb;
			for (int i=0; i<y.length; ++i){
				pb.push(parabola(B,y[i]));
			}
			point[] temp=g2intersect(pb,ma0,pa1);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
		
		if (j0==1 && j1==0){
			line mb1 = perpendicular(B,y[1]);
			parabola pb0 = parabola(B,y[0]);
			//int count=0;
			point[] temp=g2intersect(ma0,pa1,mb1,pb0);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
			
		if (j0==0 && j1==1){
			line mb0 = perpendicular(B,y[0]);
			parabola pb1 = parabola(B,y[1]);
			//int count=0;
			point[] temp=g2intersect(ma0,pa1,mb0,pb1);
			for (int i=0; i<temp.length; ++i){
				lcc.push(g2circlePL(temp[i],m));
			}
		}
	
	}
	
	return lcc;
}

point g2homoin(circle a, circle b)
{
	point A=a.C, B=b.C;
	point P=point(a,rotate(90,A)*B);
	point Q=point(b,rotate(90,B)*A);
	return intersectionpoint(line(A,B),line(P,Q));
}

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

//CCC: Apollonius Problem with Three Circles
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
