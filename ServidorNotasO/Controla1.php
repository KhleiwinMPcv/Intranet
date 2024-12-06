<?php
require_once './Negocio1.php';
$opc=$_REQUEST['tag'];
if ($opc=="consulta1") {
    $coda=$_REQUEST["coda"];
$obj=new Negocio1();
echo json_encode($obj->LisNotas($coda));
}
if ($opc=="consulta2") {
    $coda=$_REQUEST["coda"];
$obj=new Negocio1();
echo json_encode($obj->LisPagos($coda));
}
if ($opc=="consulta5") {
    $codc=$_REQUEST["codc"];
$obj=new Negocio1();
echo json_encode($obj->NotaAlu($codc));
}
if ($opc=="consulta6") {
    $codEstudiante=$_REQUEST["codEstudiante"];
$obj=new Negocio1();
echo json_encode($obj->LisCursoA($codEstudiante));
}

if ($opc=="consulta7") {
    $codProfesor=$_REQUEST["codProfesor"];
$obj=new Negocio1();
echo json_encode($obj->LisCursoP($codProfesor));
}

if ($opc=="consulta8") {
    $codAdministrador=$_REQUEST["codAdministrador"];
$obj=new Negocio1();
echo json_encode($obj->LisProfesor($codAdministrador));
}

if ($opc == "consulta9") {
    $codEstudiante = $_REQUEST["codEstudiante"];
    $codCurso = $_REQUEST["codCurso"];
    $obj=new Negocio1();
    echo json_encode($obj->Boleta($codEstudiante,$codCurso));
}

if ($opc == "consulta10") {
    $codEstudiante = $_REQUEST["codEstudiante"];
    $obj=new Negocio1();
    echo json_encode($obj->CursosActuales($codEstudiante));
}
//editar notas
//editar notas
if ($opc == "consulta11") {
    // Asegúrate de utilizar $_POST para obtener los datos
    $codEstudiante = $_POST["codEstudiante"];
    $codCurso = $_POST["codCurso"];
    $p1 = $_POST["p1"];
    $p2 = $_POST["p2"];
    $p3 = $_POST["p3"];
    $ef = $_POST["ef"];
    $c1 = $_POST["c1"];
    $c2 = $_POST["c2"];
    $c3 = $_POST["c3"];
    $c4 = $_POST["c4"];
    $c5 = $_POST["c5"];
    $c6 = $_POST["c6"];

    // Debugging: print received data
    echo "Datos recibidos: codEstudiante=$codEstudiante, codCurso=$codCurso, p1=$p1, p2=$p2, p3=$p3, ef=$ef, c1=$c1, c2=$c2, c3=$c3, c4=$c4, c5=$c5, c6=$c6";

    $obj = new Negocio1();
    $obj->editarNotas($codEstudiante, $codCurso, $p1, $p2, $p3, $ef, $c1, $c2, $c3, $c4, $c5, $c6);

    echo json_encode(["success" => true]);
    exit;
}


// alumnos en un curso
if ($opc == "consulta12") {
    $codCurso = $_REQUEST["codCurso"];
    $obj = new Negocio1();
    echo json_encode($obj->LisAluCurso($codCurso));
}
if ($opc == "consulta13") {
    $codEstudiante = $_REQUEST["codEstudiante"];
    $obj = new Negocio1();
    echo json_encode($obj->pagoAlu($codEstudiante));
}
if ($opc=="consulta14") {
$obj=new Negocio1();
echo json_encode($obj->LisCiclos());
}

if ($opc == "consulta15") {
    $codCiclo = $_REQUEST["codCiclo"];
    $obj = new Negocio1();
    echo json_encode($obj->DetaPlan($codCiclo));
}



if ($opc=="consulta3") {
$obj=new Negocio1();
echo json_encode($obj->LisCurso());
}
if ($opc=="consulta4") {
    $use=$_REQUEST["user"];
    $pas=$_REQUEST["pass"];
$obj=new Negocio1();
echo json_encode($obj->login($use,$pas));
}
?>
