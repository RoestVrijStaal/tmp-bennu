const
  /*Tama�o del campo de juego, definido en casillas l�gicas. Hay 10 casillas en horizontal y 20 en vertical, y cada una de ellas podr� ser ocupada por uno de los gr�ficos 20x20 que representan un bloque*/
  TETRIS_ANCHO = 10;
  TETRIS_ALTO = 22;      // 20 + 2 para la posici�n inicial de la ficha
  TETRIS_ANCHO_PIEZA = 4;// 5 bloques
  TETRIS_ALTO_PIEZA = 4; // 5 bloques

                   // Indica que la pieza
  TETRIS_NOT_ROTATED = 0; // no ha sido rotada
  TETRIS_ROTATED_90 = 1;  // ha sido rotada 90� en direcci�n horario respecto su posici�n original
  TETRIS_ROTATED_180 = 2; // ha sido rotada 180� en direcci�n horario respecto su posici�n original
  TETRIS_ROTATED_270 = 3; // ha sido rotada 270� en direcci�n horario respecto su posici�n original
end
    type TETRIS_stat_piece
        int index;
        int x;
        int y;
        int rotation;
    end
    
    type TETRIS_piece
        int data[TETRIS_ANCHO_PIEZA][TETRIS_ALTO_PIEZA];
        int color;
        int width;
        int height;
    end

global

  int TETRIS_piece_speed = 15;//Velocidad de bajada de la pieza. Se modificar� dependiendo del nivel del jugador.
  int TETRIS_level=1; //Nivel del jugador (a mayor nivel, m�s r�pido es el descenso)
  int TETRIS_score_for_line = 100; //Puntuaci�n lograda por completar una l�nea horizontal completa
  int TETRIS_score_for_move = 0; //Puntuaci�n b�sica lograda por hacer cualquier movimiento
  int TETRIS_score=0; //Puntuaci�n total actual del jugador
  int TETRIS_lines=0; //L�neas completadas del jugador
  TETRIS_piece TETRIS_pieces[10]; //Define la forma sensible de hasta 10 posibles piezas.
  TETRIS_stat_piece TETRIS_curren_piece;
  
  int TETRIS_next=0; /*Tipo de pieza siguiente */
  
  int TETRIS_pieces_count; //N�mero de piezas distintas        
  int TETRIS_board[TETRIS_ANCHO][TETRIS_ALTO]; /*Define qu� casilla l�gica (no gr�fica) del campo de juego est� ocupada por un bloque o no.*/
  int TETRIS_pieces_statistic[10];
end

process TETRIS_main()
  /*
  Definiciones para el desarrollo del juego
  Pieza: Objeto que debe colocar o mueve el jugador. En este caso ocupa 5x5 casillas-
  Bloque: unidad m�nima en la que se puede dividir una pieza. En este caso ocupa 1 casilla.
  Casilla: es un hueco en el que puede haber (o no) un bloque.
  */
begin
  set_title("Simple Tetris");

  //Creo las piezas:
  TETRIS_pieces_count = 0;

  //   OO
  //   OO
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(0,0,255);
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[1][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].width = 2;
  TETRIS_pieces[TETRIS_pieces_count].height = 2;
 
  TETRIS_pieces_count++;

  //  OOO
  //  O
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(255,0,255);
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[1][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 0;

  TETRIS_pieces[TETRIS_pieces_count].data[2][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[2][1] = 0;

  TETRIS_pieces[TETRIS_pieces_count].width = 3;
  TETRIS_pieces[TETRIS_pieces_count].height = 2;

  TETRIS_pieces_count++;

  // OOO
  //   O
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(255,255,0);
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 0;

  TETRIS_pieces[TETRIS_pieces_count].data[1][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 0;

  TETRIS_pieces[TETRIS_pieces_count].data[2][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[2][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].width = 3;
  TETRIS_pieces[TETRIS_pieces_count].height = 2;

  TETRIS_pieces_count++;

  //    O
  //   OOO
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(0,255,0);
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][0] = 0;
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[1][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[2][0] = 0;
  TETRIS_pieces[TETRIS_pieces_count].data[2][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].width = 3;
  TETRIS_pieces[TETRIS_pieces_count].height = 2;

  TETRIS_pieces_count++;
  

  // 
  // OOOO
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(255,0,0);
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[2][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[3][1] = 1;


  TETRIS_pieces[TETRIS_pieces_count].width = 4;
  TETRIS_pieces[TETRIS_pieces_count].height = 3;

  TETRIS_pieces_count++;

  //   OO
  //  OO
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(51,200,255);
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][0] = 0;
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[1][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[2][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[2][1] = 0;

  TETRIS_pieces[TETRIS_pieces_count].width = 3;
  TETRIS_pieces[TETRIS_pieces_count].height = 2;

  TETRIS_pieces_count++;
  //  OO
  //   OO
  TETRIS_pieces[TETRIS_pieces_count].color = RGB(255,200,0); 
  //                        H  V
  TETRIS_pieces[TETRIS_pieces_count].data[0][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[0][1] = 0;

  TETRIS_pieces[TETRIS_pieces_count].data[1][0] = 1;
  TETRIS_pieces[TETRIS_pieces_count].data[1][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].data[2][0] = 0;
  TETRIS_pieces[TETRIS_pieces_count].data[2][1] = 1;

  TETRIS_pieces[TETRIS_pieces_count].width = 3;
  TETRIS_pieces[TETRIS_pieces_count].height = 2;

  TETRIS_pieces_count++;

  //Inicializo...
  TETRIS_level = 0;
  //...y pongo en marcha el men� inicial
  simpletetris_menu();
end

//-----------------------------------------------------------------------------------------------------------------------

/* Men� b�sico */
Process simpletetris_menu()
private
  int i;
end
begin

  //Se vac�a el campo de juego
  for(x=0;x<TETRIS_ANCHO;x++)
    for(y=0;y<TETRIS_ALTO;y++)
      TETRIS_board[x][y] = 0;// RGB(0,0,0);
    end
  end

  write(0,400,200,1,"Simple Tetris");
  write(0,400,450,1,"Pulsa intro para Empezar");
  write(0,400,470,1,"o escape Salir");

  while (!is_key_pressed(PLAYER_1,KEY_START))  
    if(is_key_pressed(PLAYER_1,KEY_CLOSE))
      While (is_key_pressed(PLAYER_1,KEY_CLOSE))
        Frame;
      End
      let_me_alone();
      delete_text(all_text);
      menu();
      return;
    end //Acabar la ejecuci�n si se ha seleccionado la tecla SELECT
    frame;
  end                              
  /*Limito los frames por segundo */
  set_fps(27,0); 
  delete_text(all_text);
  //Escribo los textos del juego
  write(0,125,510,4,"Puntuaci�n:");
  write_var(0,220,510,4,TETRIS_score);
  write(0,137,520,4,"L�neas:");
  write_var(0,220,520,4,TETRIS_lines);
  write(0,142,530,4,"Nivel:");
  write_var(0,220,530,4,TETRIS_level);
  //Y comienza la l�gica del juego (por fin!)
  simpletetris_game();
end


//-----------------------------------------------------------------------------------------------------------------------
/*Redibuja cada fotograma en la pantalla el nivel del jugador, el bloque actual y la previsualizaci�n del siguiente bloque. */
process simpletetris_render()
begin
  simpletetris_main_board();
  simpletetris_falling_TETRIS_piece();
  simpletetrisTETRIS_next_TETRIS_piece();
  simpletetris_statistics();
  loop
    //Si se pulsa CLOSE mientras se est� jugando, se para todo y se sale al men� inicial 
    if(is_key_pressed(PLAYER_1,KEY_CLOSE))
      while(is_key_pressed(PLAYER_1,KEY_CLOSE))
        frame;
      end //Hasta que no se suelte la tecla no se hace nada
      clear_screen();
      delete_text(all_text);
      TETRIS_score = 0;
      let_me_alone(); //Deja s�lo el proceso actual
      simpletetris_menu(); //Pone en marcha el men� otra vez
      return; /*Ahora hay dos procesos, el actual (que ya no interesa), y el men�. Una manera de acabar con el proceso actual -un suicidio- es con esta l�nea.*/
    end
    frame;
  end                                    
end

process simpletetris_main_board()
private
  int i,j;
  int block_color;
end
begin
  graph=new_map((TETRIS_ANCHO+2)*20,(TETRIS_ALTO+1)*20,16);
                    // |           |
                    // |           - Para el suelo
                    // - Para las dos paredes laterales
  x=(TETRIS_ANCHO+2)*10+65; // 190
  y=(TETRIS_ALTO+1)*10+20;  // 90
  block_color = 0;
  while (!is_key_pressed(PLAYER_1,KEY_CLOSE))
    map_clear(0,graph,0);
    //Dibujo el campo de juego
    for(i = 0;i < TETRIS_ANCHO+2;i++)
      for(j = 2;j < TETRIS_ALTO+1;j++)
        //De entrada, la casilla l�gica est� vac�a 
        block_color = 0;
        //Si la casilla pertenece al reborde, la pinto con el color gris claro
        if( i == 0  or (i == TETRIS_ANCHO+1) or j == TETRIS_ALTO ) //or j == 0 
          block_color = rgb(170,170,170);
        else
          //Al principio del juego, todos los elementos de TETRIS_board[][] valen 0 (es decir, no hay ninguna casilla l�gica ocupada). 
          //A medida que se vaya jugando, block_color ir� valiendo en tiempo real el color que se ha de pintar en la casilla l�gica
          block_color = TETRIS_board[i-1][j-1+1]; 
        end

        /*Ahora s�: pinto el terreno de juego.Esto lo har� a cada frame mientras el proceso est� funcionando. En cada frame se 
        redibujar�n los bordes, las casillas vac�as y las ocupadas, que vienen controladas por TETRIS_board y que se reflejan visiblemente en block*/
        //el 20 es el tama�o de los bloques, 10 es la mitad.
        if (block_color != 0)
          simpletetris_print_block(0,graph, block_color , i , j);
        //  frame;
        end
      end
    end
    frame;
  end
end

process simpletetris_falling_TETRIS_piece()
private
  int i,j,k,l;
end
begin
  graph=new_map(TETRIS_ANCHO_PIEZA*20,TETRIS_ALTO_PIEZA*20,16);
  while (!is_key_pressed(PLAYER_1,KEY_CLOSE))
    x=TETRIS_curren_piece.x*20+125; // 250
    y=TETRIS_curren_piece.y*20+60; // 150
    map_clear(0,graph,0); //RGB(12,12,12));//
    /*Dibujo la pieza actual dentro del terreno de juego, actualiz�ndolo en cada frame mientras "Render" est� vivo.
    El algoritmo recorre los bloques de la pieza,  -definido por 'TETRIS_curren_piece.index'- a lo largo de las casillas l�gicas 
    del vector TETRIS_pieces. Si el valor en cada casilla es 0 (eso no s�lo depende del tipo de pieza, sino tambi�n de su orientaci�n actual),
    no se pintar� nada en la posici�n que ocupa; si el valor es 1,pintar� en esa casilla un bloque con el color de la pieza*/

    for(j = 0;j < TETRIS_pieces[TETRIS_curren_piece.index].height;j++)  
      for(i = 0;i < TETRIS_pieces[TETRIS_curren_piece.index].width;i++)
        switch(TETRIS_curren_piece.rotation)
          case TETRIS_NOT_ROTATED:
           k = i;
           l = j;
          end
          case TETRIS_ROTATED_90:
           k = j;
           l = TETRIS_pieces[TETRIS_curren_piece.index].width-1-i;
          end
          case TETRIS_ROTATED_180:
           k = TETRIS_pieces[TETRIS_curren_piece.index].width-1-i;
           l = TETRIS_pieces[TETRIS_curren_piece.index].height-1-j;
          end
          case TETRIS_ROTATED_270:
           k = TETRIS_pieces[TETRIS_curren_piece.index].height-1-j;
           l = i ;
          end
        end     
        //Si existe pieza a pintar en esta casilla, la pinto
        if( TETRIS_pieces[TETRIS_curren_piece.index].data[i][j] != 0)                        
          simpletetris_print_block(0,graph,TETRIS_pieces[TETRIS_curren_piece.index].color,k,l);
        end
        //frame(5000); 
      end
    end
    frame;
  end
end

process simpletetris_statistics()
private
  int i;
  int textsTemp[10];
  int texts[10];
begin
  textsTemp[0]=write(0,330,200,4,"O:");
  textsTemp[1]=write(0,330,220,4,"L:");
  textsTemp[2]=write(0,330,240,4,"J:");
  textsTemp[3]=write(0,330,260,4,"T.");
  textsTemp[4]=write(0,330,280,4,"|:");
  textsTemp[5]=write(0,330,300,4,"S:");
  textsTemp[6]=write(0,330,320,4,"Z:");
  for (i=0;i<TETRIS_pieces_count;i++)
   texts[i]=write_var(0,360,200+i*20,4,TETRIS_pieces_statistic[i]);
  end
  while (!is_key_pressed(PLAYER_1,KEY_CLOSE))
    frame;
  end
  for (i=0;i<TETRIS_pieces_count;i++)
   delete_text(textsTemp[i]);
   delete_text(texts[i]);
  end
end

process simpletetrisTETRIS_next_TETRIS_piece()
private
  int i,j,k,l;
  int block_color;
  int a;
  int juego;
end
begin
  graph=new_map(TETRIS_ANCHO_PIEZA*20,TETRIS_ALTO_PIEZA*20,16);
  x=TETRIS_ANCHO_PIEZA*10;
  y=TETRIS_ALTO_PIEZA*10+20;
  while (!is_key_pressed(PLAYER_1,KEY_CLOSE))
    map_clear(0,graph,0);
    /*Dibujo los l�mites del cuadrado preview donde se visualiza el bloque siguiente,  y el propio preview, a cada frame*/
    /*El l�mite de +2 viene de que el n�mero de filas y columnas del cuadrado preview coinciden con las medidas de las 2� y 3� dimensiones de la matriz block,
    con el objetivo de que el cuadro preview no sea m�s que una plasmaci�n gr�fica de la matiz l�gica block.*/
    for(i = 0;i < TETRIS_ANCHO_PIEZA;i++)
      for(j = 0;j < TETRIS_ALTO_PIEZA;j++)
        //De entrada, las casillas l�gicas est�n vac�as (color transparente)  
        block_color = 0;                       
        //Si la casilla correspondiente de la matriz block dice que hay pieza, se establece qu� color le corresponde
        if(TETRIS_pieces[TETRIS_next].data[i][j]==1)
            block_color=TETRIS_pieces[TETRIS_next].color;
        end
        if (block_color !=0)
          simpletetris_print_block(0,graph, block_color , i,j);
        end
      end
    end
    frame;
  end
end

function simpletetris_print_block(int file,int graph, int color,int x, int y )
private
  int block_map,block_border_map;
begin
  block_map = new_map(18,18,16);
  map_clear(0,block_map,color);
  block_border_map = new_map(20,20,16);
  map_clear(0,block_border_map,RGB(0,0,0));
  map_xputnp(0,block_border_map,0,block_map,10,10,0,100,100,0);  
  map_xputnp(file,graph,0,block_map,10+20*x,10+20*y,0,100,100,0);
  unload_map(0,block_map);
  unload_map(0,block_border_map);
end

//-----------------------------------------------------------------------------------------------------------------------

/*L�gica del juego: gestiona el descenso y rotaci�n de los piezas, 
el choque de los piezas con el fondo,gestiona el game over...Todos estos c�lculos
se ver�n reflejados en el proceso "Render"*/
Process simpletetris_game()
private
  int neer=1;//Si vale cero el bloque actual est� listo para bajar una l�nea
  int i,j,k,l,li,r,d,ct; //Variables auxiliares
end
begin
   simpletetris_detect_completed_TETRIS_lines(); //Lanza el proceso que autodetecta si las l�neas horizontales est�n llenas
  /*Determina qu� pieza se muestran en pantalla (TETRIS_curren_piece.index=pieza actual, TETRIS_next= pieza siguiente)
  Curiosamente (?) siempre se empieza con la misma pieza*/
  for (i=0;i<10;i++)
   TETRIS_pieces_statistic[i]=0;
  end
  TETRIS_curren_piece.index = rand(0,TETRIS_pieces_count-1);
  TETRIS_pieces_statistic[TETRIS_curren_piece.index]++;
  TETRIS_next = rand(0,TETRIS_pieces_count-1);
  /*Asigno la posici�n y la rotaci�n inicial de las piezas. Y tambi�n la puntuaci�n y el nivel del jugador.
  Esto es necesario hacerlo debido a que este proceso puede ser llamado no solamente al principio de ejecutarse el juego sino despu�s del proceso gameover.*/
  TETRIS_curren_piece.x = TETRIS_ANCHO / 2 -1 ; TETRIS_curren_piece.y = 0; TETRIS_curren_piece.rotation = TETRIS_NOT_ROTATED; TETRIS_score = 0; TETRIS_level = 1;

  simpletetris_render(); //Proceso que dibuja ("renderiza") el campo de juego en pantalla.
  //Listo! Ya se puede empezar a jugar
  loop
    TETRIS_level = 1+(TETRIS_score / 1000); //El nivel del jugador est� basado en la puntuaci�n
    if(TETRIS_level > 10) 
      TETRIS_level = 10;
    end //No se puede tener un nivel mayor de 10
    TETRIS_piece_speed = 15 - TETRIS_level; //Las piezas descienden m�s r�pido para niveles mayores.

    /*Es curioso el sistema de detecci�n de las key (_left,_right,_down,__A):
    cuando se detecta su pulsaci�n, se aumenta el valor de cuatro variables (li,r,d,ct,
    respectivamente) -haciendo que valga diferente de 0-, y entonces se comprueba si su valor
    es 1 -m�s otros condicionantes- para realizar la acci�n deseada (moverse a la izquierda,
    derecha,abajo,rotar, respectivamente). Es un sistema para evitar que si se mantiene pulsada
    mucho rato una tecla el juego se vuelva loco moviendo la ficha sin parar: de esta manera se ha
    de soltar y volver a pulsar la tecla si se quiere repetir el efecto. Lo genial est� en que mientras la
    tecla est� pulsada, la variable ir� aumentando su valor hasta el infinito, pero el if siguiente s�lo
    se ejecutar� cuando esa variable ha valido 1: es decir, que ya se puede tener pulsada la tecla todo el 
    tiempo del mundo que el if s�lo se ejecuta en el primer instante de la pulsaci�n, cuando la variable deja
    de valer 0 a valer 1. Luego, cuando ya vale 2, el if que provoca el movimiento/rotaci�n de la pieza ya no 
    se ejecuta m�s. Puedes comprobar que si por ejemplo se cambia la sentencia de li++,r++,d++ o ct++ por 
    li=1,r=1,d=1 o ct=1, la cosa no va porque mientras tengamos pulsada la tecla correspondiente, la pieza se
    ir� moviendo/rotando sin parar, cosa que no interesa.*/ 
    //El usuario puede mover el bloque a la izquierda, derecha, abajo -m�s r�pido- o rotar el bloque...
    if(is_key_pressed(PLAYER_1,KEY_LEFT))li++; else li = 0; end
    //...y se reaccionar� a los deseos de mover el bloque por parte del usuario siempre que sea posible
    if(li == 1 or ((li%(TETRIS_piece_speed/5)==TETRIS_piece_speed/5-1) and li > 5))
      //Si no se detecta posible colisi�n por la izquierda
      if(simpletetris_is_valid_position(TETRIS_curren_piece.index,TETRIS_curren_piece.rotation,--TETRIS_curren_piece.x,TETRIS_curren_piece.y)==0)
       TETRIS_curren_piece.x++;
      end
    end
    if(is_key_pressed(PLAYER_1,KEY_RIGHT))r++; else r = 0;  end
    if(r == 1 or ((r%(TETRIS_piece_SPEED/5)==TETRIS_piece_SPEED/5-1) and r > 5))
      //Si no se detecta posible colisi�n por la derecha
      if(simpletetris_is_valid_position(TETRIS_curren_piece.index,TETRIS_curren_piece.rotation,++TETRIS_curren_piece.x,TETRIS_curren_piece.y)==0)
       TETRIS_curren_piece.x--;
      end
    end
    if(is_key_pressed(PLAYER_1,KEY_DOWN) or is_key_pressed(PLAYER_1,KEY_B)) d++; else d = 0; end
    if(d == 1 or ((d%(TETRIS_piece_SPEED/5)==TETRIS_piece_SPEED/5-1) and d > 5))
      //Si no se detecta posible colisi�n por abajo
      if(simpletetris_is_valid_position(TETRIS_curren_piece.index,TETRIS_curren_piece.rotation,TETRIS_curren_piece.x,++TETRIS_curren_piece.y)==0)
       TETRIS_curren_piece.y--;
      end
    end
    if(is_key_pressed(PLAYER_1,KEY_A)) ct++; else ct=0; end
    //Se comprueba si hay colisi�n simulando que la figura est� rotada para verlo, sin rotarla de verdad hasta que se ve que se puede.
    if( ct==1 and simpletetris_is_valid_position(TETRIS_curren_piece.index,(TETRIS_curren_piece.rotation+1)%4,TETRIS_curren_piece.x,TETRIS_curren_piece.y)) 
      TETRIS_curren_piece.rotation = (TETRIS_curren_piece.rotation+1)%4; 
    end


    neer--; //Decrementa el tiempo (en frames) antes de que el bloque actual pueda bajar una l�nea
    if(neer == 0) //Si es hora de bajar una l�nea...
      //Detecto si la posici�n vertical justo inferior est� ocupada. Si es as�...
      if(simpletetris_is_valid_position(TETRIS_curren_piece.index,TETRIS_curren_piece.rotation,TETRIS_curren_piece.x,TETRIS_curren_piece.y+1)==0)
        /*no puede descender una l�nea, se asigna y -podr�a ser cualquier otra variable- a true 
        para que el proceso sepa que es el turno del siguiente bloque*/
        y = 1;
      else
        //Si puede, baja y a�ade una puntuaci�n b�sica a la puntuaci�n total
        TETRIS_curren_piece.y++;
        TETRIS_score = TETRIS_score + TETRIS_score_for_move;
      end
      neer = TETRIS_piece_SPEED; //El tiempo para el pr�ximo descenso de un bloque es TETRIS_piece_SPEED
    else //No es hora de bajar una l�nea, as� que no hay nuevo bloque hasta que sea la hora
      y = 0;
    end

    //Si y es true es hora de un nuevo bloque
    if(y==1)
      for(i=0;i<TETRIS_ANCHO_PIEZA;i++)
        for(j=0;j<TETRIS_ALTO_PIEZA;j++)
        switch(TETRIS_curren_piece.rotation)
          case TETRIS_NOT_ROTATED:
           k = i;
           l = j;
          end
          case TETRIS_ROTATED_90:
           k = j;
           l = TETRIS_pieces[TETRIS_curren_piece.index].width-1-i;
          end
          case TETRIS_ROTATED_180:
           k = TETRIS_pieces[TETRIS_curren_piece.index].width-1-i;
           l = TETRIS_pieces[TETRIS_curren_piece.index].height-1-j;
          end
          case TETRIS_ROTATED_270:
           k = TETRIS_pieces[TETRIS_curren_piece.index].height-1-j;
           l = i ;
          end
        end
          //Por cada casilla que tenga la pieza actual, marco las casillas l�gicas que ocupa dentro del campo de juego como definitivamente ocupadas  y pinto su gr�fico determinado all� fijo.
          if(TETRIS_pieces[TETRIS_curren_piece.index].data[i][j] > 0) 
            TETRIS_board[k+TETRIS_curren_piece.x][l+TETRIS_curren_piece.y] = TETRIS_pieces[TETRIS_curren_piece.index].color;
          end
        end
      end
      TETRIS_curren_piece.index = TETRIS_next;//Nuevo bloque!. El bloque siguiente 'TETRIS_next' es asignado al bloque actual 'TETRIS_curren_piece.index' 
      TETRIS_pieces_statistic[TETRIS_curren_piece.index]++;
      TETRIS_next = rand(0,TETRIS_pieces_count-1); //Y se escoge un nuevo tipo de bloque para 'TETRIS_next'
      //Se reinician las variables que manejaban las �rdenes de movimiento de piezas por parte del usuario
      li = -300; r = -300; d = -300;
      //Se reinicia la posici�n y rotaci�n del nuevo bloque
      TETRIS_curren_piece.x = TETRIS_ANCHO/2-1; TETRIS_curren_piece.y = 0; TETRIS_curren_piece.rotation = TETRIS_NOT_ROTATED;
      //Se desciende hasta que el fondo est� lleno
      while(simpletetris_is_valid_position(TETRIS_curren_piece.index,TETRIS_curren_piece.rotation,TETRIS_curren_piece.x,TETRIS_curren_piece.y)==0)
        TETRIS_curren_piece.y++;
        /*Si el descenso tarda demasiado, significa que el nuevo bloque no puede colocarse.
        El campo de juego est� lleno y el jugador est� game over*/
        if(TETRIS_curren_piece.y >= 4)
          simpletetris_gameover(); 
          return; 
        end
      end
    end // if y
    frame;
  end //loop
end


//-----------------------------------------------------------------------------------------------------------------------

/*Devuelve si una pieza (su n�mero de pieza viene dado en 'id_TETRIS_piece' con rotaci�n 'id_rotation')
puede caber o no (devuelve true o false) en una posici�n dentro del campo de juego.*/
Function simpletetris_is_valid_position(int id_TETRIS_piece,int id_rotation,x,y)
private
  int i,j,k,l;
end
begin    
  //Recorro las casillas de la pieza
  for(i=0;i<TETRIS_ANCHO_PIEZA;i++)
    for(j=0;j<TETRIS_ALTO_PIEZA;j++)
      switch(id_rotation)
          case TETRIS_NOT_ROTATED:
           k = i;
           l = j;
          end
          case TETRIS_ROTATED_90:
           k = j;
           l = TETRIS_pieces[TETRIS_curren_piece.index].width-1-i;
          end
          case TETRIS_ROTATED_180:
           k = TETRIS_pieces[TETRIS_curren_piece.index].width-1-i;
           l = TETRIS_pieces[TETRIS_curren_piece.index].height-1-j;
          end
          case TETRIS_ROTATED_270:
           k = TETRIS_pieces[TETRIS_curren_piece.index].height-1-j;
           l = i ;
          end
      end
      if(TETRIS_pieces[id_TETRIS_piece].data[i][j]==1) //Si esta casilla tiene un bloque
        //HELPME: L�nea important�sima que se ha de entender con l�piz y papel
        k = x+k;
        l = y+l;
        //No cabe porque se choca contra los l�mites
        if(k < 0 or k>TETRIS_ANCHO-1 or l< 0 or l>TETRIS_ALTO-1)
          return false; 
        end     
        //Si no pasa lo anterior, pero se choca contra casillas contiguas que est�n ocupadas por otros bloques,tampoco cabe.
        if(TETRIS_board[k][l]!=0) 
          return false; 
        end
      end
    end
  end
  return true;
end

//-----------------------------------------------------------------------------------------------------------------------

//Detecta las l�neas horizontales completas y act�a en consecuencia
Process simpletetris_detect_completed_TETRIS_lines()
private
  int i,j,k;
  int blocks_in_line;
  int complete_TETRIS_lines;
end
begin
  loop
    //Controla cu�ntas posiciones se han cogido para cada regla horizontal
    complete_TETRIS_lines = 0;
    for(j = TETRIS_ALTO-1;j >= 0;j--)
      blocks_in_line = 0;
      for(i = 0;i < TETRIS_ANCHO;i++)
        if(TETRIS_board[i][j] != 0) blocks_in_line++; end
      end
      //Si la cantidad de piezas en una l�nea es igual a la cantidad de posiciones, �l�nea completada!
      if(blocks_in_line == TETRIS_ANCHO)
        complete_TETRIS_lines++;
        //Mueve el resto de las l�neas una posici�n para abajo      
        for(k = j;k>0;k--)
          for(i = 0;i < TETRIS_ANCHO;i++)   
            TETRIS_board[i][k] = TETRIS_board[i][k-1];
          end
          frame;
        end
        j++;   
      end
    end  
    for(i = 1;i < complete_TETRIS_lines+1;i++)
        TETRIS_score=TETRIS_score +i*TETRIS_score_for_line; //Se a�aden los puntos por una linea a la puntuaci�n del jugador
    end
    TETRIS_lines += complete_TETRIS_lines;
    frame;
  end //Loop
end


//-----------------------------------------------------------------------------------------------------------------------
//Proceso para gestionar el game over del jugador
Process simpletetris_gameover()
private
  int t;
end
begin
  x = write(0,440,320,4,"Game Over");
  y = write(0,440,340,4,"Pulsa ENTER para volver a comenzar");
  let_me_alone(); //Acaba con todos los procesos excepto el actual
  simpletetris_main_board();
  simpletetrisTETRIS_next_TETRIS_piece(); 
  while (!is_key_pressed(PLAYER_1,KEY_CLOSE))
    //Se vuelve a comenzar despu�s de un bonito efecto
    if(is_key_pressed(PLAYER_1,KEY_START))
      //Se borran s�lo los textos del Game Over
      delete_text(x);
      delete_text(y);
      //Si hay r�cords, se borran el texto de nuevo r�cord, tambi�n
      if(t != 0) delete_text(t); end
      //Se hace el efecto de rellenar el campo de juego por completo...
      for(y=0;y<TETRIS_ALTO;y++)
         for(x=0;x<TETRIS_ANCHO;x++)
          TETRIS_board[x][y] = RGB(255,255,255);
         end
         frame;
      end
      //...y seguidamente vac�a para poder volver a jugar.
      for(y=TETRIS_ALTO-1;y>=0;y--)
        for(x=0;x<TETRIS_ANCHO;x++)
         TETRIS_board[x][y] = 0;
        end
        frame;
      end
      //Y se empieza a jugar
      let_me_alone();
      simpletetris_game();
      return;
    end
    frame;
  end
  while (is_key_pressed(PLAYER_1,KEY_CLOSE)) frame; end
  let_me_alone();
  delete_text(all_text);
  simpletetris_menu();
end

function int is_key_pressed(int player, int key_id)
begin
    return  key(player_key[player][key_id]);
end
