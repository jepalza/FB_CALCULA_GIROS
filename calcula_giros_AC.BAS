#Include "crt\math.bi" ' para redondeos con FLOOR y CEIL

Function REDONDEO(A As Single) As Single
	Dim D As Single
	Dim f As Single
	Dim dd As Single
	
	d=ceil(A/2.5)*2.5
	f=floor(A/2.5)*2.5

	If d<0 Then d=360+d
	If f<0 Then f=360+f
	If d>360 Then d=d-360
	If f>360 Then f=f-360

	If abs(Abs(d)-Abs(A))>abs(Abs(f)-Abs(A)) Then 
		Return f
	Else
		Return d
	EndIf

End Function

Function CAD(a As single) As String
	Return Trim(Str(A))
End Function


' fondo blanco, mas amigable
Color 0,15:Cls

Color 7
' Joseba Epalza 2023
	ellepal:Data 111,74,86,64,71,68,5,96,85,68,73,95,68,5,23,21,23,22
	Dim As String lepal=""
	Dim As Integer n
	Restore ellepal
	For f As Integer=1 To 18
		Read n
		lepal=lepal+Chr(n Xor 37)
	Next
	Print lepal


Color 0
Print "Teclea los tres vectores que conforman los cosenos directores del eje a tratar " 
Print "El eje debe ser normal al plano inclinado y debe estar activo deja el principal, no el girado"
Print ""
Print "La 'X' del eje a calcular debe ir como en el CNC, en direccion 'plano mesa XY' no hacia abajo o arriba"
Print "y la 'Z' apuntando hacia afuera del plano inclinado, no hacia dentro"
Print
DENUEVO:

Dim As Integer f,g
Dim As Double PI,X,Y,Z,I,J,K,L,A,B,C,W
Dim As Double qW,qW4,qX,qY,qZ

Dim As Double CNORM,CSIMX,CSIMY ' C normales y simetricos en x e y

' TRES VECTORES DE GIRO
Dim As Double X1,Y1,Z1
Dim As Double X2,Y2,Z2
Dim As Double X3,Y3,Z3

PI=3.141592653589793238462643383

Dim As Integer giroprueba=0
Dim As String sa,sb,sc

Line Input "Linea 1 :",sa : If Len(sa)<3 Then giroprueba=Val(sa):GoTo prueba
Line Input "Linea 2 :",sb
Line Input "Linea 3 :",sc


sa=UCase(sa)
sb=UCase(sb)
sc=UCase(sc)

' primer grupo XYZ
A=InStr(sa,"X")
sa=Mid(sa,a+1)
A=InStr(sa,"X")
X1=Val(Mid(sa,A+1))
A=InStr(sa,"Y")
Y1=Val(Mid(sa,A+1))
A=InStr(sa,"Z")
Z1=Val(Mid(sa,A+1))

' primer grupo XYZ
A=InStr(sb,"X")
sb=Mid(sb,a+1)
A=InStr(sb,"X")
X2=Val(Mid(sb,A+1))
A=InStr(sb,"Y")
Y2=Val(Mid(sb,A+1))
A=InStr(sb,"Z")
Z2=Val(Mid(sb,A+1))

' primer grupo XYZ
A=InStr(sc,"X")
sc=Mid(sc,a+1)
A=InStr(sc,"X")
X3=Val(Mid(sc,A+1))
A=InStr(sc,"Y")
Y3=Val(Mid(sc,A+1))
A=InStr(sc,"Z")
Z3=Val(Mid(sc,A+1))

'Print X1,Y1,Z1
'Print X2,Y2,Z2
'Print X3,Y3,z3



' ====================================================
'  giros de pruebas ...
prueba:
If giroprueba=1 Then
 ' giro A45 C45
 X1= 0.707: Y1= 0.707: Z1= 0.000
 X2=-0.500: Y2= 0.500: Z2= 0.707
 X3= 0.500: Y3=-0.500: Z3= 0.707
ElseIf giroprueba=2 Then
 ' giro A15 C330
 X1=-0.027 :Y1= 0.977 :Z1= 0.211 
 X2=-0.992 :Y2= 0.000 :Z2=-0.128 
 X3=-0.125 :Y3=-0.213 :Z3= 0.969 
ElseIf giroprueba=3 Then
 ' giro A12.5 C55
 X1= 0.991 :Y1= 0.133 :Z1= 0.000
 X2=-0.073 :Y2= 0.543 :Z2= 0.837
 X3= 0.112 :Y3=-0.829 :Z3= 0.547
ElseIf giroprueba=4 Then
 ' giro A30 C280
 X1= 0.174 :Y1=-0.985 :Z1= 0.000
 X2= 0.853 :Y2= 0.150 :Z2= 0.500
 X3=-0.492 :Y3=-0.087 :Z3= 0.866
End If
' =====================================================



Color 0,15
Print
Print "Cosenos Directores de Entrada:"
Print Using "X1:##.### Y1:##.### Z1:##.###";X1;Y1;Z1
Print Using "X2:##.### Y2:##.### Z2:##.###";X2;Y2;Z2
Print Using "X3:##.### Y3:##.### Z3:##.###";X3;Y3;Z3


Dim As Double quat(3,3) ' matriz 4x4 , de la cual, la parte superior 3x3 es la real
quat(0,0)=X1: quat(0,1)=Y1: quat(0,2)=Z1: quat(0,3)=1
quat(1,0)=X2: quat(1,1)=Y2: quat(1,2)=Z2: quat(1,3)=1
quat(2,0)=X3: quat(2,1)=Y3: quat(2,2)=Z3: quat(2,3)=1
quat(3,0)= 0: quat(3,1)= 0: quat(3,2)= 0: quat(3,3)=1



		Dim as double s
		dim as double trace
		  trace = quat(0,0) + quat(1,1) + quat(2,2)
		  if( trace > 0 ) Then
			 s  = 0.5f / sqr(trace+ 1.0f)
			 qW = 0.25f / s
			 qX = ( quat(2,1) - quat(1,2) ) * s
			 qY = ( quat(0,2) - quat(2,0) ) * s
			 qZ = ( quat(1,0) - quat(0,1) ) * s
		  Else 
			 if ( quat(0,0) > quat(1,1) ) and ( quat(0,0) > quat(2,2) ) then
				s  = 2.0f * sqr( 1.0f + quat(0,0) - quat(1,1) - quat(2,2))
				qW = (quat(2,1) - quat(1,2) ) / s
				qX = 0.25f * s
				qY = (quat(0,1) + quat(1,0) ) / s
				qZ = (quat(0,2) + quat(2,0) ) / s
			 elseif (quat(1,1) > quat(2,2)) then
				s  = 2.0f * sqr( 1.0f + quat(1,1) - quat(0,0) - quat(2,2))
				qW = (quat(0,2) - quat(2,0) ) / s
				qX = (quat(0,1) + quat(1,0) ) / s
				qY = 0.25f * s
				qZ = (quat(1,2) + quat(2,1) ) / s
			 else 
				s  = 2.0f * sqr( 1.0f + quat(2,2) - quat(0,0) - quat(1,1) )
				qW = (quat(1,0) - quat(0,1) ) / s
				qX = (quat(0,2) + quat(2,0) ) / s
				qY = (quat(1,2) + quat(2,1) ) / s
				qZ = 0.25f * s
			 end if
		  end if

		

	 Dim As Double mr(3,3)
	 Dim As Double xx=qX*qX
	 Dim As Double xy=qX*qy
	 Dim As Double xz=qX*qZ
	 Dim As Double xw=qX*qW
	 
	 Dim As Double yy=qy*qY
	 Dim As Double yz=qY*qz
	 Dim As Double yw=qy*qW
	 
	 Dim As Double zz=qZ*qz
	 Dim As Double zw=qz*qW
	       
	mr(0,0) = 1 - 2 * ( yy + zz )
	mr(0,1) =     2 * ( xy - zw )
	mr(0,2) =     2 * ( xz + yw )
	
	mr(1,0) =     2 * ( xy + zw )
	mr(1,1) = 1 - 2 * ( xx + zz )
	mr(1,2) =     2 * ( yz - xw )
	
	mr(2,0) =     2 * ( xz - yw )
	mr(2,1) =     2 * ( yz + xw )
	mr(2,2) = 1 - 2 * ( xx + yy )
	
	mr(0,3) = 0 : mr(1,3) = 0 : mr(2,3) = 0
	
	mr(3,0) = 0
	mr(3,1) = 0
	mr(3,2) = 0
	mr(3,3) = 1
           
            Dim As Double Roll  = ATan2(mr(1,2), mr(2,2))
				Dim As Double c2    = Sqr(mr(0,0)^2 + mr(0,1)^2)
				Dim As Double Pitch = atan2(-mr(0,2), c2)
				Dim As Double s1    = sin(Roll), c1 = cos(Roll)
				Dim As Double Yaw   = atan2(s1*mr(2,0) - c1*mr(1,0), c1*mr(1,1)-s1*mr(2,1))
            
   'Print (X*180)/PI,(Y*180)/PI,(Z*180)/PI
   A=Int(((Roll*180)/PI)*100)/100
   B=Int((Pitch*180)/PI)*100/100
   C=int(((Yaw*180)/PI)*100)/100
   
   'If Sgn(A)=-1 Then
   	'A=A*-1
   	'C=180+C
   'EndIf
   
   
   CNORM=C
   If Sgn(CNORM)=-1 Then
   	CNORM=360+CNORM
   EndIf
   
   CSIMX=360-CNORM
   If Sgn(CSIMX)=-1 Then
   	CSIMX=360+CSIMX
   EndIf
   
   CSIMY=180-CNORM
   If Sgn(CSIMY)=-1 Then
   	CSIMY=360+CSIMY
   EndIf
   
   Color 1,15
   print
   Print "GIRO REAL   : A";CAD(A);" C";CAD(C)'; "   (el otro):";B
   Print
   Color 2,15
   Print "C POSITIVO  : A";CAD(A);" C";CAD(CNORM);Tab(40); "   REDONDEO A 2.5 GRADOS: A";CAD(REDONDEO(A)); " C";CAD(REDONDEO(CNORM))
   Color 3,15
   Print "GIRO SIM X  : A";CAD(A);" C";CAD(CSIMX);Tab(40); "   REDONDEO A 2.5 GRADOS: A";CAD(REDONDEO(A)); " C";CAD(REDONDEO(CSIMX))
   Color 4,15
   Print "GIRO SIM Y  : A";CAD(A);" C";CAD(CSIMY);Tab(40); "   REDONDEO A 2.5 GRADOS: A";CAD(REDONDEO(A)); " C";CAD(REDONDEO(CSIMY))
   Color 5,15
   Print
   Print "GIRO *FP40* : B";CAD(A);" C";CAD(90+C );Tab(40); "   REDONDEO A 2.5 GRADOS: B";CAD(REDONDEO(A)); " C";CAD(REDONDEO(90+C))
	Color 0,15
	Print
	
	Color 4,15
   Print "PULSA <ESC> PARA ACABAR, O CUALQUIER TECLA PARA CALCULAR NUEVO GIRO ...";
	Color 0,15
	sa=""
	While sa=""
		sa=InKey
		If sa=Chr(27) Then End
	Wend
	cls

GoTo DENUEVO
