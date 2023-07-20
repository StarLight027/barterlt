<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$orderid = $_POST['order_id']; 
$newStatus = $_POST['new_status'];

$sqlselectOrder = "SELECT * FROM `tbl_order` WHERE `order_id` = '$orderid'";
$resultOrder = $conn->query($sqlselectOrder);

if ($resultOrder && $resultOrder->num_rows > 0) {
    if ($newStatus == 'confirmed') {
        $sqlUpdateStatus = "UPDATE `tbl_order` SET `order_status` = 'Success' WHERE `order_id` = '$orderid'";
        $conn->query($sqlUpdateStatus);


        $response = array('status' => 'success', 'data' => $sqlselectOrder);
        sendJsonResponse($response);
    } else {
        $sqlUpdateStatus = "UPDATE `tbl_order` SET `order_status` = 'Rejected' WHERE `order_id` = '$orderid'";
        $conn->query($sqlUpdateStatus);

        $response = array('status' => 'success', 'data' => $sqlselectOrder);
        sendJsonResponse($response);
    }
} else {
    $response = array('status' => 'failed', 'data' => $orderid);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>