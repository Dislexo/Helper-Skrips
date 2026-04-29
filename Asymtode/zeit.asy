include feynmanmf; //https://github.com/alejandrogallo/feynmanmf.asy
// This file was written for creating goldstone diagrams for calculating <j(t)j> in Linerized couple cluster

//Eingänge
real d = 16*0.16;
real b = 16*0.4;
pair ebr = (+d,-b);
pair ebl = (-d,-b);
pair eur = (+d,+b);
pair eul = (-d,+b);

//draw box
void zeit(pair center, real Breite = 2*16*0.4,string text = "$X$"){
    pair br = (+Breite/2,-Breite/2);
    pair bl = (-Breite/2,-Breite/2);
    draw(center+br--center+bl--center-br--center-bl--cycle, currentpen);
    label(text, center, 0E, fontsize(Breite/1.6));
}

void dbox(pair center,real Breite = 2*16*0.4,real versatz = 16){
    zeit(center,Breite,text = "$G$");
    zeit(center+(versatz,0),Breite,text = "$G$");
    //draw(center-(Breite/2,0)--center-(1.5*Breite/2,0), dotted);
    //draw(center+(Breite/2,0)--center+(versatz,0)-(Breite/2,0), dotted);
    //draw(center+(versatz,0)+(Breite/2,0)--center+(versatz,0)+(1.5*Breite/2,0), dotted);
    //label(time, center+(1*versatz,0)+(1.5*Breite,0), 0E, fontsize(Breite/2));
}

void sbox(pair center,real Breite = 2*16*0.4, string time = "t"){
    zeit(center,Breite);
   //draw(center-(2*Breite,0)--center-(Breite/2,0), dotted);
   //draw(center+(Breite/2,0)--center+(1.5*Breite/2,0), dotted);
    label(time, center+(1.5*Breite,0), 0E, fontsize(Breite/2));
}


//fermionen mit automatische farben  #increase strichstärke.
void cfermion(pair start,pair end,real angle){
if(end.y<start.y){
drawFermion(fermion(start--end, angle), erasebg=false,blue + linewidth(1bp));
}else{
drawFermion(fermion(start--end, angle), erasebg=false,red + linewidth(1bp));
}}

//Amplituden mit Beschriftung,
void Amp(pair start,pair end,real Breite = 2*16*0.4,string time ="t",bool xinclude=true){
    draw(end -- end+(Breite,0), dotted);
    label(time, end+(1.5*Breite,0), 0E, fontsize(Breite/2));
    if(xinclude){draw(start-(0,0.7)--start+(0,0.7)--end+(0,0.7)--end-(0,0.7)--cycle, currentpen);}
    else{draw(start--end, currentpen);}
}

real supersize = 5;
void SupJ(pair center){
    draw(circle(center, supersize),linewidth(0.2mm));
    label("J", center, 0E, fontsize(1));
}

void SupUJU(pair center){
    SupJ(center);
    draw(center+(supersize,supersize)--center+(supersize,-supersize)--center-(supersize,supersize)--center-(supersize,-supersize)--cycle, linewidth(0.2mm));
}

void UJ(pair center){
   dot(center, 3+black);
    draw(center+(supersize,supersize)--center+(supersize,-supersize)--center-(supersize,supersize)--center-(supersize,-supersize)--cycle, linewidth(0.2mm));
}

