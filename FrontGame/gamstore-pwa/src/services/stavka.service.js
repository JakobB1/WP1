import http from "../http-common";

class StavkaDataService {
  
  async get(){
    return await http.get('/Stavka');
}

async getBySifra(sifra) {
    return await http.get('/stavka/' + sifra);
  }

async delete(sifra){
    const odgovor = await http.delete('/Stavka/' + sifra)
    .then(response => {
        return {ok: true, poruka: 'Obrisao uspješno'};
    })
    .catch(e=>{
        return {ok: false, poruka: e.response.data};
    });

    return odgovor;
}


async post(stavka){
    //console.log(smjer);
    const odgovor = await http.post('/stavka',stavka)
       .then(response => {
         return {ok:true, poruka: 'Unio stavku'}; // return u odgovor
       })
       .catch(error => {
        //console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
}

async put(sifra,stavka){
    //console.log(smjer);
    const odgovor = await http.put('/stavka/' + sifra,stavka)
       .then(response => {
         return {ok:true, poruka: 'Promjenio stavku'}; // return u odgovor
       })
       .catch(error => {
        //console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
     }
}

export default new StavkaDataService();