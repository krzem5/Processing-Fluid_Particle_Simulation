class Particle{
	float x;
	float y;
	float r;
	float d;
	float _idx;
	private float vx;
	private float vy;
	private boolean _upd;
	private boolean _c;



	Particle(float x,float y,float r){
		this.x=x;
		this.y=y;
		this.r=r;
		this.d=r*2;
		this._idx=this.y/this.d*width+this.x;
		this.vx=0;
		this.vy=0;
		this._upd=false;
		this._c=false;
	}



	void update1(float dt){
		this.vy+=GRAVITY*dt;
		this.x+=this.vx*dt;
		this.y+=this.vy*dt;
	}



	void update2(float dt,int i){
		if (this._upd){
			return;
		}
		this._upd=true;
		i=0;
		while (i<PARTICLE_COUNT){
			Particle p=pl[i];
			if (p==this){
				i++;
				continue;
			}
			if ((p.y>=this.y&&p.x+p.r+this.r>=this.x)||(p.y+p.r+this.r>=this.y&&p.x>=this.x)){
				float d=(p.x-this.x)*(p.x-this.x)+(p.y-this.y)*(p.y-this.y);
				if (d<(p.r+this.r)*(p.r+this.r)){
					this._c=true;
					p._c=true;
					d=(float)Math.sqrt(d);
					float nx;
					float ny;
					if (d==0){
						nx=0;
						ny=-1;
					}
					else{
						nx=(p.x-this.x)/d;
						ny=(p.y-this.y)/d;
					}
					float s=(p.vx-this.vx)*nx+(p.vy-this.vy)*ny;
					if (s>=0){
						this.x-=(p.x-this.x)*dt*0.5;
						this.y-=(p.y-this.y)*dt*0.5;
						p.x+=(p.x-this.x)*dt*0.5;
						p.y+=(p.y-this.y)*dt*0.5;
						this.vx=-s*nx*dt;
						this.vy=-s*ny*dt;
						p.vx+=s*nx*dt;
						p.vy+=s*ny*dt;
					}
				}
			}
			i++;
		}
		if (this.x<this.r){
			this.x=this.r;
			this.vx*=-1;
		}
		else if (this.x>width-this.r){
			this.x=width-this.r;
			this.vx*=-1;
		}
		if (this.y<this.r){
			this.y=this.r;
			this.vy=0;
		}
		else if (this.y>height-this.r){
			this.y=height-this.r;
			this.vy=0;
		}
	}



	void draw(){
		this._idx=this.y/this.d*width+this.x;
		if (this._c){
			fill(0,0,255);
		}
		circle(this.x,this.y,this.d);
		this._upd=false;
		this._c=false;
	}
}
