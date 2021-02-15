import axios from "axios-on-rails";

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

const cpf_mask = function(value){
  let new_value = value
  .replace(/\D/g, '')
  .replace(/(\d{3})(\d)/, '$1.$2') 
  .replace(/(\d{3})(\d)/, '$1.$2')
  .replace(/(\d{3})(\d{1,2})/, '$1-$2')
  .replace(/(-\d{2})\d+?$/, '$1')

  return new_value;
}

const cep_mask = function(value){
  let new_value = value
  .replace(/\D/g,'')
  .replace(/(\d{5})(\d{3})/, '$1-$2')

  return new_value;
}

const telefone_mask = function(value){
  let new_value = value
  .replace(/\D/g, '')
  .replace(/(\d{2})(\d)/, '($1)$2')
  .replace(/(\d{5})(\d{4})/, '$1-$2')
  .replace(/(\d{4})(\d{4})/, '$1-$2')
  
  return new_value
}


const municipe_list = (query = null) => {
  let url = "/municipes_list"
  if(query !== null){
    url = `${url}?query=${query}`
  }
  axios(url).then(response => {
    document.getElementById('municipe-list').innerHTML = response.data
  }).catch(error => {
    console.log(error)
    M.toast({html: "Ocorreu um erro na requisição." + error.message})
  })
}


document.addEventListener('DOMContentLoaded',  () => {
  document.getElementById('query').addEventListener('keyup', function (e) {
    municipe_list(e.target.value);

  })
  document.getElementById('create-municipe-button').addEventListener('click', function(){
    const url = `/municipes/new`

    fetch(url)
      .then(resp => {
        if (!resp.ok) throw Error(resp.statusText);
        return resp.text()
      })
      .then(body => {
        open_modal('add', body)
      }).catch(err => {
        M.toast({html: "Ocorreu um erro na requisição." + err})
        return false
      })
  })

  document.querySelector('#municipe-list').addEventListener('click', function(e) {
    if(e.target.classList.contains('edit-municipe-button')){

      const url = `/municipes/${e.target.dataset.id}/edit`
  
      fetch(url)
        .then(resp => {
          if (!resp.ok) throw Error(resp.statusText);
          return resp.text()
        })
        .then(body => {
          open_modal('add', body)
        }).catch(err => {
          M.toast({html: "Ocorreu um erro na requisição." + err})
          return false
        })
    }

    if(e.target.classList.contains('change-status-municipe-button')){

      const url = `/municipes/${e.target.dataset.id}/change_status`;
      const csrfToken = document.querySelector("meta[name='csrf-token']").content;
      fetch(url, {method: "put",
          headers:{
            "X-CSRF-Token": csrfToken,
            "Content-Type": "application/json"
          }})
          .then(resp => {
            if (!resp.ok) throw Error(resp.statusText);
            get_municipe_list()
            return resp.json()
          })
          .then(data => {
            M.toast({html: data.message, classes: "teal lighten-3"})
          }).catch(err => {
            M.toast({html: "Ocorreu um erro na requisição." + err})
            return false
          })
      }


    if(e.target.classList.contains('show-municipe')){
      const url = `/municipes/${e.target.dataset.id}`

      fetch(url)
      .then(resp => {
        if (!resp.ok) throw Error(resp.statusText);
        return resp.text()
      })
      .then(body => {
        open_modal('show', body)
      }).catch(err => {
        M.toast({html: "Ocorreu um erro na requisição." + err})
        return false
      })
    }
  });
  
  document.getElementById('custom-modal').addEventListener('click', function(e){
    if(e.target.id == 'submit-municipe'){
      e.preventDefault();
      const form = document.getElementById('create-municipe')

      axios({
        method: form.method,
        url: form.action + ".json",
        data: new FormData(form)
      }).then(response => {
        M.toast({html: response.data.message, classes: "teal lighten-3"});
        close_modal('add')
        municipe_list()
      }).catch(error => {
        M.toast({html: error.response.data.message, classes: "red darken-3"});
      });
    }
  });
  
  
  document.getElementById('custom-modal').addEventListener('keyup', function(e){
    if(e.target.classList.contains('cpf')){
      e.target.value = cpf_mask(e.target.value)
    }

    if(e.target.classList.contains('number')){
      e.target.value = number_mask(e.target.value)
    }

    if(e.target.classList.contains('telefone')){
      e.target.value = telefone_mask(e.target.value)
    }

    if(e.target.classList.contains('cep')){
      e.target.value = cep_mask(e.target.value)
      if(e.target.value.length == 9){
        search_address(e.target.value.replace(/\D/g, ""))
      }
    }
  })


});