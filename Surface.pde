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
    return diffuseG;
  }
  
  public float getDiffuseB()
  {
    return diffuseB;
  }
  
  public float getAmbientR()
  {
    return ambientR;
  }
  
  public float getAmbientG()
  {
    return ambientG;
  }
  
  public float getAmbientB()
  {
    return ambientB;
  }
  
  public float getSpecularR()
  {
    return specularR;
  }
  
  public float getSpecularG()
  {
    return specularG;
  }
  
  public float getSpecularB()
  {
    return specularB;
  }
  
  public float getReflectivity()
  {
    return reflectivity;
  }
  
  public float getPhongExp()
  {
    return phongExp;
  }
  
  @Override
  public String toString()
  {
    return String.format("Diffuse: (%.2f, %.2f, %.2f)\nAmbient: (%.2f, %.2f, %.2f)\nSpecular: (%.2f, %.2f, %.2f)\nP: %.2f\nReflectivity: %.2f",
                            diffuseR, diffuseG, diffuseB, ambientR, ambientG, ambientB, specularR, specularG, specularB, phongExp, reflectivity);
  }
}