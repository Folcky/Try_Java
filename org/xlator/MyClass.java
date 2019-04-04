package org.xlator;

import tempa.*;
import tempb.*;

class MyClass {
 public static void main(String[] args) {
 ClassA ca = new ClassA();
 ClassB cb = new ClassB("ClassB");
  System.out.println(ca.name + ", " + cb.name + ", " + args[1]);
 }
}
