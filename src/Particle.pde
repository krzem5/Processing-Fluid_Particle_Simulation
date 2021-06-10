class Particle{
	float x;
	float y;
	float r;
	float d;
	float _idx;
	private float vx;
	private float vy;
	private float _x;
	private float _y;
	// private float _h;



	Particle(float x,float y,float r){
		this.x=x;
		this.y=y;
		this.r=r;
		this.d=r*2;
		this._idx=this.y/this.d*width+this.x;
		this.vx=0;
		this.vy=0;
		this._x=x;
		this._y=y;
		// this._h=0;
	}



	void update1(float dt){
		this._x+=this.vx*dt;
		this._y+=this.vy*dt;
		this.vy+=GRAVITY;
	}



	void update2(float dt,int i){
		// float w=0;
		// ArrayList<ParticleCollisionData> cl=new ArrayList<ParticleCollisionData>();
		while (i<PARTICLE_COUNT){
			Particle p=pl[i];
			if (p==this){
				i++;
				continue;
			}
			float d=p.r+this.r;
			if (p.y-this.y>d){
				break;
			}
			if (p.x>=this.x&&p.x-this.x<=d){
				this._x-=(p.x-this.x)*dt;
				this._y-=(p.y-this.y)*dt;
				p._x+=(p.x-this.x)*dt;
				p._y+=(p.y-this.y)*dt;
				this.vx=0;
				this.vy=0;
				p.vx=0;
				p.vy=0;
				// float m=(float)Math.sqrt((p.x-this.x)*(p.x-this.x)+(p.y-this.y)*(p.y-this.y));
				// float wv=1-m/d;
				// w+=wv;
				// if (m==0){
				// 	m=1;
				// }
				// cl.add(new ParticleCollisionData(p,wv,(p.x-this.x)/m,(p.y-this.y)/m));
				// p.update(dt,i);
			}
			i++;
		}
		if (this._x<this.r){
			this._x=this.r;
			this.vx=0;
		}
		else if (this._x>width-this.r){
			this._x=width-this.r;
			this.vx=0;
		}
		if (this._y<this.r){
			this._y=this.r;
			this.vy=0;
		}
		else if (this._y>height-this.r){
			this._y=height-this.r;
			this.vy=0;
		}
		// if (w>PARTICLE_AVERAGE_WEIGHT){
		// 	this._h=PARTICLE_WEIGHT_COEFFICIENT*(w-PARTICLE_AVERAGE_WEIGHT);
		// 	for (ParticleCollisionData pc:cl){
		// 		this.vx-=PARTICLE_REPULTION_COEFFICIENT*(this._h+pc.p._h)*pc.w*pc.dx;
		// 		this.vy-=PARTICLE_REPULTION_COEFFICIENT*(this._h+pc.p._h)*pc.w*pc.dy;
		// 		pc.p.vx+=PARTICLE_REPULTION_COEFFICIENT*(this._h+pc.p._h)*pc.w*pc.dx;
		// 		pc.p.vy+=PARTICLE_REPULTION_COEFFICIENT*(this._h+pc.p._h)*pc.w*pc.dy;
		// 	}
		// }
		// else{
		// 	this._h=0;
		// }
	}



	void draw(){
		this.x=this._x;
		this.y=this._y;
		this._idx=this.y/this.d*width+this.x;
		circle(this.x,this.y,this.d);
		// this._upd=false;
	}



	class ParticleCollisionData{
		Particle p;
		float w;
		float dx;
		float dy;



		ParticleCollisionData(Particle p,float w,float dx,float dy){
			this.p=p;
			this.w=w;
			this.dx=dx;
			this.dy=dy;
		}
	}
}
