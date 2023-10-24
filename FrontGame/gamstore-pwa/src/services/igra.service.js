import http from "../http-common";

class IgraDataService {
  getAll() {
    return http.get("/igra");
  }

  async getBySifra(sifra) {
   // console.log(sifra);
    return await http.get('/igra/' + sifra);
  }

  async getIgre(sifra) {
    // console.log(sifra);
     return await http.get('/igra/' + sifra + '/izdavaci');
   }
 


  async post(igra){
    //console.log(igre);
    const odgovor = await http.post('/igra',igra)
       .then(response => {
          console.log(response);
         return {ok:true, poruka: 'Unio igru'}; // return u odgovor
       })
       .catch(error => {
        console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
}


  async delete(sifra){
    
    const odgovor = await http.delete('/igra/' + sifra)
       .then(response => {
         return {ok:true, poruka: 'Obrisao uspješno'};
       })
       .catch(error => {
         console.log(error);
         return {ok:false, poruka: error.response.data};
       });
 
       return odgovor;
     }

     async obrisiIzdavaca(igra, izdavac){
    
      const odgovor = await http.delete('/igra/obrisiizdavaca/' + igra + '/' + izdavac)
         .then(response => {
           return {ok:true, poruka: 'Obrisao uspješno'};
         })
         .catch(error => {
           console.log(error);
           return {ok:false, poruka: error.response.data};
         });
   
         return odgovor;
       }

       async dodajIzdavaca(igra, izdavac){
    
        const odgovor = await http.post('/igra/dodajizdavaca/' + igra + '/' + izdavac)
           .then(response => {
             return {ok:true, poruka: 'Dodao uspješno'};
           })
           .catch(error => {
             console.log(error);
             return {ok:false, poruka: error.response.data};
           });
     
           return odgovor;
         }

}

export default new IgraDataService();