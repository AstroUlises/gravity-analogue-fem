// FEM-01/A: axisymmetric benchmark geometry (r,z), SI units.
// Physical Surface tags: Air=1, Copper=2, Magnet=3.
// Physical Curve tags: FarBoundary=10, Axis=11.
// MeshScale can be overridden: gmsh ... -setnumber MeshScale 0.7
SetFactory("Built-in");
DefineConstant[ MeshScale = {1.0, Name "Parameters/MeshScale"} ];

am   = 0.0063;
R1   = 0.00729;
R2   = 0.00796;
Rfar = 0.045;
Lm   = 0.0064;
Ztube = 0.080;
Zfar  = 0.120;

// Radial grid: 0, am, R1, R2, Rfar
// Axial grid: -Zfar, -Ztube, -Lm/2, +Lm/2, +Ztube, +Zfar
// Point mesh sizes: fine through magnet/gap/copper; graded in far air.

Point(1)  = {0,    -Zfar, 0, 0.0015*MeshScale};
Point(2)  = {am,   -Zfar, 0, 0.0010*MeshScale};
Point(3)  = {R1,   -Zfar, 0, 0.00040*MeshScale};
Point(4)  = {R2,   -Zfar, 0, 0.00040*MeshScale};
Point(5)  = {Rfar, -Zfar, 0, 0.0030*MeshScale};
Point(6)  = {0,    -Ztube,0, 0.0008*MeshScale};
Point(7)  = {am,   -Ztube,0, 0.0005*MeshScale};
Point(8)  = {R1,   -Ztube,0, 0.00018*MeshScale};
Point(9)  = {R2,   -Ztube,0, 0.00018*MeshScale};
Point(10) = {Rfar, -Ztube,0, 0.0020*MeshScale};
Point(11) = {0,    -Lm/2, 0, 0.00020*MeshScale};
Point(12) = {am,   -Lm/2, 0, 0.00012*MeshScale};
Point(13) = {R1,   -Lm/2, 0, 0.00010*MeshScale};
Point(14) = {R2,   -Lm/2, 0, 0.00010*MeshScale};
Point(15) = {Rfar, -Lm/2, 0, 0.0020*MeshScale};
Point(16) = {0,     Lm/2, 0, 0.00020*MeshScale};
Point(17) = {am,    Lm/2, 0, 0.00012*MeshScale};
Point(18) = {R1,    Lm/2, 0, 0.00010*MeshScale};
Point(19) = {R2,    Lm/2, 0, 0.00010*MeshScale};
Point(20) = {Rfar,  Lm/2, 0, 0.0020*MeshScale};
Point(21) = {0,     Ztube,0, 0.0008*MeshScale};
Point(22) = {am,    Ztube,0, 0.0005*MeshScale};
Point(23) = {R1,    Ztube,0, 0.00018*MeshScale};
Point(24) = {R2,    Ztube,0, 0.00018*MeshScale};
Point(25) = {Rfar,  Ztube,0, 0.0020*MeshScale};
Point(26) = {0,     Zfar, 0, 0.0015*MeshScale};
Point(27) = {am,    Zfar, 0, 0.0010*MeshScale};
Point(28) = {R1,    Zfar, 0, 0.00040*MeshScale};
Point(29) = {R2,    Zfar, 0, 0.00040*MeshScale};
Point(30) = {Rfar,  Zfar, 0, 0.0030*MeshScale};

// Horizontal lines, 4 per axial level.
Line(101)={1,2}; Line(102)={2,3}; Line(103)={3,4}; Line(104)={4,5};
Line(105)={6,7}; Line(106)={7,8}; Line(107)={8,9}; Line(108)={9,10};
Line(109)={11,12}; Line(110)={12,13}; Line(111)={13,14}; Line(112)={14,15};
Line(113)={16,17}; Line(114)={17,18}; Line(115)={18,19}; Line(116)={19,20};
Line(117)={21,22}; Line(118)={22,23}; Line(119)={23,24}; Line(120)={24,25};
Line(121)={26,27}; Line(122)={27,28}; Line(123)={28,29}; Line(124)={29,30};

// Vertical lines, 5 radial levels x 5 axial intervals.
Line(201)={1,6};   Line(202)={6,11};  Line(203)={11,16}; Line(204)={16,21}; Line(205)={21,26};
Line(206)={2,7};   Line(207)={7,12};  Line(208)={12,17}; Line(209)={17,22}; Line(210)={22,27};
Line(211)={3,8};   Line(212)={8,13};  Line(213)={13,18}; Line(214)={18,23}; Line(215)={23,28};
Line(216)={4,9};   Line(217)={9,14};  Line(218)={14,19}; Line(219)={19,24}; Line(220)={24,29};
Line(221)={5,10};  Line(222)={10,15}; Line(223)={15,20}; Line(224)={20,25}; Line(225)={25,30};

// 20 conformal quadrilateral patches. Surface ID = 301 + 4*j + i.
// j=0..4 bottom->top; i=0..3 axis->outer radius.
Curve Loop(401)={101,206,-105,-201}; Plane Surface(301)={401};
Curve Loop(402)={102,211,-106,-206}; Plane Surface(302)={402};
Curve Loop(403)={103,216,-107,-211}; Plane Surface(303)={403};
Curve Loop(404)={104,221,-108,-216}; Plane Surface(304)={404};

Curve Loop(405)={105,207,-109,-202}; Plane Surface(305)={405};
Curve Loop(406)={106,212,-110,-207}; Plane Surface(306)={406};
Curve Loop(407)={107,217,-111,-212}; Plane Surface(307)={407};
Curve Loop(408)={108,222,-112,-217}; Plane Surface(308)={408};

Curve Loop(409)={109,208,-113,-203}; Plane Surface(309)={409};
Curve Loop(410)={110,213,-114,-208}; Plane Surface(310)={410};
Curve Loop(411)={111,218,-115,-213}; Plane Surface(311)={411};
Curve Loop(412)={112,223,-116,-218}; Plane Surface(312)={412};

Curve Loop(413)={113,209,-117,-204}; Plane Surface(313)={413};
Curve Loop(414)={114,214,-118,-209}; Plane Surface(314)={414};
Curve Loop(415)={115,219,-119,-214}; Plane Surface(315)={415};
Curve Loop(416)={116,224,-120,-219}; Plane Surface(316)={416};

Curve Loop(417)={117,210,-121,-205}; Plane Surface(317)={417};
Curve Loop(418)={118,215,-122,-210}; Plane Surface(318)={418};
Curve Loop(419)={119,220,-123,-215}; Plane Surface(319)={419};
Curve Loop(420)={120,225,-124,-220}; Plane Surface(320)={420};

// Magnet is r<am, |z|<Lm/2: surface 309.
Physical Surface("Magnet", 3) = {309};
// Copper shell R1<r<R2, -Ztube<z<Ztube: surfaces 307,311,315.
Physical Surface("Copper", 2) = {307,311,315};
// Everything else is air.
Physical Surface("Air", 1) = {301,302,303,304,305,306,308,310,312,313,314,316,317,318,319,320};

// Artificial far boundary and symmetry axis.
Physical Curve("FarBoundary", 10) = {101,102,103,104,121,122,123,124,221,222,223,224,225};
Physical Curve("Axis", 11) = {201,202,203,204,205};

Mesh.Algorithm = 6;
Mesh.Optimize = 1;
Mesh.MshFileVersion = 2.2;
