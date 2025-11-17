<?php
header('Content-Type: text/html; charset=utf-8');

function envVal($keys, $default = '-')
{
    foreach ((array)$keys as $k) {
        $v = getenv($k);
        if ($v !== false) return $v;
        if (isset($_ENV[$k])) return $_ENV[$k];
        if (isset($_SERVER[$k])) return $_SERVER[$k];
    }
    return $default;
}

$vars = [
    'envVarName' => envVal(['ENV_VAR_NAME', 'envVarName']),
    'state' => envVal(['STATE', 'state']),
    'color' => envVal(['COLOR', 'color'])
];    
?>
<!doctype html>
<html lang="th">
<head>
  <meta charset="utf-8">
  <title>Env</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; padding:24px;">
  <p style="font-size:20px; margin:0 0 18px 0;">Hello version = 1</p>

  <div style="line-height:1.8;">
    <?php foreach ($vars as $k => $v): ?>
      <div><?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8'); ?> = <?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8'); ?></div>
    <?php endforeach; ?>
  </div>
</body>
</html>
<?php
