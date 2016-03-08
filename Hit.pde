public class Hit
{
  private float rayT; //the "t" value on the ray that results in this hit
  private PVector hitPoint;
  private Sphere object;
  
  public Hit(PVector hitPoint, Sphere object, float rayT)
  {
    this.hitPoint = hitPoint;
    this.object = object;
    this.rayT = rayT;
  }
  
  public float getRayT()
  {
    return rayT;
  }
}