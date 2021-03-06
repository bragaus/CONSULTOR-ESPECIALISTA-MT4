#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

input double Lots = 0.1;
input int TenkanSen = 9; //Tenkan-Sen
input int KijunSen = 26; //Kijun-Sen
input int SenkouSpanB = 52; //Senkou-Span-B
input string Commentary = "Comment";
input int Magic = 1;

int totalBars;



int OnInit()
  {
   totalBars = iBars(_Symbol,PERIOD_CURRENT);
   
   
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {
   int bars = iBars(_Symbol,PERIOD_CURRENT);
   
   // para executar o código apenas quando é criado uma nova barra
   if (totalBars != bars) {
   
      totalBars = bars;

      double tenkanSen1 = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_TENKANSEN,1);
      double kijunSen1 = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_KIJUNSEN,1);
      
      double tenkanSen2 = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_TENKANSEN,2);
      double kijunSen2 = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_KIJUNSEN,2);   
   
      double senkouSpanA = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_SENKOUSPANA,1);
      double senkouSpanB = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_SENKOUSPANB,1);
      
      if (tenkanSen1 > kijunSen1 && tenkanSen2<=kijunSen2) {
         
         for (int i = OrdersTotal()-1; i >= 0; i--) {
         
            if (OrderSelect(i,SELECT_BY_POS)) {
            
               if (OrderSymbol() == _Symbol && OrderMagicNumber() == Magic) {
               
                  if (OrderType() == OP_SELL) {
                  
                     if (OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,_Digits),100000)) {
                        Print("Closed pos #",OrderTicket());
                     }
                  }
               }
            }
         }
         
         if (Ask > senkouSpanA && Ask > senkouSpanB) {
                 
            double entry = Ask;
            entry = NormalizeDouble(entry,_Digits);
            
            int ticket = OrderSend(_Symbol,OP_BUY,Lots,entry,100000,0,0,Commentary,Magic);
         }
         

         
      } else if (tenkanSen1 < kijunSen1 && tenkanSen2 >= kijunSen2) {
      
      
         for (int i = OrdersTotal()-1; i >= 0; i--) {
         
            if (OrderSelect(i,SELECT_BY_POS)) {
            
               if (OrderSymbol() == _Symbol && OrderMagicNumber() == Magic) {
               
                  if (OrderType() == OP_BUY) {
                  
                     if (OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,_Digits),100000)) {
                        Print("Closed pos #",OrderTicket());
                     }
                  }
               }
            }
         }      
         
         if (Ask < senkouSpanA && Ask < senkouSpanB) {
         
            double entry = Bid;
            entry = NormalizeDouble(entry,_Digits);
            
            int ticket = OrderSend(_Symbol,OP_SELL,Lots,entry,100000,0,0,Commentary,Magic);         
         
         }
         
      }
      
   }
   
  }