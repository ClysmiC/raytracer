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
  public void calculateColor(List<Light> lights, List<SceneObject> objects, Ray incomingRay, int backgroundColor, int recursiveDepth)
  {
    Surface surface = object.getSurface(); //<>//
    
    PVector n = null;
    
    //calculate normal
    if(object instanceof Sphere)
    {
      n = PVector.sub(hitPoint, ((Sphere)object).getCenter()).normalize(); //<>//
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
    
    PVector e = incomingRay.getOrigin();
    
    float rTotal = surface.getAmbientR();
    float gTotal = surface.getAmbientG();
    float bTotal = surface.getAmbientB();
    
    //calculate lighting/shading
    for(Light light: lights)
    {
      PVector l = PVector.sub(light.getLocation(), hitPoint).normalize();
      //cast ray to see if shadow
      
      PVector tinyOffset = PVector.mult(l, .001); // add this tiny vector to the hitpoint to make sure it doesn't "hit" itself when it casts a ray
      Ray toLight = new Ray(PVector.add(hitPoint, tinyOffset), l);
      
      float expectedT;
      
      if(Math.abs(light.getLocation().x - hitPoint.x) > 0.0001)
      {
        expectedT = (light.getLocation().x - hitPoint.x) / toLight.getDirection().x;
      }
      else if(Math.abs(light.getLocation().y - hitPoint.y) > 0.0001)
      {
        expectedT = (light.getLocation().y - hitPoint.y) / toLight.getDirection().y;
      }
      else if(Math.abs(light.getLocation().z - hitPoint.z) > 0.0001)
      {
        expectedT = (light.getLocation().z - hitPoint.z) / toLight.getDirection().z;
      }
      else
      {
        //light has same coordinates as object... edge case, shouldn't happen
        expectedT = 0;
      }
      
      Hit hit = toLight.castRay(objects);
      
      int includeThisLight = 1;
      
      if(hit != null)
      {
        //ray hit something. if it is less than our expected T, it is an object
        //in the way of the 
        if(hit.getRayT() + .0001 < expectedT)
        {
          includeThisLight = 0;
        }
      }
      
      //null hit means ray never hit an object, so it reached light just fine
      
      float nDotL = PVector.dot(n, l);
      nDotL = Math.max(0, nDotL);
      
      PVector h = PVector.div(PVector.add(e, l), PVector.add(e, l).mag());
      float cPhong = (float)Math.pow(PVector.dot(h, n), surface.getPhongExp());
      
      float r = surface.getDiffuseR() * light.getRed() * nDotL * includeThisLight +
                cPhong * surface.getSpecularR() * light.getRed() * includeThisLight;
                
      float g = surface.getDiffuseG() * light.getGreen() * nDotL * includeThisLight +
                cPhong * surface.getSpecularG() * light.getGreen() * includeThisLight;
      float b = surface.getDiffuseB() * light.getBlue() * nDotL * includeThisLight +
                cPhong * surface.getSpecularB() * light.getBlue() * includeThisLight;
      
      rTotal += r;
      gTotal += g;
      bTotal += b;
    }
    
    //calculate reflection
    float reflectivity = object.getSurface().getReflectivity();
    
    if(reflectivity > 0 && recursiveDepth < 10)
    {
      PVector reflectedVector = PVector.sub(incomingRay.getDirection(), PVector.mult(n, 2 * PVector.dot(incomingRay.getDirection(), n)));
      reflectedVector.normalize();
      
      PVector tinyOffset = PVector.mult(reflectedVector, .001); // add this tiny vector to the hitpoint to make sure it doesn't "hit" itself when it casts a ray
      Ray reflectedRay = new Ray(PVector.add(hitPoint, tinyOffset), reflectedVector);
      
      int reflectColor = backgroundColor;
     
      Hit reflectedHit = reflectedRay.castRay(objects);
      
      if(reflectedHit != null)
      {
        reflectedHit.calculateColor(lights, objects, reflectedRay, backgroundColor, recursiveDepth + 1);
        reflectColor = reflectedHit.getColor();
      }
      
      rTotal += reflectivity * red(reflectColor);
      gTotal += reflectivity * green(reflectColor);
      bTotal += reflectivity * blue(reflectColor);
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