
document.addEventListener('DOMContentLoaded',  () => {
  M.AutoInit();
});

open_modal = (id_modal) => {
   elem = document.getElementById(id_modal);
   var instance = M.Modal.getInstance(elem);
   instance.open();
   return false;
}