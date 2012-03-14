// Placed in public domain.

#include <GL/gl.h>
#include <SDL/SDL.h>

int finalize_draw ()
{
  SDL_GL_SwapBuffers();
  glClear( GL_COLOR_BUFFER_BIT );
  glLoadIdentity(); 
  //  reference_block();
}

//TODO this is a bit silly, of course.
int draw_system(int index, float x,float y,float r)
{
  glBegin( GL_QUADS );
    glTexCoord2f(1,1); glVertex2f(x+r, y+r);
    glTexCoord2f(0,1); glVertex2f(x-r, y+r);
    glTexCoord2f(0,0); glVertex2f(x-r, y-r);
    glTexCoord2f(1,0); glVertex2f(x+r, y-r);
  glEnd();
}

int color (char r,char g,char b)
{ glColor3b(r,g,b); }
int colora (char r,char g,char b,char a)
{ glColor4b(r,g,b,a); }
int vertex(double x,double y)
{ glVertex2d(x,y); }

int gl_begin_points ()
{ glBegin(GL_POINTS); }
int gl_begin_lines ()
{ glBegin(GL_LINES); }
int gl_begin_line_strip ()
{ glBegin(GL_LINE_STRIP); }

int gl_end()
{ glEnd(); }

int gl_scale(double x,double y,double z)
{ glScaled(x,y,z); }
