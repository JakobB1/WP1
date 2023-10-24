import React, { Component } from "react";
import IzdavacDataService from "../../services/izdavac.service";
import Container from 'react-bootstrap/Container';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import { Link } from "react-router-dom";



export default class PromjeniIzdavac extends Component {

  constructor(props) {
    super(props);
    this.izdavac = this.dohvatiIzdavac();
    this.promjeniIzdavac = this.PromjeniIzdavac.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    

    this.state = {
      izdavac: {}
    };

  }



  async dohvatiIzdavac() {
    let href = window.location.href;
    let niz = href.split('/'); 
    await IzdavacDataService.getBySifra(niz[niz.length-1])
      .then(response => {
        this.setState({
          izdavac: response.data
        });
       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
    
   
  }

  async PromjeniIzdavac(izdavac) {
    // ovo mora bolje
    let href = window.location.href;
    let niz = href.split('/'); 
    const odgovor = await IzdavacDataService.put(niz[niz.length-1],izdavac);
    if(odgovor.ok){
      // routing na izdavacima
      window.location.href='/izdavaci';
    }else{
      // pokaži grešku
      console.log(odgovor);
    }
  }



  handleSubmit(e) {
    // Prevent the browser from reloading the page
    e.preventDefault();

    // Read the form data
    const podaci = new FormData(e.target);
    //Object.keys(formData).forEach(fieldName => {
    // console.log(fieldName, formData[fieldName]);
    //})
    
    //console.log(podaci.get('verificiran'));
    // You can pass formData as a service body directly:

    this.promjeniIzdavac({
      naziv: podaci.get('naziv'),
      drzava: podaci.get('drzava'),
      webStranica: podaci.get('webStranica')
    });
    
  }


  render() {
    
   const { izdavac} = this.state;


    return (
    <Container>
        <Form onSubmit={this.handleSubmit}>


        <Form.Group className="mb-3" controlId="naziv">
            <Form.Label>Naziv</Form.Label>
            <Form.Control type="text" name="naziv" placeholder="Naziv izdavača" 
            maxLength={255} defaultValue={izdavac.naziv} required/>
        </Form.Group>


        <Form.Group className="mb-3" controlId="drzava">
            <Form.Label>Dražava</Form.Label>
            <Form.Control type="text" name="drzava" placeholder="Država izdavača" 
            maxLength={255} defaultValue={izdavac.drzava} required/>
        </Form.Group>


        <Form.Group className="mb-3" controlId="webStranica">
            <Form.Label>Web stranica</Form.Label>
            <Form.Control type="text" name="webStranica" placeholder="Država izdavača" 
            maxLength={255} defaultValue={izdavac.webStranica} required/>
        </Form.Group>

          
         
          <Row>
            <Col>
              <Link className="btn btn-danger gumb" to={`/izdavaci`}>Odustani</Link>
            </Col>
            <Col>
            <Button variant="primary" className="gumb" type="submit">
              Promjeni izdavača
            </Button>
            </Col>
          </Row>
        </Form>


      
    </Container>
    );
  }
}

