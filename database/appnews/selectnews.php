<?php

    include_once 'connection.php';

    $query = "SELECT * FROM tb_news INNER JOIN tb_users ON tb_news.id_users = tb_users.id_users";

    $result = mysqli_query($db, $query);

    $array = [];
    while($data = mysqli_fetch_array($result)){
        $array[] = $data;
    }

    print(json_encode($array));

?>