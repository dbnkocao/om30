const show_municipe = async (municipe_id) => {
  const url = `/municipes/${municipe_id}.json`
  const response = await fetch(url);
  const data = await response.json();

  // document.getElementById('foto').innerHTML = data.foto;
  document.getElementById('nome').innerHTML = data.nome;
  document.getElementById('email').innerHTML = data.email;
  document.getElementById('cpf').innerHTML = data.cpf;
  document.getElementById('dt_nasc').innerHTML = data.dt_nasc;
  document.getElementById('telefone').innerHTML = data.telefone;
  document.getElementById('status').innerHTML = data.status;

  document.getElementById('cep').innerHTML = data.endereco.cep;
  document.getElementById('logradouro').innerHTML = data.endereco.logradouro;
  document.getElementById('numero').innerHTML = data.endereco.numero;
  document.getElementById('complemento').innerHTML = data.endereco.complemento;
  document.getElementById('bairro').innerHTML = data.endereco.bairro;
  document.getElementById('municipio').innerHTML = data.endereco.municipio;
  document.getElementById('uf').innerHTML = data.endereco.uf;
  document.getElementById('codigo_ibge').innerHTML = data.endereco.codigo_ibge;

  open_modal('show');
  return false
}

document.addEventListener('DOMContentLoaded',  () => {
  document.querySelector('#municipe-list').addEventListener('click', function(e) {
    if(e.target.className == 'show_municipe'){
      show_municipe(e.target.dataset.id);
    }
  });
});


