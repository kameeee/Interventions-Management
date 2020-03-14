<?php
require_once './autoload.php';
require_once './index.php';
require_once './Controllers/HomeController.php ';
require_once './Controllers/UsersController.php ';
$users= UsersController::getAllUsers();

require_once 'Controllers/InterventionsController.php';
$Intervention = new InterventionsController();

?>


              
              <table class="table table-hover">
                  <thead>
                    <tr>
                        <th scope="col">Prenom</th>
                        <th scope="col">Nom</th>
                        <th scope="col">email</th>
                        <th scope="col">Sexe</th>
                        <th scope="col">Grade</th>
                        <th scope="col">Profession</th>
                        <th scope="col">Statut</th>

                        <th scope="col">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach($users as $user):?>

                  <tr <?php if( $_SESSION['username'] != $user['P_CODE'] && ( $Intervention->ispersonnel($_SESSION['username']) == true or $Intervention->isresponsable($_SESSION['username']) == true) ) echo 'hidden'?> >
                        <td scope="col"><?php echo $user['P_PRENOM'].''.$user['P_PRENOM2'];  ?></td>
                        <td scope="col"><?php echo $user['P_NOM'] ; ?></td>
                        <td scope="col"><?php echo $user['P_EMAIL'] ; ?></td>
                        <td scope="col"><?php echo $user['P_SEXE']  ;?></td>
                        <td scope="col"><?php echo $user['P_GRADE']  ;?></td>
                        <td scope="col"><?php echo $user['P_PROFESSION']  ;?></td>
                        <td scope="col"><?php echo $user['P_STATUT']  ;?></td>


                        <td  class="d-flex flex-row" >
                          
                        <form  class="mr-1" method="post" action="http://localhost/Interventions-Management/details">
                          <input type="hidden" name="P_ID" value="<?php
                           echo $user['P_ID'];?>">
                        <button class="btn btn-sm btn-info "><i class="fa fa-eye" ></i></button>
                          
                     </form>
                        <form  class="mr-1" method="post" action="http://localhost/Interventions-Management/update">
                          <input type="hidden" name="P_ID" value="<?php
                           echo $user['P_ID'];?>">
                           <button class="btn btn-sm btn-warning"><i class="fa fa-edit" ></i></button>
                        </form>
                        <form  class="mr-1" method="post" action="delete">
                        
                           <button <?php if(  $Intervention->ispersonnel($_SESSION['username']) == true or $Intervention->isresponsable($_SESSION['username']) == true ) echo 'hidden'?> name class="btn btn-sm btn-danger"><i class="fa fa-trash" ></i></button>

                           <input type="hidden" name="P_ID" value="<?php
                           echo $user['P_ID'];?>
                           ">

                        </form>
                        
            
       
                        </td>
                        
                    </tr>
                    <?php endforeach;?>

    
                  </tbody>
                  <!--jusque la qui doit changer-->
                </table>
