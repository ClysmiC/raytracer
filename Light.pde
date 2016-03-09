public class Light
{
  private PVector location;
  private float red;
  private float green;
  private float blue;
  
  public Light(PVector location, float red, float green, float blue)
  {
    this.location = location;
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  
  public PVector getLocation()
  {
    return location;
  }
  
  public float getRed()
  {
    return red;
  }
  
  public float getGreen()
  {
    return green;
  }
  
  public float getBlue()
  {
    return blue;
  }
}