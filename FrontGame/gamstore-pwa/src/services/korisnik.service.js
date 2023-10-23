import http from '../http-common';

class KorisnikDataService {
  async getAll() {
    return await http.get('/korisnik');
  }



  async getBySifra(sifra) {
    return await http.get('/korisnik/' + sifra);
  }

  async traziKorisnik(uvjet) {
    console.log('Tražim s: ' + uvjet);
    return await http.get('/korisnik/trazi/'+uvjet);
  }

  async post(korisnik){
    //console.log(smjer);
    const odgovor = await http.post('/korisnik',korisnik)
       .then(response => {
         return {ok:true, poruka: 'Unio korisnika'}; // return u odgovor
       })
       .catch(error => {
        console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
  }

  async put(sifra,korisnik){
    const odgovor = await http.put('/korisnik/' + sifra,korisnik)
       .then(response => {
         return {ok:true, poruka: 'Promjenio korisnika'}; // return u odgovor
       })
       .catch(error => {
        console.log(error.response);
         return {ok:false, poruka: error.response.data}; // return u odgovor
       });
 
       return odgovor;
     }


  async delete(sifra){
    
    const odgovor = await http.delete('/korisnik/' + sifra)
       .then(response => {
         return {ok:true, poruka: 'Obrisao uspješno'};
       })
       .catch(error => {
         console.log(error);
         return {ok:false, poruka: error.response.data};
       });
 
       return odgovor;
     }

     async postaviSliku(sifra,slika){
    
      const odgovor = await http.put('/korisnik/postaviSliku/' + sifra,slika)
         .then(response => {
           return {ok:true, poruka: 'Postavio sliku'};
         })
         .catch(error => {
           console.log(error);
           return {ok:false, poruka: error.response.data};
         });
   
         return odgovor;
       }
     
 
}

export default new KorisnikDataService();