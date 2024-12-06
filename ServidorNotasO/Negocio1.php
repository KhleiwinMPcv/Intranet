<?php
require_once 'Conexion1.php';
class Negocio1 {  
    public function  LisNotas($coda){
        $obj=new Conexion1();
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
        $obj=new Conexion1();
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
        $obj=new Conexion1();
        $sql="select idcurso, nomcurso from Curso";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
             array_push($response["dato"], array("codc"=>$f[0],"nomc"=>$f[1]));    
         }
        return $response;
         }
         //LISTA CURSOS DE UIN ALUMNO
        public function  LisCursoA($codEstudiante){
        $obj=new Conexion1();
        $sql = "SELECT cp.CodCurso, cp.nombreC 
            FROM CursoProfesor cp
            INNER JOIN Estudiante e ON cp.CodCurso = e.CodCurso
            WHERE e.CodEstudiante = '$codEstudiante'";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
             array_push($response["dato"], array("codc"=>$f[0],"nomc"=>$f[1]));    
         }
        return $response;
         }
         
                  //LISTA CURSOS DE UIN profesor
        public function  LisCursoP($codProfesor){
        $obj=new Conexion1();             
        $sql = "SELECT CodCurso, nombreC from cursoprofesor where CodProfesor = '$codProfesor'";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
             array_push($response["dato"], array("codc"=>$f[0],"nomc"=>$f[1]));    
         }
        return $response;
         }
                           //LISTA profesores X codAdministrador
        public function  LisProfesor($codAdministrador){
        $obj=new Conexion1();             
        $sql = "SELECT CodProfesor,CodEspecialidad,nombreP ,telefonoP,direccionP,gradoP,aniosC from profesor where CodAministrador='$codAdministrador'";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
             array_push($response["dato"], array("codp"=>$f[0],"code"=>$f[1],"nomp"=>$f[2],"tp"=>$f[3],"dp"=>$f[4],"gp"=>$f[5],"acp"=>$f[6]));    
         }
        return $response;
         }
         
                                    //Notas de un curso de un alumno
public function Boleta($codEstudiante, $codCurso){
    $obj = new Conexion1();             
    $sql = "SELECT 
                cp.CodCurso AS codc, 
                cp.nombreC AS nomc, 
                p.nombreP AS nomp, 
                n.p1, 
                n.p2, 
                n.p3, 
                n.ef, 
                n.ec1 AS c1, 
                n.ec2 AS c2, 
                n.ec3 AS c3, 
                n.ec4 AS c4, 
                n.ec5 AS c5, 
                n.ev6 AS c6
            FROM 
                CursoProfesor cp
            JOIN 
                Profesor p ON cp.CodProfesor = p.CodProfesor
            JOIN 
                Notas n ON cp.CodCurso = n.CodCurso
            JOIN 
                Estudiante e ON n.CodEstudiante = e.CodEstudiante
            WHERE 
                e.CodEstudiante = '$codEstudiante' AND 
                cp.CodCurso = '$codCurso'";

    $res = mysqli_query($obj->Conecta(), $sql) or die(mysqli_error($obj->Conecta()));
    $response["dato"] = array();
    $codigosCursos = array(); // Array para almacenar los códigos de curso ya procesados

    while ($f = mysqli_fetch_array($res)){
        // Verificar si el código de curso ya ha sido procesado para evitar duplicados
        if (!in_array($f['codc'], $codigosCursos)) {
            array_push($response["dato"], array(
                "codc" => $f[0],
                "nomc" => $f[1],
                "nomp" => $f[2],
                "p1" => $f[3],
                "p2" => $f[4],
                "p3" => $f[5],
                "ef" => $f[6],
                "c1" => $f[7],
                "c2" => $f[8],
                "c3" => $f[9],
                "c4" => $f[10],
                "c5" => $f[11],
                "c6" => $f[12]
            ));
            // Agregar el código de curso al array de códigos procesados
            $codigosCursos[] = $f['codc'];
        }
    }
    return $response;
}


public function CursosActuales($codEstudiante){
    $obj = new Conexion1();             
    $sql = "SELECT 
                cp.CodCurso AS codc, 
                cp.nombreC AS nomc, 
                p.nombreP AS nomp, 
                n.p1, 
                n.p2, 
                n.p3, 
                n.ef, 
                n.ec1 AS c1, 
                n.ec2 AS c2, 
                n.ec3 AS c3, 
                n.ec4 AS c4, 
                n.ec5 AS c5, 
                n.ev6 AS c6
            FROM 
                CursoProfesor cp
            JOIN 
                Profesor p ON cp.CodProfesor = p.CodProfesor
            JOIN 
                Notas n ON cp.CodCurso = n.CodCurso
            JOIN 
                Estudiante e ON n.CodEstudiante = e.CodEstudiante
            WHERE 
                e.CodEstudiante = '$codEstudiante'";

    $res = mysqli_query($obj->Conecta(), $sql) or die(mysqli_error($obj->Conecta()));
    $response["dato"] = array();
    $codigosCursos = array(); // Array para almacenar los códigos de curso ya procesados

    while ($f = mysqli_fetch_array($res)){
        // Verificar si el código de curso ya ha sido procesado para evitar duplicados
        if (!in_array($f['codc'], $codigosCursos)) {
            array_push($response["dato"], array(
                "codc" => $f[0],
                "nomc" => $f[1],
                "nomp" => $f[2],
                "p1" => $f[3],
                "p2" => $f[4],
                "p3" => $f[5],
                "ef" => $f[6],
                "c1" => $f[7],
                "c2" => $f[8],
                "c3" => $f[9],
                "c4" => $f[10],
                "c5" => $f[11],
                "c6" => $f[12]
            ));
            // Agregar el código de curso al array de códigos procesados
            $codigosCursos[] = $f['codc'];
        }
    }
    return $response;
}


         
        
         
        //ALUMNOS DE UN CURSO
         
        public function  NotaAlu($codc){
        $obj=new Conexion1();
        $sql="SELECT a.idalumno, a.apealumno, a.nomalumno, n.exaparcial, n.exafinal FROM alumno a JOIN notas n ON a.idalumno = n.idalumno WHERE n.idcurso = '$codc'";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
           
             array_push($response["dato"], array("coda"=>$f[0],"ape"=>$f[1],"nom"=>$f[2],
                 "ep"=>$f[3],"ef"=>$f[4]));    
         }
        return $response;
         }
        public function  pagoAlu($codEstudiante){
        $obj=new Conexion1();
        $sql="select numerocuota, monto,descuento,fechaV from pago where CodEstudiante='$codEstudiante' ";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
           
             array_push($response["dato"], array("cuota"=>$f[0],"monto"=>$f[1],"descuento"=>$f[2],
                 "fecha"=>$f[3]));    
         }
        return $response;
         }
         
         
         
         public function  login($user,$pass){
        $obj=new Conexion1();
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
    //editar notas
public function editarNotas($codEstudiante, $codCurso, $p1, $p2, $p3, $ef, $c1, $c2, $c3, $c4, $c5, $c6) {
    $obj = new Conexion1();
    
    // Prevenir SQL Injection usando parámetros preparados
    $sql = "UPDATE notas SET p1=?, p2=?, p3=?, ef=?, ec1=?, ec2=?, ec3=?, ec4=?, ec5=?, ev6=? WHERE CodEstudiante=? AND CodCurso=?";
    
    $stmt = mysqli_prepare($obj->getconex(), $sql);
    if ($stmt === false) {
        echo "Error preparando la consulta: " . mysqli_error($obj->getconex());
        return;
    }

    mysqli_stmt_bind_param($stmt, "ddddddddddss", $p1, $p2, $p3, $ef, $c1, $c2, $c3, $c4, $c5, $c6, $codEstudiante, $codCurso);
    
    if (!mysqli_stmt_execute($stmt)) {
        echo "Error ejecutando la consulta: " . mysqli_stmt_error($stmt);
    } else {
        echo "Notas actualizadas correctamente.";
    }

    mysqli_stmt_close($stmt);
}



// Función en PHP para listar estudiantes de un curso
public function LisAluCurso($codCurso) {
    $obj = new Conexion1();             
    $sql = "SELECT CodEstudiante, nombreE FROM estudiante WHERE CodCurso = '$codCurso'";
    $res = mysqli_query($obj->Conecta(), $sql) or die(mysqli_error($obj->Conecta()));
    
    // Inicialización del arreglo de respuesta
    $response["dato"] = array();
    
    // Iterar sobre los resultados y agregar al arreglo de respuesta
    while ($f = mysqli_fetch_array($res)) {
        array_push($response["dato"], array("codE" => $f[0], "nomE" => $f[1]));    
    }
    
    return $response;
}
 
public function LisCiclos() {
    $obj = new Conexion1();             
    $sql = "SELECT DISTINCT ciclo FROM Detaplan";
    $res = mysqli_query($obj->Conecta(), $sql) or die(mysqli_error($obj->Conecta()));
    
    // Inicialización del arreglo de respuesta
    $response["dato"] = array();
    
    // Iterar sobre los resultados y agregar al arreglo de respuesta
    while ($f = mysqli_fetch_array($res)) {
        array_push($response["dato"], array("ciclo" => $f[0]));    
    }
    
    return $response;
}
        public function  DetaPlan($codCiclo){
        $obj=new Conexion1();
        $sql="SELECT codigo, asignatura, tipocurso, ht, hp, prerrequisitos FROM Detaplan WHERE ciclo = $codCiclo";
         $res=  mysqli_query($obj->Conecta(),$sql) or die(mysqli_error($obj->Conecta()));
         $response["dato"]=array();
         while($f=  mysqli_fetch_array($res)){
           
             array_push($response["dato"], array("codc"=>$f[0],"nomc"=>$f[1],"tipo"=>$f[2],
                 "ht"=>$f[3],"hp"=>$f[4],"req"=>$f[5]));    
         }
        return $response;
         }
    


}


?>
