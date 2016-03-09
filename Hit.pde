public class Hit
{
  private float rayT; //the "t" value on the ray that results in this hit
  private PVector hitPoint;
  private Sphere object;
  private int myColor;
  
  public Hit(PVector hitPoint, Sphere object, float rayT)
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
  
  public Sphere getObject()
  {
    return object;
  }
  
  /**
   * Updates myColor based on the lights in the scene.
   * Call this before getColor() to get an accurate color.
   */
  public void applyLights(List<Light> lights)
  {
    PVector n = PVector.sub(hitPoint, object.getCenter()).normalize();
    
    float rTotal = 0;
    float gTotal = 0;
    float bTotal = 0;
    
    for(Light light: lights)
    {
      PVector l = PVector.sub(light.getLocation(), hitPoint).normalize();
      float nDotL = PVector.dot(n, l);
      nDotL = Math.max(0, nDotL);
      
      float r = light.getRed() * nDotL;
      float g = light.getGreen() * nDotL;
      float b = light.getBlue() * nDotL;
      
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