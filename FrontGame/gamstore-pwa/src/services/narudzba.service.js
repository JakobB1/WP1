import http from "../http-common";

class NarudzbaDataService {
  getAll() {
    return http.get("/narudzba");
  }

  async getBySifra(sifra) {
   // console.log(sifra);
    return await http.get('/narudzba/' + sifra);
  }

  async getNarudzbe(sifra) {
    // console.log(sifra);
     return await http.get('/narudzba/' + sifra + '/korisnici');
   }
 


  async post(narudzba){
    //console.log(narudzbe);
    const odgovor = await http.post('/narudzba',narudzba)
       .then(response => {
         return {ok:true, poruka: 'Unio narudzbu'}; // return u odgovor
       })
       .catch(error => {
        console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
}


  async delete(sifra){
    
    const odgovor = await http.delete('/narudzba/' + sifra)
       .then(response => {
         return {ok:true, poruka: 'Obrisao uspješno'};
       })
       .catch(error => {
         console.log(error);
         return {ok:false, poruka: error.response.data};
       });
 
       return odgovor;
     }

     async obrisiKorisnika(narudzba, korisnik){
    
      const odgovor = await http.delete('/narudzba/obrisikorisnika/' + narudzba + '/' + korisnik)
         .then(response => {
           return {ok:true, poruka: 'Obrisao uspješno'};
         })
         .catch(error => {
           console.log(error);
           return {ok:false, poruka: error.response.data};
         });
   
         return odgovor;
       }

       async dodajKorisnika(narudzba, korisnik){
    
        const odgovor = await http.post('/narudzba/dodajkorisnika/' + narudzba + '/' + korisnik)
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

export default new NarudzbaDataService();