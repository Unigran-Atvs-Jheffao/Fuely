String formatDate(DateTime time){
  var local = time.toLocal();
  var month = local.month < 10 ? ("0${local.month}"): local.month;
  var hour = local.hour < 10 ? ("0${local.hour}"): local.hour;
  var minute = local.minute < 10 ? ("0${local.minute}"): local.minute;
  return "${local.day}/$month/${local.year}  $hour:$minute";
}