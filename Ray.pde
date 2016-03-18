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
  
  public Hit castRay(List<SceneObject> objects)
  {
    Hit closestHit = null;
    
    for(SceneObject object: objects)
    {
      Hit hit = null;
      
      if(object instanceof Sphere)
      {
        hit = intersectsWith((Sphere)object);
      } 
      else if(object instanceof Triangle)
      {
        hit = intersectsWith((Triangle)object);
      } 
      else
      {
        System.out.println("Error: Object must be either a sphere or a triangle.");
      }
      
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
  
  public Hit intersectsWith(Triangle triangle)
  {
    PVector edge1 = PVector.sub(triangle.getP2(), triangle.getP1());
    PVector edge2 = PVector.sub(triangle.getP3(), triangle.getP1());
    
    PVector n = edge1.cross(edge2).normalize();
    float d = -PVector.dot(n, triangle.getP1());
    
    //make sure n isn't perpendicular to the ray
    if(PVector.dot(n, direction) < .0001)
    {
      return null;
    }
    
    //t is where the ray intersects the plane
    float t = -(PVector.dot(n, origin) + d) / PVector.dot(n, direction);
    PVector intersectPoint = PVector.add(origin, PVector.mult(direction, t));
    
    
    //use Barycentric coordinates to check if within triangle
    PVector ap = PVector.sub(intersectPoint, triangle.getP1());
    PVector ab = PVector.sub(triangle.getP2(), triangle.getP1());
    PVector ac = PVector.sub(triangle.getP3(), triangle.getP1());
    
    float invDenom = ((PVector.dot(ac, ac) * PVector.dot(ab, ab)) - (PVector.dot(ac, ab) * PVector.dot(ac, ab))); 
    
    float u = ((PVector.dot(ab, ab) * PVector.dot(ap, ac)) - (PVector.dot(ab, ac) * PVector.dot(ap, ab))) / invDenom;
    float v = ((PVector.dot(ac, ac) * PVector.dot(ap, ab)) - (PVector.dot(ac, ab) * PVector.dot(ap, ac))) / invDenom;
    
    if(u < 0 || v < 0 || u + v > 1.000001) //give a LIIITTLE extra room due to float weirdness (prevents edges from failing detection)
    {
      return null;
    }
    
    return new Hit(intersectPoint, triangle, t);
  }
  
  @Override
  public String toString()
  {
    return String.format("Ray from (%.2f, %.2f, %.2f) to (%.2f, %.2f, %.2f)",
      origin.x, origin.y, origin.z, direction.x, direction.y, direction.z);
  }
}