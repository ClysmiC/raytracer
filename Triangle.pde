public class Triangle extends SceneObject
{
  private PVector p1, p2, p3;
  
  public Triangle(PVector p1, PVector p2, PVector p3, Surface surface)
  {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.surface = surface;
  }
  
  public PVector getP1()
  {
    return p1;
  }
  
  public PVector getP2()
  {
    return p2;
  }
  
  public PVector getP3()
  {
    return p3;
  }
  
  @Override
  public String toString()
  {
    return String.format("P1 (%.2f, %.2f, %.2f) : P2 (%.2f, %.2f, %.2f) : P3 (%.2f, %.2f, %.2f)",
                              p1.x, p1.y, p1.z,       p2.x, p2.y, p2.z,       p3.x, p3.y, p3.z);
  }
}