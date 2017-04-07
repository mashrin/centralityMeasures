function C=closeness(adj)
[m n]=size(adj); 
C=zeros(length(adj),1);
for i=1:length(adj); C(i)=(n-1)/sum( simple_dijkstra(adj,i) );
end
function d = simple_dijkstra(adj,s)
 n=length(adj);
d = inf*ones(1,n);\
d(s) = 0;
T = 1:n;
while not(isempty(T))
    [dmin,ind] = min(d(T));
    for j=1:length(T)
        if adj(T(ind),T(j))>0 & d(T(j))>d(T(ind))+adj(T(ind),T(j))
            d(T(j))=d(T(ind))+adj(T(ind),T(j));
        end
    end 
    T = setdiff(T,T(ind));
end
