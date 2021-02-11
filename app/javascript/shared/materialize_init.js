
document.addEventListener('DOMContentLoaded',  () => {
  M.AutoInit();
  
});

open_modal = (id_modal, body) => {
  const custom_modal = document.getElementById("custom-modal");
  custom_modal.innerHTML = body;
  elem = document.getElementById(id_modal);
  instance = M.Modal.init(elem, {});
  instance.open();
}

close_modal = (id_modal) => {
  element = document.getElementById(id_modal);
  modal = M.Modal.getInstance(element);
  modal.close();
}