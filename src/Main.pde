final static int PARTICLE_COUNT=1000;
final static float PARTICLE_SIZE=8;
final static float PARTICLE_WEIGHT_COEFFICIENT=0.5;
final static float PARTICLE_REPULTION_COEFFICIENT=2;
final static float PARTICLE_AVERAGE_WEIGHT=0.5;
final static float GRAVITY=1;



Particle[] pl;
int _lt=-1;



void setup(){
	size(1920,1080);
	frameRate(60);
	colorMode(HSB,360,100,100);
	noStroke();
	pl=new Particle[PARTICLE_COUNT];
	for (int i=0;i<PARTICLE_COUNT;i++){
		pl[i]=new Particle(random(width*0.25,width*0.75),random(height*0.25,height*0.5),PARTICLE_SIZE);
	}
}



void draw(){
	if (_lt==-1){
		_lt=millis()-1;
	}
	int t=millis();
	float dt=(t-_lt)*1e-3f;
	_lt=t;
	_quicksort(0,PARTICLE_COUNT-1);
	for (Particle p:pl){
		p.update1(dt);
	}
	int i=0;
	for (Particle p:pl){
		p.update2(dt,i+1);
		i++;
	}
	background(0);
	fill(255);
	i=0;
	for (Particle p:pl){
		fill(i*360/PARTICLE_COUNT,100,100);
		p.draw();
		i++;
	}
}



void _quicksort(int i,int j){
	if (i<j){
		int k=_partition(i,j);
		_quicksort(i,k-1);
		_quicksort(k+1,j);
	}
}



int _partition(int i,int j){
	float p=pl[j]._idx;
	int o=i;
	while (i<j){
		if (pl[i]._idx<p){
			Particle tmp=pl[o];
			pl[o]=pl[i];
			pl[i]=tmp;
			o++;
		}
		i++;
	}
	Particle tmp=pl[o];
	pl[o]=pl[j];
	pl[j]=tmp;
	return o;
}
