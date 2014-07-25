function worm( lat, fplot )
%NWORMS Summary of this function goes here
%   Detailed explanation goes here
    
wormsgn = 2; % increase 1
if ( rand < 0.5 ) 
    wormsgn = 0;  % decrease 1
end
p = 0;
x = floor(rand*lat.nsite) + 1;
x0 = x;
if (fplot)
    % draw worm's head
    set(lat.hmon(x0),'MarkerEdgeColor',lat.colors(4,:),'MarkerFaceColor',lat.colors(4,:),...
        'MarkerSize',7);
    uistack(lat.hmon(x0),'top');
    pause(0.3);
end

acc = 0;
[p,x,acc] = add_link(lat,wormsgn,p,x,acc,fplot);
if (fplot==1 && acc==1)
    % draw worm's tail
    set(lat.hmon(x),'MarkerEdgeColor',lat.colors(5,:),'MarkerFaceColor',lat.colors(5,:),...
        'MarkerSize',6);
    uistack(lat.hmon(x),'top');
    pause(0.3);
end
while( x~=x0 || p~=0 )
    xold = x;
    [p,x,acc] = add_link(lat,wormsgn,p,x,acc,fplot);
    if (fplot==1 && acc==1)
        % move worm's tail
        set(lat.hmon(xold),'MarkerEdgeColor',lat.colors(lat.mon(xold)+1,:),...
         'MarkerFaceColor',lat.colors(lat.mon(xold)+1,:),'MarkerSize',6);
        set(lat.hmon(x),'MarkerEdgeColor',lat.colors(5,:),'MarkerFaceColor',lat.colors(5,:),...
            'MarkerSize',6);
        uistack(lat.hmon(x),'top');
        uistack(lat.hmon(x0),'top');
        pause(0.3);
    end
end

% erase worm's head
if (fplot)
    set(lat.hmon(x0),'MarkerEdgeColor',lat.colors(lat.mon(x0)+1,:),...
        'MarkerFaceColor',lat.colors(lat.mon(x0)+1,:),'MarkerSize',6);
end
  
end


function [p,x,acc] = add_link(lat,wormsgn,p,x,acc,fplot)

  acc=0;
  
  if (p~=0)
    while(p~=0)
      xnew = floor(rand*lat.nsite) + 1;
      d = lat.mon(xnew) + 1;
      delta = 2 - wormsgn + 1;
      dnew = lat.triadd(d,delta);

      if (rand <= lat.weights(dnew)/ lat.weights(d) )
        x = xnew;
        p = 0;
        lat.mon(x) = dnew-1;
        acc=1;
        % update the monomer's color and size
        if (fplot)
            set(lat.hmon(x),'MarkerEdgeColor',lat.colors(lat.mon(x)+1,:),...
                'MarkerFaceColor',lat.colors(lat.mon(x)+1,:),'MarkerSize',7);
        end
      end
    end
    
  else
    nu = floor(rand*9) + 1;

    if ( nu >= 7 )
      d = lat.mon(x) + 1;
      dnew = lat.triadd(d,wormsgn+1);

      if ( rand <=  lat.weights(dnew)/lat.weights(d))
        p = 1;
        lat.mon(x) = dnew-1;
        acc=1;
        % update the monomer's color and size
        if (fplot)
            set(lat.hmon(x),'MarkerEdgeColor',lat.colors(lat.mon(x)+1,:),...
                'MarkerFaceColor',lat.colors(lat.mon(x)+1,:),'MarkerSize',7);
        end
      end
    else
      xnew = lat.neib(x,nu);

      if ( nu <= 3 )
        xadd = x;
        nuadd = nu;
        delta = wormsgn+1;
      else
        xadd = xnew;
        nuadd = nu - 3;
        delta = 2-wormsgn+1;
      end

      d = lat.dim(xadd,nuadd)+1;

      if ( d == 2 )
        if ( rand <= lat.weights(4) )
          x = xnew; 
          lat.dim(xadd,nuadd) = lat.triadd(d,delta) - 1;
          acc=1;
          % update the dimers's color and size
          if (fplot)
            set(lat.hdim(xadd,nuadd),'Color',lat.colors(lat.triadd(d,delta),:),...
                'LineWidth',2.7);
            if (lat.ext_idx(xadd,nuadd)~=0)
                set(lat.hext_dim(lat.ext_idx(xadd,nuadd)),'Color',...
                    lat.colors(lat.triadd(d,delta),:),'LineWidth',2.7);
            end
          end
        end
      else
        x = xnew;
        lat.dim(xadd,nuadd) = lat.triadd(d,delta)-1;
        acc=1;
        % update the dimers's color and size
        if (fplot)
            set(lat.hdim(xadd,nuadd),'Color',lat.colors(lat.triadd(d,delta),:),...
                'LineWidth',2.7);
            if (lat.ext_idx(xadd,nuadd)~=0)
                set(lat.hext_dim(lat.ext_idx(xadd,nuadd)),'Color',...
                    lat.colors(lat.triadd(d,delta),:),'LineWidth',2.7);
            end
        end
      end
      
    end % insert either a dimer or a monomer
  end % if(p~=0)
  
end