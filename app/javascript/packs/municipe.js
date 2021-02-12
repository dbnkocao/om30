const number_mask = function(value) {
  var regex = /\d*/g;
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
      let toast_classes = "red darken-3"
      fetch(form.action,{method:'post', body: new FormData(form)})
      .then(resp => {
        if(resp.status === 201){
          toast_classes = "teal lighten-3"
          get_municipe_list();
          close_modal('add');
        }
        return  resp.json()
      })
      .then(data => {
        M.toast({html: data.message, classes: toast_classes});
      })    
      .catch( err => {
        M.toast({html: "Ocorreu um erro na requisição.", classes: "red darken-3"})
      })
    }
  });

  
  document.getElementById('custom-modal').addEventListener('keyup', function(e){
    if(e.target.classList.contains('number')){
      e.target.value = number_mask(e.target.value)
    }

    if(e.target.classList.contains('cep')){
      e.target.value = number_mask(e.target.value)
      if(e.target.value.length == 8){
        search_address(e.target.value)
      }
    }
  })

  function get_municipe_list(){
    const url = "/municipes_list"
    fetch(url)
    .then(resp => {
      console.log(resp)
      if (!resp.ok) throw Error(resp.statusText);
      return resp.text()
    })
    .then(body => {
      document.getElementById('municipe-list').innerHTML = body
      
    }).catch(err => {
      M.toast({html: "Ocorreu um erro na requisição." + err})
      return false
    })
  }

});