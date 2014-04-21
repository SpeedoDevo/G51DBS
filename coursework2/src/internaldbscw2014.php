<h1>Name: Barnabas Forgo</h1>
<h1>Username: bxf03u</h1>


<?php
	if ( isset( $_GET['newloc'] ) )
	{
		$query = "UPDATE PlayerData SET dataValue = "  . $_GET['newloc'] . " WHERE dataID = 'Position'";
		mysql_query($query);
	}

	if ( isset( $_GET['takeitem'] ) )
	{
		$query = "UPDATE Item SET itemLocID = NULL WHERE itemID = " . $_GET['takeitem'] ;
		mysql_query($query);
	}

	if ( isset( $_GET['dropitem'] ) )
	{
		$query = "UPDATE Item SET itemLocID = (SELECT dataValue FROM PlayerData WHERE dataID = 'Position') WHERE itemID = " . $_GET['dropitem'] ;
		mysql_query($query);
	}



echo "<H2>Current Location Information:</H2>";

$query = "SELECT locID, description as desc1 FROM Description as D INNER JOIN Location as L ON L.locDescID = D.descID INNER JOIN PlayerData as PD ON PD.dataValue = L.locID WHERE PD.dataID = 'Position'";
$result = mysql_query($query);

echo "<table>";
echo "<tr class=\"tablehead\">";
echo "<td>Location ID</td>";
echo "<td>Location Description</td>";
echo "</tr>";
while ($row = mysql_fetch_array($result))
{
	echo "<tr>";
	echo "<td>" . $row['locID'] . "</td>";
	echo "<td>" . $row['desc1'] . "</td>";
	echo "</tr>";
}
echo "</table>";




echo "<H2>Current Location Exits:</H2>";

$query = "SELECT D1.description as desc1, D2.description as desc2, D3.description as desc3, D4.description as desc4, L2.locID as newLocID FROM Description as D1 INNER JOIN Location as L1 ON D1.descID = L1.locDescID INNER JOIN LocationExit as LE ON L1.locID = LE.locIDCurrent INNER JOIN Description as D2 ON LE.exitDirectionDescID = D2.descID INNER JOIN Description as D3 ON LE.exitDescID = D3.descID INNER JOIN  Location as L2 ON LE.locIDNew = L2.locID INNER JOIN Description as D4 ON L2.locDescID = D4.descID INNER JOIN PlayerData as PD ON PD.dataValue = L1.locID WHERE PD.dataID = 'Position' ORDER BY D2.descID";
$result = mysql_query($query);

echo "<table>";
echo "<tr class=\"tablehead\">";
echo "<td>Exit Direction</td>";
echo "<td>Move</td>";
echo "</tr>";
while ($row = mysql_fetch_array($result))
{
	$exitdescname = $row['desc3']; // CHANGE THIS
	$exitdirectionname = $row['desc2']; // CHANGE THIS
	$newlocationid = $row['newLocID']; // CHANGE THIS

	echo "<tr>";
	echo "<td>" . $exitdescname . " " . $exitdirectionname . "(" . $newlocationid .")</td>";

	echo '<td valign="middle">';
	echo '<form style="display:inline;" action=' . $_SERVER['PHP_SELF'] . ' method="get">';
	echo '<input type="hidden" name="newloc" value="' . $newlocationid . '" />';
	echo '<button name="move" type="submit">Move ' . $exitdirectionname . '</button>';
	echo '</form>';
	echo '</td>';

	echo "</tr>";
}
echo "</table>";






echo "<H2>Current People Here:</H2>";

$query = "SELECT description, mobID FROM MobileObject INNER JOIN Description ON mobDescID = descID INNER JOIN PlayerData ON mobLocID = dataValue WHERE dataID = 'Position'";
$result = mysql_query($query);

echo "<table>";
while ($row = mysql_fetch_array($result))
{
	echo "<tr>";
	echo "<td>" . $row['description'] . " (" . $row['mobID'] . ")</td>";
	echo "</tr>";
}
echo "</table>";


echo "<H2>Current Location Items:</H2>";

$query = "SELECT ID.description as itemdesc, I.itemID as itemID FROM Item as I INNER JOIN Description as ID ON ID.descID = I.itemDescID INNER JOIN PlayerData as PD ON PD.dataValue = I.itemLocID WHERE PD.dataID = 'Position' ORDER BY itemID";
$result = mysql_query($query);

echo "<table>";
echo "<tr class=\"tablehead\">";
echo "<td>Item</td>";
echo "<td>Action</td>";
echo "</tr>";
while ($row = mysql_fetch_array($result))
{
	$itemdesc = $row['itemdesc']; // CHANGE THIS
	$itemID = $row['itemID']; // CHANGE THIS

	echo "<tr>";
	echo "<td>" . $itemdesc . "</td>";

	echo '<td valign="middle">';
	echo '<form style="display:inline;" action=' . $_SERVER['PHP_SELF'] . ' method="get">';
	echo '<input type="hidden" name="takeitem" value="' . $itemID . '" />';
	echo '<button name="take" type="submit">Pick Up ' . $itemdesc . '</button>';
	echo '</form>';
	echo '</td>';

echo "</tr>";
}
echo "</table>";






echo "<H2>Carried Item List:</H2>";

$query = "SELECT ID.description as itemdesc, itemID FROM Item as I INNER JOIN Description as ID ON ID.descID = I.itemDescID WHERE I.itemLocID IS NULL ORDER BY itemID";
$result = mysql_query($query);

echo "<table>";
echo "<tr class=\"tablehead\">";
echo "<td>Item</td>";
echo "<td>ID</td>";
echo "<td>Action</td>";
echo "</tr>";
while ($row = mysql_fetch_array($result))
{
	$itemdesc = $row['itemdesc']; // CHANGE THIS
	$itemID = $row['itemID']; // CHANGE THIS

	echo "<tr>";
	echo "<td>" . $itemdesc . "</td>";
	echo "<td>" . $itemID . "</td>";

	echo '<td valign="middle">';
	echo '<form style="display:inline;" action=' . $_SERVER['PHP_SELF'] . ' method="get">';
	echo '<input type="hidden" name="dropitem" value="' . $itemID . '" />';
	echo '<button name="drop" type="submit">Drop ' . $itemdesc . '</button>';
	echo '</form>';
	echo '</td>';

	echo "</tr>";}

echo "</table>";

?>