import React, { Component } from "react";
import NarudzbaDataService from "../../services/narudzba.service";
import KorisnikDataService from "../../services/korisnik.service";
import Container from 'react-bootstrap/Container';
import moment from 'moment';


export default class PromjeniNarudzba extends Component {

  constructor(props) {
    super(props);

    

  //  console.log('Konstruktor PromjeniIgra');

    

    this.narudzba = this.dohvatiNarudzba();
    this.promjeniNarudzba = this.promjeniNarudzba.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.korisnici = this.korisnici();
    this.obrisiKorisnika = this.obrisiKorisnika.bind(this);
    this.traziKorisnika = this.traziKorisnika.bind(this);
    this.dodajKorisnika = this.dodajKorisnika.bind(this);


    this.state = {
      narudzba: {},
      korisnici: [],
      sifraKorisnik:0,
      pronadeniKorisnici: []
    };
  }




  async dohvatiNarudzbe() {
    // ovo mora bolje
    //console.log('Dohvaćam narudzbee');
    let href = window.location.href;
    let niz = href.split('/'); 
    await NarudzbaDataService.getBySifra(niz[niz.length-1])
      .then(response => {
        let n = response.data;
        n.datumObracuna = moment.utc(n.datumObracuna).format("yyyy-MM-DD");
        
        //console.log(g.vrijemePocetka);
        this.setState({
          narudzba: n
        });
       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }

  

  async PromejniNarudzba(narudzba) {
    const odgovor = await NarudzbaDataService.post(narudzba);
    if(odgovor.ok){
      // routing na narudzbe
      window.location.href='/narudzbe';
    }else{
      // pokaži grešku
      console.log(odgovor);
    }
  }


  async dohvatiKorisnika() {
   // console.log('Dohvaćm izdavace');
    await KorisnikDataService.get()
      .then(response => {
        this.setState({
          korisnici: response.data,
          sifraKorisnik: response.data[0].sifra
        });

       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }

  
   async traziKorisnika( uvjet) {

    await NarudzbaDataService.traziKorisnika( uvjet)
       .then(response => {
         this.setState({
          pronadeniKorisnici: response.data
         });
 
        // console.log(response.data);
       })
       .catch(e => {
         console.log(e);
       });
   }

   async obrisiKorisnika(narudzba, korisnik){
    const odgovor = await NarudzbaDataService.obrisiKorisnika(narudzba, korisnik);
    if(odgovor.ok){
     this.dohvatiKorisnika();
    }else{
     //this.otvoriModal();
    }
   }

   async dodajKorisnika(narudzba, korisnik){
    const odgovor = await NarudzbaDataService.dodajKorisnika(narudzba, korisnik);
    if(odgovor.ok){
     this.dohvatiKorisnika();
    }else{
    //this.otvoriModal();
    }
   }
 

   handleSubmit(e) {
    e.preventDefault();
    const podaci = new FormData(e.target);
    console.log(podaci.get('datumObracuna'));
    console.log(podaci.get('vrijeme'));
    let datum = moment.utc(podaci.get('datumObracuna') + ' ' + podaci.get('vrijeme'));
    console.log(datum);


    this.dodajNarudzba({
      placanje: podaci.get('placanje'),
      sifraKorisnik: this.state.sifraKorisnik,
      datumObracuna: datum
    });
    
  }


  render() { 
    

    return (
    <Container>
       
        
    </Container>
    );
  }
}

