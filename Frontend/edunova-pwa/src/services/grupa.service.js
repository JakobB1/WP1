import http from "../http-common";

class GrupaDataService {
  getAll() {
    return http.get("/grupa");
  }

  async getBySifra(sifra) {
   // console.log(sifra);
    return await http.get('/grupa/' + sifra);
  }

  async getPolaznici(sifra) {
    // console.log(sifra);
     return await http.get('/grupa/' + sifra + '/polaznici');
   }
 


  async post(grupa){
    //console.log(smjer);
    const odgovor = await http.post('/grupa',grupa)
       .then(response => {
         return {ok:true, poruka: 'Unio grupa'}; // return u odgovor
       })
       .catch(error => {
        console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
}


  async delete(sifra){
    
    const odgovor = await http.delete('/grupa/' + sifra)
       .then(response => {
         return {ok:true, poruka: 'Obrisao uspješno'};
       })
       .catch(error => {
         console.log(error);
         return {ok:false, poruka: error.response.data};
       });
 
       return odgovor;
     }

     async obrisiPolaznika(grupa, polaznik){
    
      const odgovor = await http.delete('/grupa/obrisipolaznika/' + grupa + '/' + polaznik)
         .then(response => {
           return {ok:true, poruka: 'Obrisao uspješno'};
         })
         .catch(error => {
           console.log(error);
           return {ok:false, poruka: error.response.data};
         });
   
         return odgovor;
       }

       async dodajPolaznika(grupa, polaznik){
    
        const odgovor = await http.post('/grupa/dodajpolaznika/' + grupa + '/' + polaznik)
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

export default new GrupaDataService();