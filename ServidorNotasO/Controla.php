<?php
require_once './Negocio.php';
$opc=$_REQUEST['tag'];
if ($opc=="consulta1") {
    $coda=$_REQUEST["coda"];
$obj=new Negocio();
echo json_encode($obj->LisNotas($coda));
}
if ($opc=="consulta2") {
    $coda=$_REQUEST["coda"];
$obj=new Negocio();
echo json_encode($obj->LisPagos($coda));
}
if ($opc=="consulta5") {
    $codc=$_REQUEST["codc"];
$obj=new Negocio();
echo json_encode($obj->NotaAlu($codc));
}


if ($opc=="consulta3") {
$obj=new Negocio();
echo json_encode($obj->LisCurso());
}
if ($opc=="consulta4") {
    $use=$_REQUEST["user"];
    $pas=$_REQUEST["pass"];
$obj=new Negocio();
echo json_encode($obj->login($use,$pas));
}
?>