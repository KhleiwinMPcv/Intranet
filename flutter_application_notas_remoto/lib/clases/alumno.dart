class Alumno{
  String coda="";
  String noma="";
  String ape="";
  int exf=0;
  int exp=0;

  double promedio(){
    return (exp+exf*2)/3;
  }

  String obser(){
    return promedio()>=11.5?"Aprobado":"Desaprobado";
  }
  
}