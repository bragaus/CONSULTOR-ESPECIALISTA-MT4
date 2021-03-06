//+------------------------------------------------------------------+
//|                                         AjudaParaTraçasZonas.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int OnInit()
  {

      int i;
      int obj_total=ObjectsTotal();
      long colorName;
      double Preco1;
      
      /*
      for(i=0;i<obj_total;i++)
         {
      
            //colorName = ObjectGetInteger(ChartID(),ObjectName(i),OBJPROP_COLOR);
            //Preco1 = ObjectGetDouble(ChartID(),ObjectName(i),OBJPROP_PRICE1);
            
            // Print(Preco1);
            //  Print(colorName);
            
            //name=ObjectName(i);
            
            //printf("Objects color is %s",ColorToString(object.GetInteger(OBJPROP_COLOR,1),true)); 
            
            //PrintFormat("%d object: Object name - %s",i,name);
         }
        */
     
      long x_distance;
      long y_distance; 
      ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0,x_distance);
      ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0,y_distance);
      int x=(int)x_distance;
      int y=(int)y_distance/1.04;
     
     
      //------------
      ObjectCreate(_Symbol,"TODOS",OBJ_BUTTON,0,0,0);
      
      // distancia da borda
      ObjectSetInteger(_Symbol,"TODOS",OBJPROP_XDISTANCE,x);
      ObjectSetInteger(_Symbol,"TODOS",OBJPROP_YDISTANCE,y);
      
      // largura
      ObjectSetInteger(_Symbol,"TODOS",OBJPROP_XSIZE,50);
      ObjectSetInteger(_Symbol,"TODOS",OBJPROP_YSIZE,20);
      
      ObjectSetInteger(_Symbol,"TODOS",OBJPROP_CORNER,1);
      
      // Texto
      ObjectSetString(_Symbol,"TODOS",OBJPROP_TEXT,"ALL");        
     
      //------------
      ObjectCreate(_Symbol,"SEMANAL",OBJ_BUTTON,0,0,0);
      
      // distancia da borda
      ObjectSetInteger(_Symbol,"SEMANAL",OBJPROP_XDISTANCE,x-100);
      ObjectSetInteger(_Symbol,"SEMANAL",OBJPROP_YDISTANCE,y);
      
      // largura
      ObjectSetInteger(_Symbol,"SEMANAL",OBJPROP_XSIZE,50);
      ObjectSetInteger(_Symbol,"SEMANAL",OBJPROP_YSIZE,20);
      
       
      ObjectSetInteger(_Symbol,"SEMANAL",OBJPROP_CORNER,1);
      
      // Texto
      ObjectSetString(_Symbol,"SEMANAL",OBJPROP_TEXT,"W1");
      
      
      //------------
      ObjectCreate(_Symbol,"DIARIO",OBJ_BUTTON,0,0,0);
      
      // distancia da borda
      ObjectSetInteger(_Symbol,"DIARIO",OBJPROP_XDISTANCE,x-50);
      ObjectSetInteger(_Symbol,"DIARIO",OBJPROP_YDISTANCE,y);
      
      // largura
      ObjectSetInteger(_Symbol,"DIARIO",OBJPROP_XSIZE,50);
      ObjectSetInteger(_Symbol,"DIARIO",OBJPROP_YSIZE,20);
       
      ObjectSetInteger(_Symbol,"DIARIO",OBJPROP_CORNER,1);
      
      // Texto
      ObjectSetString(_Symbol,"DIARIO",OBJPROP_TEXT,"D1");  
      
      
      
   
     
     
      //------------     
      ObjectCreate(_Symbol,"ZONAS",OBJ_BUTTON,0,0,0);
      
      // distancia da borda
      ObjectSetInteger(_Symbol,"ZONAS",OBJPROP_XDISTANCE,x-150);
      ObjectSetInteger(_Symbol,"ZONAS",OBJPROP_YDISTANCE,y);
      
      // largura
      ObjectSetInteger(_Symbol,"ZONAS",OBJPROP_XSIZE,50);
      ObjectSetInteger(_Symbol,"ZONAS",OBJPROP_YSIZE,20);
      
       
      ObjectSetInteger(_Symbol,"ZONAS",OBJPROP_CORNER,1);
      
      // Texto
      ObjectSetString(_Symbol,"ZONAS",OBJPROP_TEXT,"ZON");       
     
      
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  }
//+------------------------------------------------------------------+

void OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam)
    {
         if(id == CHARTEVENT_OBJECT_CLICK) {
         
            int obj_total=ObjectsTotal();
            
            
            if(sparam == "SEMANAL")
              {
                  
                 
                  for(int i=0;i<obj_total;i++)
                    {
                     
                     long colorName = ObjectGetInteger(ChartID(),ObjectName(i),OBJPROP_COLOR);

                     if(colorName == 255) {
                        ObjectSet(ObjectName(i), OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1);
                     }
                     
                    }
                  
              }
              
             if(sparam == "DIARIO")
              {
                  
                 
                  for(int i=0;i<obj_total;i++)
                    {
                     
                     long colorName = ObjectGetInteger(ChartID(),ObjectName(i),OBJPROP_COLOR);

                     if(colorName == 16711680) {
                        ObjectSet(ObjectName(i), OBJPROP_TIMEFRAMES, OBJ_PERIOD_D1);
                     }
                     
                    }
                  
              } 
              
              if(sparam == "TODOS")
               {
               

                  for(int i=0;i<obj_total;i++)
                    {               
                        ObjectSet(ObjectName(i), OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
                    }
               }
            
               if(sparam == "ZONAS")
               {
               
                  double Preco1;
                  double Preco2;
                  datetime date1=D'2000.01.01 00:00:00';
                  datetime date2=D'2030.01.01 00:00:00';
                  int j;
                  string NomeRetangulo;
                  
                  
                  
                  for(int i=0;i<obj_total;i++)
                    {    
                    
                       // se for linha
                      if(ObjectGetInteger(ChartID(),ObjectName(i),OBJPROP_TYPE) == 1) {
                        
                           Preco1 = ObjectGetDouble(ChartID(),ObjectName(i),OBJPROP_PRICE1);
                           
                           if(ObjectGetInteger(ChartID(),ObjectName(i+1),OBJPROP_TYPE) == 1) {                           
                              Preco2 = ObjectGetDouble(ChartID(),ObjectName(i+1),OBJPROP_PRICE1);                      
                           }
                              
                           if (Preco1 > 0 && Preco2 > 0 ) {
                           
                              if(ObjectGetDouble(ChartID(),NomeRetangulo,OBJPROP_PRICE2) != Preco1)
                              {
                                 NomeRetangulo = "Rectangle"+MathRand();
                                 ObjectCreate(0,NomeRetangulo,OBJ_RECTANGLE,0,date1,Preco1,date2,Preco2);
                                 ObjectSetInteger(0,NomeRetangulo,OBJPROP_COLOR,clrPurple);
                              }
                           }                           
                      }
                    
        
                     
                     /*      
                        if(ObjectType(ObjectName(i)) == 1) {
                       
                           Preco1 = ObjectGetDouble(ChartID(),ObjectName(i),OBJPROP_PRICE1);
                           Print(Preco1);
                           Preco2 = ObjectGetDouble(ChartID(),ObjectName(i+1),OBJPROP_PRICE1);
                           Print(Preco2);
                        }
                                             
                        
                        if (Preco1 > 0 && Preco2 > 0 ) {
                        ObjectCreate(0,"Rectangle"+MathRand(),OBJ_RECTANGLE,0,date1,Preco1,date2,Preco2);
                        }
                        */
                        
                    }
               
               }
               
         } 
    }
    
   // 2021.12.17 23:16:32.882	AjudaParaTraçasZonas US2000,Weekly: 
