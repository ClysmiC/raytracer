public class Sphere
{
  private PVector center;
  private float radius;
  
  public Sphere(PVector center, float radius)
  {
    this.center = center;
    this.radius = radius;
  }
  
  public PVector getCenter()
  {
    return center;
  }
  
  public float getRadius()
  {
    return radius;
  }
}