<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$name = $_GET['name'];
		$type = $_GET['type'];
		$address = $_GET['address'];
		$phone = $_GET['phone'];
		$user = $_GET['user'];
		$password = $_GET['password'];
		$avtar = $_GET['avtar'];
		$lat = $_GET['latt'];
		$lng = $_GET['lng'];	

		
							
		$sql = "IINSERT INTO `user`(`id`, `name`, `type`, `address`, `phone`, `user`, `password`, `avatar`, `lat`, `lng`) VALUES (Null,'$name','$type','$address','$phone','$user','$password','$avatar','$lng','$lng')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>