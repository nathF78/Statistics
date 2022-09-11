
% TP2 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Foucher
% Prénom : Nathan
% Groupe : 1SN-C

function varargout = fonctions_TP2_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction centrage_des_donnees (exercice_1.m) ----------------------------
function [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)
    x_G = sum (x_donnees_bruitees)/length(x_donnees_bruitees);
    y_G = sum(y_donnees_bruitees)/length(y_donnees_bruitees);
    
    x_donnees_bruitees_centrees = x_donnees_bruitees - x_G;
    y_donnees_bruitees_centrees = y_donnees_bruitees - y_G;
end

% Fonction estimation_Dyx_MV (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
           estimation_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

    psi = (rand(n_tests,1)*(-pi)+pi/2);
    v = sum((repmat(y_donnees_bruitees_centrees,n_tests, 1) - tan(psi)*x_donnees_bruitees_centrees).^2, 2);
    [~,i] = min(v);
    a_Dyx = tan(psi(i));
    b_Dyx = y_G - a_Dyx*x_G;
end

% Fonction estimation_Dyx_MC (exercice_2.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
                   estimation_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)

   % [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

    A = [x_donnees_bruitees ; ones(1,length(x_donnees_bruitees))]';
    B = y_donnees_bruitees';
    
    X = inv(A'*A)*A'*B;
    a_Dyx = X(1);
    b_Dyx = X(2);
end

% Fonction estimation_Dorth_MV (exercice_3.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
         estimation_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);
    theta = (rand(n_tests,1)*pi);
    
    %pour theta 
    v = sum((sin(theta)*y_donnees_bruitees_centrees + cos(theta)*x_donnees_bruitees_centrees).^2, 2);
    [~,i] = min(v);
    theta_Dorth = theta(i);

    %pour rho 
    rho_Dorth = x_G*cos(theta_Dorth) + y_G*sin(theta_Dorth);
end

% Fonction estimation_Dorth_MC (exercice_4.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
                 estimation_Dorth_MC(x_donnees_bruitees,y_donnees_bruitees)

    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);
    C = [x_donnees_bruitees_centrees ; y_donnees_bruitees_centrees]';
    [V,D] = eig(C'*C);
    D = diag(D) %car D est diagonale 
    [~,i] = min(D)
    Y = V(:, i);
    theta_Dorth = atan(Y(2)/Y(1));
    rho_Dorth = x_G*cos(theta_Dorth) + y_G*sin(theta_Dorth);

end
