import React, { Component } from "react";
import GrupaDataService from "../../services/grupa.service";
import SmjerDataService from "../../services/smjer.service";
import PolaznikDataService from "../../services/polaznik.service";
import Container from 'react-bootstrap/Container';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import { Link } from "react-router-dom";
import moment from 'moment';
import Table from 'react-bootstrap/Table';
import { FaTrash } from 'react-icons/fa';

import { AsyncTypeahead } from 'react-bootstrap-typeahead';


export default class PromjeniGrupa extends Component {

  constructor(props) {
    super(props);

    

  //  console.log('Konstruktor PromjeniGrupa');

    

    this.grupa = this.dohvatiGrupa();
    this.promjeniGrupa = this.promjeniGrupa.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.smjerovi = this.dohvatiSmjerovi();
    this.polaznici = this.dohvatiPolaznici();
    this.obrisiPolaznika = this.obrisiPolaznika.bind(this);
    this.traziPolaznik = this.traziPolaznik.bind(this);
    this.dodajPolaznika = this.dodajPolaznika.bind(this);


    this.state = {
      grupa: {},
      smjerovi: [],
      polaznici: [],
      sifraSmjer:0,
      pronadeniPolaznici: []
    };
  }




  async dohvatiGrupa() {
    // ovo mora bolje
    //console.log('Dohvaćam grupu');
    let href = window.location.href;
    let niz = href.split('/'); 
    await GrupaDataService.getBySifra(niz[niz.length-1])
      .then(response => {
        let g = response.data;
        g.vrijemePocetka = moment.utc(g.datumPocetka).format("HH:mm");
        g.datumPocetka = moment.utc(g.datumPocetka).format("yyyy-MM-DD");
        
        //console.log(g.vrijemePocetka);
        this.setState({
          grupa: g
        });
       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }

  

  async promjeniGrupa(grupa) {
    const odgovor = await GrupaDataService.post(grupa);
    if(odgovor.ok){
      // routing na smjerovi
      window.location.href='/grupe';
    }else{
      // pokaži grešku
      console.log(odgovor);
    }
  }


  async dohvatiSmjerovi() {
   // console.log('Dohvaćm smjerove');
    await SmjerDataService.get()
      .then(response => {
        this.setState({
          smjerovi: response.data,
          sifraSmjer: response.data[0].sifra
        });

       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }

  async dohvatiPolaznici() {
    let href = window.location.href;
    let niz = href.split('/'); 
    await GrupaDataService.getPolaznici(niz[niz.length-1])
       .then(response => {
         this.setState({
           polaznici: response.data
         });
 
        // console.log(response.data);
       })
       .catch(e => {
         console.log(e);
       });
   }

   

   async traziPolaznik( uvjet) {

    await PolaznikDataService.traziPolaznik( uvjet)
       .then(response => {
         this.setState({
          pronadeniPolaznici: response.data
         });
 
        // console.log(response.data);
       })
       .catch(e => {
         console.log(e);
       });
   }

   async obrisiPolaznika(grupa, polaznik){
    const odgovor = await GrupaDataService.obrisiPolaznika(grupa, polaznik);
    if(odgovor.ok){
     this.dohvatiPolaznici();
    }else{
     //this.otvoriModal();
    }
   }

   async dodajPolaznika(grupa, polaznik){
    const odgovor = await GrupaDataService.dodajPolaznika(grupa, polaznik);
    if(odgovor.ok){
     this.dohvatiPolaznici();
    }else{
    //this.otvoriModal();
    }
   }
 

  handleSubmit(e) {
    e.preventDefault();
    const podaci = new FormData(e.target);
    console.log(podaci.get('datumPocetka'));
    console.log(podaci.get('vrijeme'));
    let datum = moment.utc(podaci.get('datumPocetka') + ' ' + podaci.get('vrijeme'));
    console.log(datum);

    this.promjeniGrupa({
      naziv: podaci.get('naziv'),
      datumPocetka: datum,
      sifraSmjer: this.state.sifraSmjer
    });
    
  }


  render() { 
    const { smjerovi} = this.state;
    const { grupa} = this.state;
    const { polaznici} = this.state;
    const { pronadeniPolaznici} = this.state;


    const obradiTrazenje = (uvjet) => {
      this.traziPolaznik( uvjet);
    };

    const odabraniPolaznik = (polaznik) => {
      //console.log(grupa.sifra + ' - ' + polaznik[0].sifra);
      if(polaznik.length>0){
        this.dodajPolaznika(grupa.sifra, polaznik[0].sifra);
      }
     
    };

    return (
    <Container>
       
        <Form onSubmit={this.handleSubmit}>
          <Row>
          <Col key="1" sm={12} lg={6} md={6}>
              <Form.Group className="mb-3" controlId="naziv">
                <Form.Label>Naziv</Form.Label>
                <Form.Control type="text" name="naziv" placeholder="" maxLength={255} defaultValue={grupa.naziv}  required/>
              </Form.Group>

              <Form.Group className="mb-3" controlId="smjer">
                <Form.Label>Smjer</Form.Label>
                <Form.Select defaultValue={grupa.sifraSmjer}  onChange={e => {
                  this.setState({ sifraSmjer: e.target.value});
                }}>
                {smjerovi && smjerovi.map((smjer,index) => (
                      <option key={index} value={smjer.sifra}>{smjer.naziv}</option>

                ))}
                </Form.Select>
              </Form.Group>

              <Form.Group className="mb-3" controlId="datumPocetka">
                <Form.Label>Datum početka</Form.Label>
                <Form.Control type="date" name="datumPocetka" placeholder="" defaultValue={grupa.datumPocetka}  />
              </Form.Group>

              <Form.Group className="mb-3" controlId="vrijeme">
                <Form.Label>Vrijeme</Form.Label>
                <Form.Control type="time" name="vrijeme" placeholder="" defaultValue={grupa.vrijemePocetka}  />
              </Form.Group>

            



              <Row>
                <Col>
                  <Link className="btn btn-danger gumb" to={`/grupe`}>Odustani</Link>
                </Col>
                <Col>
                <Button variant="primary" className="gumb" type="submit">
                  Promjeni grupu
                </Button>
                </Col>
              </Row>
          </Col>
          <Col key="2" sm={12} lg={6} md={6} className="polazniciGrupa">
          <Form.Group className="mb-3" controlId="uvjet">
                <Form.Label>Traži polaznika</Form.Label>
                
          <AsyncTypeahead
            className="autocomplete"
            id="uvjet"
            emptyLabel="Nema rezultata"
            searchText="Tražim..."
            labelKey={(polaznik) => `${polaznik.prezime} ${polaznik.ime}`}
            minLength={3}
            options={pronadeniPolaznici}
            onSearch={obradiTrazenje}
            placeholder="dio imena ili prezimena"
            renderMenuItemChildren={(polaznik) => (
              <>
                <span>{polaznik.prezime} {polaznik.ime}</span>
              </>
            )}
            onChange={odabraniPolaznik}
          />
          </Form.Group>
          <Table striped bordered hover responsive>
              <thead>
                <tr>
                  <th>Polaznik</th>
                  <th>Akcija</th>
                </tr>
              </thead>
              <tbody>
              {polaznici && polaznici.map((polaznik,index) => (
                
                <tr key={index}>
                  <td > {polaznik.ime} {polaznik.prezime}</td>
                  <td>
                  <Button variant="danger"   onClick={() => this.obrisiPolaznika(grupa.sifra, polaznik.sifra)}><FaTrash /></Button>
                    
                  </td>
                </tr>
                ))
              }
              </tbody>
            </Table>    
          </Col>
          </Row>

          
         
          
        </Form>


      
    </Container>
    );
  }
}

