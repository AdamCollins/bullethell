/* Written by Adam Collins Alpha version.
 *-----Special Features-----
 * -Two types of enemies that spawn in waves.
 * -Indicates when higscore is achived.
 * -Highscores save and are sorted in order.
 * -Menu and pause.
 * -3 diffrent types of bullets with bullet counter.
 * -Replenishes bullets and lives when certian scores are reached.
 * -Enemies that follow player.
 * -Invncible for 3 seconds after losing life. + invincible animation.
 *
 *-----Controls-----
 *Basic bullets(unlimited): SHIFT
 *Fast bullets: S
 *Rainbow bullets: A
 *Movement: Arrow keys
 *Pause: P
 */
import java.io.BufferedWriter;
import java.io.FileWriter;
import ddf.minim.*;

Minim minim;

Starfield starF;
Keyboard kbd;
Player player;
BulletManager bulletmanager;
EnemyManager enemymanager;
ExplosionManager explosionmanager;
MainMenu mainmenu;
ScoreManager scoremanager;
SFX sfx; //Not working. WIP
UI ui;
int score;
int lives;
int level;
int gameTime;    //Time game has been playing.
PFont font36;
PFont font14;
PFont font48;
boolean isPlaying;
void setup()
{
  //size(displayWidth, displayHeight,P2D);
  size(800, 600, P2D);
  font36 = loadFont("font36.vlw");
  font14 = loadFont("font14.vlw");
  font48 = loadFont("font48.vlw");
  mainmenu = new MainMenu();
  starF = new Starfield(50); //Creates Starfeild. Args = num of stars.
  kbd = new Keyboard();
  player = new Player();
  bulletmanager = new BulletManager();
  enemymanager = new EnemyManager();
  explosionmanager = new ExplosionManager();
  scoremanager = new ScoreManager();
  minim = new Minim(this);
  sfx = new SFX();
  ui = new UI();
}

void draw()
{
  smooth(8);
  imageMode(CENTER);
  noStroke();

  if (isPlaying && !ui.paused) 
  {
    gameTime++;
    starF.show();
    bulletmanager.update();
    player.update();
    enemymanager.create();
    enemymanager.draw();
    explosionmanager.display();
    

    if (gameTime%1800==0) {
      level++;
    }
  } 
  else if (!ui.paused)
  {

    starF.show();
    mainmenu.display();
 
  }
  if(isPlaying)ui.display();

  
}

void gameReset() {
  lives = 3;
  gameTime=0;
  level = 1;
  score = 0;
  player.damageable=true;
  enemymanager.delete();
  bulletmanager.delete();
  ui.bulletReset();
  explosionmanager.delete();
}

void keyPressed(KeyEvent evt) {
  kbd.pressKey(evt.getKeyCode());
}

void keyReleased(KeyEvent evt) {
  kbd.releaseKey(evt.getKeyCode());
}


boolean rectRect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {

  // test for collision
  if (x1+w1/2 >= x2-w2/2 && x1-w1/2 <= x2+w2/2 && y1+h1/2 >= y2-h2/2 && y1-h1/2 <= y2+h2/2) {
    return true;    // if a hit, return true
  } 
  else {            // if not, return false
    return false;
  }
}

