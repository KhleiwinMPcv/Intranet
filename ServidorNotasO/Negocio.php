<?php
require_once 'Conexion.php';
class Negocio {  
    public function  LisNotas($coda){
        $obj=new Conexion();
        $sql="select c.idcurso, nomcurso, exaparcial, exafinal from Curso c ,"
                . "notas n where c.idcurso=n.idcurso and idalumno='$coda' ";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
           
             array_push($response["dato"], array("codc"=>$f[0],"nomc"=>$f[1],
                 "ep"=>$f[2],"ef"=>$f[3]));    
         }
        return $response;
         }
         
         public function  LisPagos($coda){
        $obj=new Conexion();
        $sql="select ciclo, fecha, monto from pagos "
                . "where idalumno='$coda' ";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array(); 
         while($f=  mysqli_fetch_array($res)){
           
             array_push($response["dato"], array("cic"=>$f[0],"fec"=>$f[1],
                 "mon"=>$f[2]));    
         }
        return $response;
         }
         
         public function  LisCurso(){
        $obj=new Conexion();
        $sql="select idcurso, nomcurso from Curso";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
             array_push($response["dato"], array("codc"=>$f[0],"nomc"=>$f[1]));    
         }
        return $response;
         }
        //ALUMNOS DE UN CURSO
         
        public function  NotaAlu($codc){
        $obj=new Conexion();
        $sql="SELECT a.idalumno, a.apealumno, a.nomalumno, n.exaparcial, n.exafinal FROM alumno a JOIN notas n ON a.idalumno = n.idalumno WHERE n.idcurso = '$codc'";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
           
             array_push($response["dato"], array("coda"=>$f[0],"ape"=>$f[1],"nom"=>$f[2],
                 "ep"=>$f[3],"ef"=>$f[4]));    
         }
        return $response;
         }
         
         
         
         public function  login($user,$pass){
        $obj=new Conexion();
        $sql="select nombre from usuarios "
                . "where user='$user' and pass='$pass' ";
         $res=  mysql_query($sql,$obj->Conecta()) or die(mysqli_error());
         
         if (mysql_num_rows($res>0)) {
             $f=mysql_fetch_array($res);
             $response["dato"]=$f[0];
         }else{
             $response["dato"]="error";
         }
         return $response;
    }
}


?>