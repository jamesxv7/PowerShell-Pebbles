$smtpClient = new-object System.Net.Mail.SmtpClient “smtp.servername.com”, 25

$smtpClient.TimeOut = 90000
$smtpClient.useDefaultCredentials = $true
$smtpClient.Send(“from@email.com”, “to@email.com”, “This is the subject of the email”, “This is the body of the email”)
