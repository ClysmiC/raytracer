public class Surface
{
  private float diffuseR, diffuseG, diffuseB;
  private float ambientR, ambientG, ambientB;
  private float specularR, specularG, specularB;
  private float phongExp;
  private float reflectivity;
  
  public Surface(float dr, float dg, float db, float ar, float ag, float ab, float sr, float sg, float sb, float phongExp, float reflectivity)
  {
    diffuseR    = dr;
    diffuseG    = dg;
    diffuseB    = db;
    ambientR    = ar;
    ambientG    = ag;
    ambientB    = ab;
    specularR   = sr;
    specularG   = sg;
    specularB   = sb;
    
    this.phongExp = phongExp;
    this.reflectivity = reflectivity;
  }
  
  public float getDiffuseR()
  {
    return diffuseR;
  }
  
  public float getDiffuseG()
  {
    return diffuseR;
  }
  
  public float getDiffuseB()
  {
    return diffuseR;
  }
}