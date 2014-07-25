classdef latticeVector < handle
    %MYVECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        leng
        nsite
        neib
        mon
        dim
        weights
        triadd
        %handlers for monomers and dimers figs
        hmon
        hdim
        hext_dim %handlers for external legs
        ext_idx %indeces to access hext_dim
        %colors
        colors
    end
    
    methods
        function obj = latticeVector(val1)
            obj.leng= val1;
            obj.nsite = val1*val1*val1;
            obj.neib = zeros([obj.nsite,6]);
            obj.mon = ones([1,obj.nsite]);
            obj.dim = ones([obj.nsite,3]);
            obj.weights = [0,0,0,0];
            obj.triadd = [3, 1, 2; 1, 2, 3; 2, 3, 1];
            % allocate arrays of graphic handlers
            obj.hmon = gobjects([1,obj.nsite]);
            obj.hdim = gobjects([obj.nsite,3]);
            % total of leng*3 handlers (3 = num. of dimensions)
            obj.hext_dim = gobjects([1,obj.leng*obj.leng*3]);
            obj.ext_idx = zeros([obj.nsite,3]);
            obj.colors = [[1 0 0];[1 1 1];[0 0 1];[1 1 0];[0 1 0]];
        end
        
        %-------------------------------------------------------------
        function initLattice(obj)
           for i1 = 0:obj.leng-1,
               i1p = i1 + 1;
               i1m = i1 - 1;
               if (i1 == (obj.leng-1) ) 
                 i1p = 0 ;
               end
               if (i1 == 0) 
                 i1m = obj.leng-1; 
               end

           for i2 = 0:obj.leng-1,
               i2p = i2 + 1;
               i2m = i2 - 1;
               if (i2 == (obj.leng-1) ) 
                 i2p = 0 ;
               end
               if (i2 == 0) 
                 i2m = obj.leng-1; 
               end

           for i3 = 0:obj.leng-1,
               i3p = i3 + 1;
               i3m = i3 - 1;
               if (i3 == (obj.leng-1) ) 
                 i3p = 0 ;
               end
               if (i3 == 0)         
                 i3m = obj.leng-1 ;
               end
 
               % compute the site address and the addresses 
               % of the sites shifted
               % by one unit in each direction

               is = i1 + (i2 + i3*obj.leng)*obj.leng + 1;

               isp1 = i1p + (i2 +  i3*obj.leng)*obj.leng + 1;   
               isp2 = i1 + (i2p + i3*obj.leng)*obj.leng + 1; 
               isp3 = i1 + (i2 +  i3p*obj.leng)*obj.leng + 1;  
 
               ism1 = i1m + (i2 +  i3*obj.leng)*obj.leng + 1;  
               ism2 = i1 + (i2m + i3*obj.leng)*obj.leng + 1; 
               ism3 = i1 + (i2 +  i3m*obj.leng)*obj.leng + 1;

               % fill in the neighborhood array

               obj.neib(is,1) = isp1;
               obj.neib(is,2) = isp2;
               obj.neib(is,3) = isp3;
 
               obj.neib(is,4) = ism1;
               obj.neib(is,5) = ism2;
               obj.neib(is,6) = ism3;
  
           end
           end
           end
           
        end
       
        %-------------------------------------------------------------
        function initWeights(obj,tau,kappa,mu)

            for l = -1:1
              obj.weights(l+2) = (exp(2*kappa*cosh(mu)) + ...
                2*exp(-kappa*cosh(mu))*cos(sqrt(3)*kappa*sinh(mu) - l*2*pi/3))/3;
            end
            
            expt = exp(tau);
            obj.weights(4) = (expt^2 - 1/expt)/(expt^2 + 2/expt);

        end
        
        %-------------------------------------------------------------
        function plotLattice(obj)

            iext = 1;
            for iz=1:obj.leng
            for iy=1:obj.leng
            for ix=1:obj.leng
                is = ix + obj.leng*(iy-1 + (iz-1)*obj.leng);
            
                % plot monomers
                obj.hmon(is) = plot3(ix,iy,iz,'o','MarkerEdgeColor',...
                    obj.colors(obj.mon(is)+1,:),...
                    'MarkerFaceColor',obj.colors(obj.mon(is)+1,:));
                
                %plot dimers, dir=1
                if (ix<obj.leng)
                    obj.hdim(is,1) = plot3([ix ix+1],[iy iy],[iz iz],...
                        '-','Color',obj.colors(obj.dim(is,1)+1,:),'LineWidth',1.5);
                else
                    obj.hdim(is,1) = plot3([ix ix+0.5],[iy iy],[iz iz],...
                        '-','Color',obj.colors(obj.dim(is,1)+1,:),'LineWidth',1.5);
                    obj.hext_dim(iext) = plot3([0.5 1],[iy iy],[iz iz],...
                        '-','Color',obj.colors(obj.dim(is,1)+1,:),'LineWidth',1.5);
                    obj.ext_idx(is,1) = iext;
                    iext = iext + 1;
                end
                
                %plot dimers, dir=2
                if (iy<obj.leng)
                    obj.hdim(is,2) = plot3([ix ix],[iy iy+1],[iz iz],...
                        '-','Color',obj.colors(obj.dim(is,2)+1,:),'LineWidth',1.5);
                else
                    obj.hdim(is,2) = plot3([ix ix],[iy iy+0.5],[iz iz],...
                        '-','Color',obj.colors(obj.dim(is,2)+1,:),'LineWidth',1.5);
                    obj.hext_dim(iext) = plot3([ix ix],[0.5 1],[iz iz],...
                        '-','Color',obj.colors(obj.dim(is,2)+1,:),'LineWidth',1.5);
                    obj.ext_idx(is,2) = iext;
                    iext = iext + 1;
                end

                %plot dimers, dir=3
                if (iz<obj.leng)
                    obj.hdim(is,3) = plot3([ix ix],[iy iy],[iz iz+1],...
                        '-','Color',obj.colors(obj.dim(is,3)+1,:),'LineWidth',1.5);               
                else
                    obj.hdim(is,3) = plot3([ix ix],[iy iy],[iz iz+0.5],...
                        '-','Color',obj.colors(obj.dim(is,3)+1,:),'LineWidth',1.5);
                    obj.hext_dim(iext) = plot3([ix ix],[iy iy],[0.5 1],...
                        '-','Color',obj.colors(obj.dim(is,3)+1,:),'LineWidth',1.5);
                    obj.ext_idx(is,3) = iext;
                    iext = iext + 1;
                end
           
            end %ix    
            end % iy
            end % iz

        end
        
        %-------------------------------------------------------------
        function refreshLattice(obj)
            
            for is=1:obj.nsite
                % plot monomers
                set(obj.hmon(is),'MarkerSize',6);
                
                %plot dimers
                set(obj.hdim(is,1),'LineWidth',1.5);
                set(obj.hdim(is,2),'LineWidth',1.5);
                set(obj.hdim(is,3),'LineWidth',1.5);                          
            end 
            
            for is=1:3*obj.leng*obj.leng
                set(obj.hext_dim(is),'LineWidth',1.5); 
            end
            
        end
        
    end % methods
    
end