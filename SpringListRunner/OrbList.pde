/*===========================
  OrbList (ALL WORK GOES HERE)

  Class to represent a Linked List of OrbNodes.

  Instance Variables:
    OrbNode front:
      The first element of the list.
      Initially, this will be null.

  Methods to work on:
    0. addFront
    1. populate
    2. display
    3. applySprings
    4. applyGravity
    5. run
    6. removeFront
    7. getSelected
    8. removeNode

  When working on these methods, make sure to
  account for null values appropraitely. When the program
  is run, no NullPointerExceptions should occur.
  =========================*/

class OrbList {

  OrbNode front;

  /*===========================
    Contructor
    Does very little.
    You do not need to modify this method.
    =========================*/
  OrbList() {
    front = null;
  }//constructor

  /*===========================
    addFront(OrbNode o)

    Insert o to the beginning of the list.
    =========================*/
  void addFront(OrbNode o) {
    if (front != null) {
      front.previous = o;
      o.next = front;
    }
    front = o;
  }


  /*===========================
    populate(int n, boolean ordered)

    Clear the list.
    Add n randomly generated  orbs to the list,
    using addFront.
    If ordered is true, the orbs should all
    have the same y coordinate and be spaced
    SPRING_LEGNTH apart horizontally.
    =========================*/
  void populate(int n, boolean ordered) {
    front = null; // Clear the list

    float startX = width / 2 - (n / 2) * SPRING_LENGTH;
    OrbNode prev = null;

    for (int i = 0; i < n; i++) {
      float x, y, size, mass;
      size = random(MIN_SIZE, MAX_SIZE);
      mass = random(MIN_MASS, MAX_MASS);

      if (ordered) {
        x = startX + i * SPRING_LENGTH;
        y = height / 2;
      } else {
        x = random(size / 2, width - size / 2);
        y = random(size / 2, height - size / 2);
      }

      OrbNode newNode = new OrbNode(x, y, size, mass);
      addFront(newNode);

      if (prev != null) {
        newNode.next = prev;
        prev.previous = newNode;
      }
      prev = newNode;
    }
  }

  /*===========================
    display(int springLength)

    Display all the nodes in the list using
    the display method defined in the OrbNode class.
    =========================*/
  void display() {
    OrbNode current = front;
    while (current != null) {
      current.display();
      current = current.next;
    }
  }

  /*===========================
    applySprings(int springLength, float springK)

    Use the applySprings method in OrbNode on each
    element in the list.
    =========================*/
  void applySprings(int springLength, float springK) {
    OrbNode current = front;
    while (current != null) {
      current.applySprings(springLength, springK);
      current = current.next;
    }
  }

  /*===========================
    applyGravity(Orb other, float gConstant)

    Use the getGravity and applyForce methods
    to apply gravity crrectly.
    =========================*/
  void applyGravity(Orb other, float gConstant) {
    OrbNode current = front;
    while (current != null) {
      PVector gravityForce = current.getGravity(other, gConstant);
      current.applyForce(gravityForce);
      current = current.next;
    }
  }

  /*===========================
    run(boolean bounce)

    Call run on each node in the list.
    =========================*/
  void run(boolean bounce) {
    OrbNode current = front;
    while (current != null) {
      current.move(bounce);
      current = current.next;
    }
  }

  /*===========================
    removeFront()

    Remove the element at the front of the list, i.e.
    after this method is run, the former second element
    should now be the first (and so on).
    =========================*/
  void removeFront() {
    if (front != null) {
      front = front.next;
      if (front != null) {
        front.previous = null;
      }
    }
  }


  /*===========================
    getSelected(float x, float y)

    If there is a node at (x, y), return
    a reference to that node.
    Otherwise, return null.

    See isSlected(float x, float y) in
    the Orb class (line 115).
    =========================*/
  OrbNode getSelected(int x, int y) {
    OrbNode current = front;
    while (current != null) {
      if (current.center.dist(new PVector(x, y)) <= current.bsize / 2) {
        return current;
      }
      current = current.next;
    }
    return null;
  }

  /*===========================
    removeNode(OrbNode o)

    Removes o from the list. You can
    assume o is an OrbNode in the list.
    You cannot assume anything about the
    position of o in the list.
    =========================*/
  void removeNode(OrbNode o) {
    if (o == null) return;

    if (o == front) {
      removeFront();
      return;
    }

    if (o.previous != null) {
      o.previous.next = o.next;
    }
    if (o.next != null) {
      o.next.previous = o.previous;
    }
  }
}
