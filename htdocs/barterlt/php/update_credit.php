<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['user_id']; // Change 'user_id' to 'userid'
$credits = $_POST['credits'];
$status = $_POST['status'];

if ($status == 'buy') {
    $sqlupdate = "UPDATE `tbl_users` SET `user_credit` = `user_credit` + $credits WHERE `user_id` = '$userid'";
    if ($conn->query($sqlupdate) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqlupdate);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => $sqlupdate);
        sendJsonResponse($response);
    }
} else if ($status == 'pay') {
    $sqlupdate = "UPDATE `tbl_users` SET `user_credit` = $credits WHERE `user_id` = '$userid'";
    if ($conn->query($sqlupdate) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqlupdate);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => $sqlupdate);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
