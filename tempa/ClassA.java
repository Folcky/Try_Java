package tempa;

public class ClassA{
 public String name;
 public ClassA(){
  name = this.getClass().getSimpleName();
 }
 public ClassA(String name) {
  this.name = name;
 }
}
