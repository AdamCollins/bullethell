class BulletManager
{
  ArrayList<Bullet> bullets;
  PImage bullet;
  PImage enemyBullet;
  BulletManager()
  {
    bullets = new ArrayList<Bullet>();
    bullet = loadImage("bullet/bullet_1.png");
    enemyBullet = loadImage("bullet/downBullet.png");
  }

  void update()
  {
    for (int i = bullets.size ()-1; i>=0; i--) 
    //for(int i = 0; i<bullets.size()-1; i++)
    {
      Bullet b = bullets.get(i);
      println("1");
      b.move();
      if (b.y<-50 || b.y>height+50) bullets.remove(i);
      if (b.x<-50 || b.x>width+50) bullets.remove(i);

      for (int j = enemymanager.flappybird.size ()-1; j>=0; j--) 
      {
        Flappybird f = enemymanager.flappybird.get(j);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)f.x, (int) f.y, 32, 24) && b.isFriendly) {
          println("2");
          bullets.remove(i);
          
          println("3");
          explosionmanager.create(f.x,f.y);
          enemymanager.flappybird.remove(j);
          println("4");
          
          score+=100;
          
          
          println("5");
          break;
        }
        println("6");
        
       if(rectRect((int)b.x, (int)b.y, 3, 11, (int)player.x, (int) player.y, 34, 41) && !b.isFriendly){
         lives--;
       }
        
      }
    }
  }

  void addB(Bullet b)
  {
    bullets.add(b);
  }
}
