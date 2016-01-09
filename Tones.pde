public class Tone{
  
  public Tone(){
    activeNotes.add(new Note('a', 40));
    activeNotes.add(new Note('s', 42));
    activeNotes.add(new Note('d', 44));
    activeNotes.add(new Note('f', 45));
    activeNotes.add(new Note('g', 47));
    activeNotes.add(new Note('h', 49));
    activeNotes.add(new Note('j', 51));
    activeNotes.add(new Note('k', 52));
    activeNotes.add(new Note('l', 54));
    activeNotes.add(new Note('č', 56));
    activeNotes.add(new Note('ć', 57));
    activeNotes.add(new Note('ž', 59));
    
    activeNotes.add(new Note('w', 41));
    activeNotes.add(new Note('e', 43));
    activeNotes.add(new Note('t', 46));
    activeNotes.add(new Note('z', 48));
    activeNotes.add(new Note('u', 50));
    activeNotes.add(new Note('o', 53));
    activeNotes.add(new Note('p', 55));
    activeNotes.add(new Note('đ', 58));
  }
  
  public int getNote(float frequency){
    int n = (int) Math.round(12 * (Math.log(frequency/440f) / Math.log(2)) + 49);
    return n;
  }
  
  public float getFrequency(int n){
    float frequency = (float) Math.pow(2, (n-49)/12f)*440f;
    return frequency;
  }
 
}

class Note{
  boolean dying = false;
  boolean active = false;
  int offset;
  int time = 0;
  int lastFrequency = 0;
  char letter;
  int number = 0;
  
  public Note(char letter, int number){
    this.number = number;
    this.offset = number - offset;
    this.time = 0;  
    this.letter = letter;
  }
  
  public void kill(){
    
  }

}