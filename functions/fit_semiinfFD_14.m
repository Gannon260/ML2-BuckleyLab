function f=fit_semiinfFD_13(x0,n,Reff,lambda,r,w,AC,ph,ACstd,phstd)
%Method 13
mua=x0(1);
musp=x0(2);

for j=1:length(r)
    [amp(j),phase(j)]=diffusionforwardsolver(n,Reff,mua,musp,0,0,lambda,r(j),w);
end

ind=find(r==min(r));

%Normalize amp and phase to smallest s-d separation
amp=amp./amp(ind);
phase=phase-phase(ind);
AC=AC./AC(ind);
ph=ph-ph(ind);


indamp=find(amp~=1);
indph=find(phase~=0);
%f=norm(cat(2,((log(amp(indamp))-log(AC(indamp).'))./log(amp(indamp))).^2 , ((phase(indph)-ph(indph).')./phase(indph)).^2));
%f=norm(cat(2,(log(amp(indamp))-log(AC(indamp).'))./log(amp(indamp)) , (phase(indph)-ph(indph).')./phase(indph)));
%f=norm(cat(2,(log(amp)-log(AC.'))./log(amp) , (phase-ph.')./phase));
%f=norm(cat(2,(log(AC)-log(amp))./log(ACse) , (ph-phase)./phse));

%ACrange = max(log(AC(indamp))) - min(log(AC(indamp)));
%phrange = max(ph(indph)) - min(ph(indph));
%f=norm(cat(2,(log(AC(indamp))-log(amp(indamp).')), (ph(indph)-phase(indph).')*ACrange/phrange ));

a = (log(AC) - log(amp.'));
b = (ph - phase.');
ACrange = max(a) - min(a);
phrange = max(b) - min(b);
f=norm(cat(1,a,b*ACrange/phrange ));
