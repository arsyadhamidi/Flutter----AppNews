<?php

    include_once 'connection.php';

    $title = $_POST['title'];
    $content = $_POST['content'];
    $description = $_POST['description'];
    $id_news = $_POST['id_news'];    
    
    $image = date("dmYMis").str_replace(" ", " ", basename($_FILES['image']['name']));
    $imagePath = "upload/".$image;
    move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

    $query = "UPDATE tb_news SET image='$image', title='$title', content='$content', description='$description' WHERE id_news = '$id_news'";

    $arr = [];
    $result = mysqli_query($db, $query);
    if($result > 0){
        $arr['status'] = 200;
        $arr['error'] = false;
        $arr['message'] = "Edit News Succesfully";
    }else{
        $arr['status'] = 400;
        $arr['error'] = true;
        $arr['message'] = "Edit News Failed!";
    }

    print(json_encode($arr));

?>