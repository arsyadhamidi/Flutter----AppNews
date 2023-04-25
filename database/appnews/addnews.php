<?php

    include_once 'connection.php';

    $title = $_POST['title'];
    $content = $_POST['content'];
    $description = $_POST['description'];
    $id_users = $_POST['id_users'];    
    
    $image = date("dmYMis").str_replace(" ", " ", basename($_FILES['image']['name']));
    $imagePath = "upload/".$image;
    move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

    $query = "INSERT INTO tb_news(image, title, content, description, date_news, id_users) VALUES ('$image','$title','$content','$description',NOW(),'$id_users')";

    $arr = [];
    $result = mysqli_query($db, $query);
    if($result > 0){
        $arr['status'] = 200;
        $arr['error'] = false;
        $arr['message'] = "Add News Succesfully";
    }else{
        $arr['status'] = 400;
        $arr['error'] = true;
        $arr['message'] = "Add News Failed!";
    }

    print(json_encode($arr));

?>