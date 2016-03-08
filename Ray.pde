import java.util.List;

public class Ray
{
  //each ray begins at (0, 0, 0), and has a normalized "direction".
  // Thus (0, 0, 0) + t * direction can be
  //considered the parametric definition of the ray
  private PVector origin;
  private PVector direction;
  
  public Ray(PVector direction)
  {
    this.origin = new PVector(0, 0, 0);
    this.direction = direction.normalize();
  }
  
  public Hit castRay(List<Sphere> spheres)
  {
    Hit closestHit = null;
    
    for(Sphere sphere: spheres)
    {
      Hit hit = intersectsWith(sphere);
      
      if(hit != null)
      {
        if(closestHit == null || hit.getRayT() < closestHit.getRayT())
        {
          closestHit = hit;
        }
      }
    }
    
    return closestHit;
  }
  
  /**
   * Tests if this ray intersects with the given sphere.
   * If so, it returns a Hit object describing the collision
   * (the closest one, as a ray will intersect a sphere twice
   * if it isn't tangent. If not, it returns null.
   */
  public Hit intersectsWith(Sphere sphere)
  {
    PVector sphereCenter = sphere.getCenter();
    float radius = sphere.getRadius();
    
    float discriminant = (float)Math.pow(PVector.dot(direction, PVector.sub(origin, sphereCenter)), 2) -
        (PVector.dot(direction, direction) * (PVector.dot(PVector.sub(origin, sphereCenter), PVector.sub(origin, sphereCenter)) - radius * radius));
    
    if(discriminant < 0)
    {
      return null;
    }
    
    float t1 = (float)(PVector.dot(PVector.mult(direction,-1), PVector.sub(origin, sphereCenter)) + Math.sqrt(discriminant)) / (PVector.dot(direction, direction));
    float t2 = (float)(PVector.dot(PVector.mult(direction,-1), PVector.sub(origin, sphereCenter)) - Math.sqrt(discriminant)) / (PVector.dot(direction, direction));
    
    float t = Math.min(t1, t2);
    
    return new Hit(PVector.add(origin, PVector.mult(direction, t)), sphere, t);
  }
  
  @Override
  public String toString()
  {
    return String.format("Ray from (%.2f, %.2f, %.2f) to (%.2f, %.2f, %.2f)",
      origin.x, origin.y, origin.z, direction.x, direction.y, direction.z);
  }
}