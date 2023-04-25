<?php

    include_once 'connection.php';

    $arr = [];
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = md5($_POST['password']);

    $check = "SELECT * FROM tb_users WHERE email ='$email'";
    $data = mysqli_fetch_array(mysqli_query($db, $check));
    
    if (isset($data)) {
        $arr['status'] = 400;
        $arr['message'] = "Email already in use!";
        $arr['data'] = $data;
        print(json_encode($arr));
    }else{
        $query = "INSERT INTO tb_users(username, email, password, level, registrasi_date) VALUES ('$username','$email','$password','1',NOW())";

        $result = mysqli_query($db, $query);

        if($result > 0){
            $arr['status'] = 200;
            $arr['error'] = false;
            $arr['message'] = "Data Create Succesfully";
            print(json_encode($arr));
        }else{
            $arr['status'] = 400;
            $arr['error'] = true;
            $arr['message'] = "Data Create Failed!";
            print(json_encode($arr));
        }
    }

?>