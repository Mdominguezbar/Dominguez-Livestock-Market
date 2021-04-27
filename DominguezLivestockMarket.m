
function [] = DominguezLivestockMarket
global auction;
auction.money = 0.00;
auction.fig = figure('numbertitle','off','name','Dominguez Livestock Market');
auction.moneyDisplayMessage = uicontrol('style','text','units','normalized','position',[.034 .78 .09 .095],'string','Current Bid:','horizontalalignment','right');
auction.moneyDisplay = uicontrol('style','text','units','normalized','position',[.15 .78 .09 .05], 'string', num2str(auction.money), 'horizontalalignment', 'right');
auction.onehundreddollarSlot = uicontrol('style','pushbutton', 'units','normalized','position',[.034 .007 .14 .05],'string','Add $100.00','callback', {@addMoney,100.00});
auction.fivehundreddollarSlot = uicontrol('style','pushbutton', 'units','normalized','position',[.180 .007 .14 .05],'string','Add $500.00','callback', {@addMoney,500.00});

auction.reciept = uicontrol('style','pushbutton', 'units','normalized','position',[.81 .007 .14 .05],'string','Print Reciept','callback', {@PrintReciept});
auction.hereford = 0;
auction.angus = 0;

K = imread('Hereford.jpeg');
subplot(1,2,1);
imshow(K);
title('Hereford')

J = imread('Angus.jpeg');
subplot(1,2,2);
imshow(J);
title('Angus')




auction.cattle(1) = uicontrol('style','pushbutton', 'units','normalized','position',[.50 .76 .18 .05],'string','Hereford','callback', {@auctionCattle,1000,1});
auction.stock(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .76 .05 .05], 'string', '800', 'horizontalalignment', 'right');
auction.price(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.35 .76 .07 .05], 'string', '$1,000', 'horizontalalignment', 'right');
auction.stockText(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .76 .15 .05], 'string', 'Cattle Count:', 'horizontalalignment', 'right');

auction.cattle(2) = uicontrol('style','pushbutton', 'units','normalized','position',[.50 .70 .18 .05],'string','Angus','callback', {@auctionCattle,1200,2});
auction.stock(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .70 .05 .05], 'string', '500', 'horizontalalignment', 'right');
auction.price(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.35 .70 .07 .05], 'string', '$1,200', 'horizontalalignment', 'right');
auction.stockText(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .70 .15 .05], 'string', 'Cattle Count:', 'horizontalalignment', 'right');


end

function [] = addMoney(source,event,cash)
global auction;
auction.money= auction.money+cash;
auction.moneyDisplay.String = num2str(auction.money);

end


function [] =auctionCattle(source,event,price,index)
global auction;
if auction.money >= price && str2num(auction.stock(index).String) >= 1
  auction.money= auction.money - price
  auction.moneyDisplay.String= num2str(auction.money)
   auction.stock(index).String = num2str(str2num(auction.stock(index).String)-1);
   cattle= ['Winner of ', source.String];
if index == 1
auction.hereford = auction.hereford +1;
else 
auction.angus = auction.angus + 1;
end
  msgbox(cattle, 'Dominguez Livestock Market Slot', 'modal');
elseif auction.money < price
    msgbox('Bid Lost!', 'Dominguez Livestock Market Error','error','modal')
elseif str2num(auction.stock(index).String) < 1
    msgbox('SELLOUT', 'Vending Machine Error','error','modal')
end
end

function [] = PrintReciept(~,~)
global auction;
cattle=['Purchased Cattle:', ' Angus ', num2str( auction.angus) ,', Hereford ',num2str( auction.hereford)];
msgbox(cattle, 'Dominguez Livestock Market Slot', 'modal'); 


end


