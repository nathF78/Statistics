
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Foucher
% Prenom : Nathan
% Groupe : 1SN-C

function varargout = fonctions_TP3_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)
    A = [cos(theta),sin(theta)]; %AX=rho avec X=[xf;yf]
    X = pinv(A)*rho;
    rho_F = sqrt(X(1)^2+X(2)^2);
    theta_F = atan2(X(2),X(1));

    % A modifier lors de l'utilisation de l'algorithme RANSAC (exercice 2)
    m = length(theta_F);
    ecart_moyen = (1/length(theta))*sum(abs(rho-rho_F.*cos(theta-theta_F)));

end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres)

    S1 = parametres(1);
    S2 = parametres(2);
    Vecart_moyen = [];
    Vrho_F_estime = [];
    Vtheta_F_estime = [];

    %début de la boucle itérative
    for k = 1:parametres(3)
        indices = randperm(length(rho),2);  %les deux indices necessaires
        [rho_star,theta_star,~] = estimation_F([rho(indices(1)),rho(indices(2))]',[theta(indices(1)),theta(indices(2))]'); %on obtient les estimations temporaires, on les vérifies après
        ecart = abs(rho-rho_star.*cos(theta-theta_star));
        conform_index = find(ecart <= S1);     %donne les indices des données conformes
        if length(conform_index)/length(rho) >= S2  %si on a plus de n*S2 données conformes alors...
            [rho_estime,theta_estime,ecart_moyen] = estimation_F(rho(conform_index),theta(conform_index)); %on reestime avec les données conformes
            %on ajoute les nouvelles données dans un vecteur
            Vecart_moyen = [Vecart_moyen,ecart_moyen];
            Vrho_F_estime = [Vrho_F_estime,rho_estime];
            Vtheta_F_estime = [Vtheta_F_estime,theta_estime];
        end
    end
    %on trouve l'indice ou l'ecart moyen est le minimum
    [~,indice] = min(Vecart_moyen);
    %on renvoit rho et theta à cet indice
    rho_F_estime = Vrho_F_estime(indice);
    theta_F_estime = Vtheta_F_estime(indice);
    end

% Fonction G_et_R_moyen (exercice_3.m, bonus, fonction du TP1) ------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)



end

% Fonction estimation_C_et_R (exercice_3.m, bonus, fonction du TP1) -------
function [C_estime,R_estime,critere] = ...
         estimation_C_et_R(x_donnees_bruitees,y_donnees_bruitees,n_tests,C_tests,R_tests)
     
    % Attention : par rapport au TP1, le tirage des C_tests et R_tests est 
    %             considere comme etant deje effectue 
    %             (il doit etre fait au debut de la fonction RANSAC_3)



end

% Fonction RANSAC_3 (exercice_3, bonus) -----------------------------------
function [C_estime,R_estime] = ...
         RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres)
     
    % Attention : il faut faire les tirages de C_tests et R_tests ici



end
