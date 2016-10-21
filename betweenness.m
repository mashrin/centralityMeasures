function betw = node_betweenness_slow(adj)

n = numnodes(adj);

spaths=inf(n,n);


for k=1:n-1

  adjk=adj^k;

  for i=1:n

    for j=1:n

      if adjk(i,j)>0

        spaths(i,j)=min([spaths(i,j) adjk(i,j)]);

      end

    end

  end

end



betw = zeros(1,n);  

for i=1:n

    [J_st,route_st,J,route]=shortest_pathDP(adj,i,i,n);

    for j=1:n

        if i==j

            continue

        end


        [J_ji,step_ind] = min(J(:,j));

        route_ji = [j, route(step_ind,j).path];

        betw(route_ji(2:length(route_ji)-1)) = betw(route_ji(2:length(route_ji)-1)) + 1/spaths(j,i);

    end

end



betw=betw/nchoosek(n,2);



function n = numnodes(L)

n = length(L);


function [J_st,route_st,J,route]=shortest_pathDP(L,s,t,steps)

n = size(L,2);

L(find(L==0))=Inf;  % make all zero distances equal to infinity

for i=1:n
  J(steps,i) = L(i,t); 
  route(steps,i).path = [t];
end

for p=1:steps-1
  k=steps-p; % recurse backwards
  
  for i=1:n
    [J(k,i),ind_j] =  min(L(i,:)+J(k+1,:));
    route(k,i).path = [ind_j, route(k+1,ind_j).path];
  end
  
end

[J_st,step_ind] = min(J(:,s));
route_st = [s, route(step_ind,s).path];
J=J(sort(1:n,'descend'),:);
route=route(sort(1:n,'descend'),:);