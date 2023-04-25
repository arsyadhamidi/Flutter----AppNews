<?php

    include_once 'connection.php';

    if(isset($_POST["id_news"])){
        $id_news = $_POST["id_news"];
    }else return;

    $query = "DELETE FROM tb_news WHERE id_news ='$id_news'";

    $execute = mysqli_query($db, $query);

    $arr = [];

    if($execute > 0){
        $arr['status'] = 200;
        $arr['message'] = "Data Delete Successfully";
    }else{
        $arr['status'] = 200;
        $arr['message'] = "Data Delete Successfully";
    }

    print(json_encode($arr));

?>