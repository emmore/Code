function H=entropy_ICA(X)
H=0.0;
[M,T]=size(X);
 for i=1:M
     for j=1:T
         X(i,j)=X(i,j)+normrnd(0,0.0001);
     end
 end
 [trans,A,W]=fastica(X');
 [P Q]=size(A);
 if P==Q
      H=log(abs(det(A)));
      for i=1:T
          H=H+entropy(trans(i,:));
      end
 else
     entropy_ICA(X);
 end
end
     
