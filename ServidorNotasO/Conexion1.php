<?php
class Conexion1 {
    private $cn=null;

    function Conecta() {
        if($this->cn == null) {
            $this->cn = @mysqli_connect("localhost", "root", "", "bdfinalpc3");
        }
        return $this->cn;
    }

    function getconex() {
        return $this->Conecta();
    }

    function Cierra() {
        $this->cn = null;
    }
}
?>
