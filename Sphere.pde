public class Sphere extends SceneObject
{
  private PVector center;
  private float radius;
  
  public Sphere(PVector center, float radius, Surface surface)
  {
    this.center = center;
    this.radius = radius;
    this.surface = surface;
  }
  
  public PVector getCenter()
  {
    return center;
  }
  
  public float getRadius()
  {
    return radius;
  }
  
  @Override
  public String toString()
  {
    return String.format("Sphere at (%.2f, %.2f, %.2f) -- Radius: %.2f", center.x, center.y, center.z, radius);
  }
}