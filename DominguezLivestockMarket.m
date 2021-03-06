
function [] = DominguezLivestockMarket %no input variables, wont return output variables
global auction;%auction is the variable i want to use in multiple functions
auction.money = 0.00;%track of bids
auction.fig = figure('numbertitle','off','name','Dominguez Livestock Market');%my popup window that will display everything i want it too
auction.moneyDisplayMessage = uicontrol('style','text','units','normalized','position',[.034 .78 .09 .095],'string','Current Bid:','horizontalalignment','right');
auction.moneyDisplay = uicontrol('style','text','units','normalized','position',[.15 .78 .09 .05], 'string', num2str(auction.money), 'horizontalalignment', 'right');%displays dollar amount
auction.onehundreddollarSlot = uicontrol('style','pushbutton', 'units','normalized','position',[.034 .007 .14 .05],'string','Add $100.00','callback', {@addMoney,100.00});%amount of money my pushbottons have to add onto their current bid(1)
auction.fivehundreddollarSlot = uicontrol('style','pushbutton', 'units','normalized','position',[.180 .007 .14 .05],'string','Add $500.00','callback', {@addMoney,500.00});%amount of money my pushbottons have to add onto their current bid(2)

auction.reciept = uicontrol('style','pushbutton', 'units','normalized','position',[.81 .007 .14 .05],'string','Print Reciept','callback', {@PrintReciept});%like my previous money slots, this is for the print recipt push button (3)
auction.hereford = 0;%recipt count starts at zero and works its way up
auction.angus = 0;

K = imread('Hereford.jpeg');%imreads the image from the file specified by filename
subplot(1,2,1); %Position of my images
imshow(K); %learned that im show displays the image
title('Hereford')% Added title so they know which is which

J = imread('Angus.jpeg');%imreads the image from the file specified by filename
subplot(1,2,2);%Position of my images
imshow(J);%learned that im show displays the image
title('Angus')% Added title so they know which is which




auction.cattle(1) = uicontrol('style','pushbutton', 'units','normalized','position',[.50 .76 .18 .05],'string','Hereford','callback', {@auctionCattle,1000,1});
auction.stock(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .76 .05 .05], 'string', '800', 'horizontalalignment', 'right');%amount of herefords i have
auction.price(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.35 .76 .07 .05], 'string', '$1,000', 'horizontalalignment', 'right');%price i want for them
auction.stockText(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .76 .15 .05], 'string', 'Cattle Count:', 'horizontalalignment', 'right');

auction.cattle(2) = uicontrol('style','pushbutton', 'units','normalized','position',[.50 .70 .18 .05],'string','Angus','callback', {@auctionCattle,1200,2});
auction.stock(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .70 .05 .05], 'string', '500', 'horizontalalignment', 'right');%amount of angus i have
auction.price(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.35 .70 .07 .05], 'string', '$1,200', 'horizontalalignment', 'right');%price i want for them
auction.stockText(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .70 .15 .05], 'string', 'Cattle Count:', 'horizontalalignment', 'right');


end

function [] = addMoney(source,event,cash)%takes in my 3 elements into account
global auction; %varaible for multiple use
auction.money= auction.money+cash;
auction.moneyDisplay.String = num2str(auction.money);%converting numbers into character arrays

end


function [] =auctionCattle(source,event,price,index)%takes in my 4 elements into account
global auction;%varaible for multiple use
if auction.money >= price && str2num(auction.stock(index).String) >= 1
  auction.money= auction.money - price
  auction.moneyDisplay.String= num2str(auction.money)
   auction.stock(index).String = num2str(str2num(auction.stock(index).String)-1);%as cattle is bought the stock will go down as well
   cattle= ['Winner of ', source.String];
if index == 1
auction.hereford = auction.hereford +1;
else 
auction.angus = auction.angus + 1;
end 
  msgbox(cattle, 'Dominguez Livestock Market Slot', 'modal');
elseif auction.money < price %if they bid less than what is asked for they lose the bid
    msgbox('Bid Lost!', 'Dominguez Livestock Market Error','error','modal')
elseif str2num(auction.stock(index).String) < 1 %if they try to purchase cattle we have ran out of they will be informed that we dont have anything left for them to purchase
    msgbox('SELLOUT', 'Vending Machine Error','error','modal')
end
end

function [] = PrintReciept(~,~) %function for my print recipt push button, in order to popup 
global auction;%varaible for multiple use
cattle=['Purchased Cattle:', ' Angus ', num2str( auction.angus) ,', Hereford ',num2str( auction.hereford)];%So the recipts display the amount of Herefords/Angus you bought.
msgbox(cattle, 'Dominguez Livestock Market Slot', 'modal'); 


end


