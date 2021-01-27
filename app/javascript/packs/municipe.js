const show_municipe = async (municipe_id) => {
  const url = `/municipes/${municipe_id}.json`
  const response = await fetch(url);
  const data = await response.json();

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
  document.getElementById('foto').setAttribute('src', data.foto)

  open_modal('show');
  return false
}

const number_mask = function(value) {
  var regex = /\d*/g; //2 dígitos e 1 word char, dois grupos
  var resultado = regex.exec(value);
  return resultado[0];
}

const search_address = async function(cep){
  const url = `https://viacep.com.br/ws/${cep}/json/`
  const response = await fetch(url);
  const data = await response.json();

  if(data.erro != true){
    document.getElementById('municipe_endereco_attributes_logradouro').value = data.logradouro;
    document.getElementById('municipe_endereco_attributes_bairro').value = data.bairro;
    document.getElementById('municipe_endereco_attributes_municipio').value = data.localidade;
    document.getElementById('municipe_endereco_attributes_uf').value = data.uf;
    document.getElementById('municipe_endereco_attributes_codigo_ibge').value = data.ibge;
  }
}

document.addEventListener('DOMContentLoaded',  () => {
  document.querySelector('.cep').addEventListener('keyup', function(e){
    e.target.value = number_mask(e.target.value)
    if(this.value.length == 8){
      search_address(this.value)
    }
  })


  document.querySelector('#add').addEventListener('keyup', function(e){
    if(e.target.className == 'number'){
      e.target.value = number_mask(e.target.value)
    }
  })
  document.querySelector('#municipe-list').addEventListener('click', function(e) {
    if(e.target.className == 'show_municipe'){
      show_municipe(e.target.dataset.id);
    }
  });
});


