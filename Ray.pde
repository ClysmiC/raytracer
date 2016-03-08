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
    
    float discriminant = (float)Math.pow(direction.dot(origin.sub(sphereCenter)), 2) -
        (direction.dot(direction) * (origin.sub(sphereCenter).dot(origin.sub(sphereCenter)) - radius * radius));
    
    if(discriminant < 0)
    {
      return null;
    }
    
    float t1 = (float)(direction.mult(-1).dot(origin.sub(sphereCenter)) + Math.sqrt(discriminant)) / (direction.dot(direction));
    float t2 = (float)(direction.mult(-1).dot(origin.sub(sphereCenter)) - Math.sqrt(discriminant)) / (direction.dot(direction));
    
    float t = Math.min(t1, t2);
    
    return new Hit(origin.add(direction.mult(t)), sphere, t);
  }
}