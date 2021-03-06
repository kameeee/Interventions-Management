<?php
/*
 * les mots de passe chef du corps : MD : 1234 pwd : 1234
 * les mots de passe Responsable   : MD : 1 pwd : 111
 * les mots de passe Responsable   : MD : 2 pwd : 222
 * les mots de passe Responsable   : MD : 3 pwd : 333
 * les mots de passe pompier  : MD : 4 pwd : 4444
 * les mots de passe pompier  : MD : 5 pwd : 5555
 * les mots de passe pompier  : MD : 6 pwd : 6666
 * les mots de passe pompier  : MD : 7 pwd : 7777
 * les mots de passe pompier  : MD : 8 pwd : 8888
 *
 *
 * le bouton ajout ne marche pas avec la base prerempli car on a n'a pas gerer la recuperation des des P_CODE ; on les a ajouter
 * manuellement
 * elle marche uniquement avec la base de donner vide qui ne gerre pas la recuperation des des P_CODE
 *
 * on a utliser 2 methodes de routage dans l'index car certain etait habituer a une methode precis
 *
 * l'ajout des utilisatuers est deja gere par l'api ebrigade
 *
 *
 * il faut aussi  etre connecter a l'internet car les documents ajax on ete directement de certaine librairie sont telecharger directement
 *
 * */

require_once './autoload.php';

define('DS', DIRECTORY_SEPARATOR);
define('ROOT', dirname(__FILE__));
define('CONTROLLERS', ROOT.DS.'controllers');
define('VIEWS', ROOT.DS.'views');
define('MODELS', ROOT.DS.'models');
define('VENDORS', ROOT.DS.'vendors');
define('CLASSES', ROOT.DS.'classes');

//require_once './Api.php';
//require_once './autoload.php';
require_once './Controllers/HomeController.php ';
require_once './Controllers/UsersController.php ';



// ********************************************************************************************************.
// methode 1

if (isset($_GET['c']) && isset($_GET['m'])){
    //Il y a un paramètre de précisé: c'est le nom du controleur demandé.
    $controller=$_GET['c'];
    $method=$_GET['m'];
$controllerfilename=$controller.'.php';
//On inclut les fichiers nécessaires
include CONTROLLERS.DS.$controllerfilename;
$c=new $controller();
//On appelle la méthode derapportmandée (ou la méthode par défaut)
//id,title,firstname,middlename,lastname,nationalidnumber,birthday,hireday,maritialstatus,gender,heurevacance,heuremaladie,email,telephone,poste,idmanager
    if ($method == "Modificationrapport" ){
        $c->$method($_GET['id_rapport'],$_GET['rapport']);
    }
    elseif ($method == "valide" or $method == "rejete"){
        $c->$method($method,$_GET['id_rapport'],$_GET['commentaire']);
    }
    elseif ($method == "ajoutrapport" && isset($_GET['rapport']) && isset($_GET['numero_intervention'])){
    $c->$method($_GET['rapport'],$_GET['numero_intervention']);
}
elseif (isset($_GET['id']))
    $c->$method($_GET['id']);
else
    $c->$method();
}
else{

// methode 2 //
// **********************************************************************************************************.


$home = new HomeController();
$pages = ['details','analyses','parame','interventionAdd','add','home','update','delete','liste','login','login2','motdepasse',];
//if(true)
//var_dump($_SESSION);
//if(true)
if ( isset($_SESSION['logged']) && $_SESSION['logged'] ==true )
{
   // echo '<script language="JavaScript" type="text/javascript">window.location.replace("http://localhost/Interventions-Management/liste");</script>';

    //var_dump($_SESSION);

    include './Views/includes/header.php';
    include './Views/includes/navebar.php';
    include './Views/includes/sidebar.php';
    include './Views/includes/divs.php';

    if(isset($_GET['page']))
    {

        if(in_array($_GET['page'],$pages))
        {
            $page = $_GET['page'];
            $home->index($page);
        }

        else
        {
            include ('Views/includes/404.php');
        }


    }

    else

    {
        
        $home->index('home');
    }

        include_once './Views/includes/footer.php';

}

else 

{

//var_dump($_SESSION);

$home->index('login2');

}

}
?>

    