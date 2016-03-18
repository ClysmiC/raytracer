public class Hit
{
  private float rayT; //the "t" value on the ray that results in this hit
  private PVector hitPoint;
  private SceneObject object;
  private int myColor;
  
  public Hit(PVector hitPoint, SceneObject object, float rayT)
  {
    this.hitPoint = hitPoint;
    this.object = object;
    this.rayT = rayT;
    myColor = color(1, 1, 1); //default to white
  }
  
  public float getRayT()
  {
    return rayT;
  }
  
  public PVector getHitPoint()
  {
    return hitPoint;
  }
  
  public SceneObject getObject()
  {
    return object;
  }
  
  /**
   * Updates myColor based on the lights in the scene.
   * Call this before getColor() to get an accurate color.
   */
  public void applyLights(List<Light> lights)
  {
    Surface surface = object.getSurface();
    
    PVector n = null;
    
    if(object instanceof Sphere)
    {
      n = PVector.sub(hitPoint, ((Sphere)object).getCenter()).normalize();
    }
    else if (object instanceof Triangle)
    {
      Triangle triangle = (Triangle)object;
      PVector edge1 = PVector.sub(triangle.getP1(), triangle.getP2());
      PVector edge2 = PVector.sub(triangle.getP1(), triangle.getP3());
      n = edge1.cross(edge2);
      n.normalize();
      
      //if normal is pointing away from us, flip it! (we are looking down negative Z axis)
      if(n.z <= 0)
      {
        n = PVector.sub(new PVector(0, 0, 0), n);
      }
    }
    else
    {
      System.out.println("Unsupported scene object");
    }
    
    PVector e = new PVector(0, 0, 0); //our ray tracer casts rays from (0, 0, 0)
    
    float rTotal = surface.getAmbientR();
    float gTotal = surface.getAmbientG();
    float bTotal = surface.getAmbientB();
    
    for(Light light: lights)
    {
      PVector l = PVector.sub(light.getLocation(), hitPoint).normalize();
      float nDotL = PVector.dot(n, l);
      nDotL = Math.max(0, nDotL);
      
      PVector h = PVector.div(PVector.add(e, l), PVector.add(e, l).mag());
      float cPhong = (float)Math.pow(PVector.dot(h, n), surface.getPhongExp());
      
      float r = surface.getDiffuseR() * light.getRed() * nDotL + cPhong * surface.getSpecularR() * light.getRed();;
      float g = surface.getDiffuseG() * light.getGreen() * nDotL + cPhong * surface.getSpecularG() * light.getGreen();;
      float b = surface.getDiffuseB() * light.getBlue() * nDotL + cPhong * surface.getSpecularB() * light.getBlue();;
      
      rTotal += r;
      gTotal += g;
      bTotal += b;
    }
    
    rTotal = Math.min(rTotal, 1);
    gTotal = Math.min(gTotal, 1);
    bTotal = Math.min(bTotal, 1);
    
    myColor = color(rTotal, gTotal, bTotal);
  }
  
  public int getColor()
  {
    return myColor;
  }
}