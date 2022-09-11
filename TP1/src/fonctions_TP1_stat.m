
% TP1 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Foucher
% Prénom : Nathan
% Groupe : 1SN-C

function varargout = fonctions_TP1_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction G_et_R_moyen (exercice_1.m) ----------------------------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)

    X = mean(x_donnees_bruitees);
    Y = mean(y_donnees_bruitees);

    G = [X,Y];
    distances = sqrt((x_donnees_bruitees-X).^2+(y_donnees_bruitees-Y).^2);
    R_moyen = mean(distances);
     
end

% Fonction estimation_C_uniforme (exercice_1.m) ---------------------------
function [C_estime, R_moyen] = ...
         estimation_C_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    [G, R_moyen] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);

    x_generes = G(1)+(2*rand(n_tests,1)-1)*R_moyen;
    y_generes = G(2)+(2*rand(n_tests,1)-1)*R_moyen;

    BX = ones(n_tests,1)*x_donnees_bruitees-x_generes*ones(1,length(x_donnees_bruitees));
    BY = ones(n_tests,1)*y_donnees_bruitees-y_generes*ones(1,length(y_donnees_bruitees));

    distances = sqrt(BX.^2+BY.^2);
    B = (distances - R_moyen).^2;

    [~,i] = min(sum(B'));
    C_estime = [x_generes(i),y_generes(i)];
    
end

% Fonction estimation_C_et_R_uniforme (exercice_2.m) ----------------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    [G, R_moyen] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    
    x_generes = G(1)+(2*rand(n_tests,1)-1)*R_moyen;
    y_generes = G(2)+(2*rand(n_tests,1)-1)*R_moyen;
    r_generes = (rand(n_tests,1)+1/2)*R_moyen;

    BX = ones(n_tests,1)*x_donnees_bruitees-x_generes*ones(1,length(x_donnees_bruitees));
    BY = ones(n_tests,1)*y_donnees_bruitees-y_generes*ones(1,length(y_donnees_bruitees));
    matR_genere = r_generes*ones(1,length(x_donnees_bruitees));

    distances = sqrt(BX.^2+BY.^2);
    B = (distances - matR_genere).^2;
    [~,i] = min(sum(B'));

    C_estime = [x_generes(i),y_generes(i)];
    R_estime = r_generes(i);

end

% Fonction occultation_donnees (donnees_occultees.m) ----------------------
function [x_donnees_bruitees, y_donnees_bruitees] = ...
         occultation_donnees(x_donnees_bruitees, y_donnees_bruitees, theta_donnees_bruitees)

    theta1  = 2*pi*rand(1,1);
    theta2  = 2*pi*rand(1,1);

     if theta1 <= theta2 
         Indices = find(and(theta_donnees_bruitees > theta1,theta_donnees_bruitees < theta2));
     else 
         Indices = find(or(theta_donnees_bruitees < theta2,theta_donnees_bruitees > theta1));
     end 

     y_donnees_bruitees = y_donnees_bruitees(Indices);
     x_donnees_bruitees = x_donnees_bruitees(Indices);


end

% Fonction estimation_C_et_R_normale (exercice_4.m, bonus) ----------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_normale(x_donnees_bruitees,y_donnees_bruitees,n_tests)



end
