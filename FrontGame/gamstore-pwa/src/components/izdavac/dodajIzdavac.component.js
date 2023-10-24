import React, { Component } from "react";
import IzdavacDataService from "../../services/izdavac.service";
import Container from 'react-bootstrap/Container';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import { Link } from "react-router-dom";




export default class DodajIzdavac extends Component {

  constructor(props) {
    super(props);
    this.state = {
      izdavac:[]
    };

    this.dodajIzdavac = this.dodajIzdavac.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  async dodajIzdavac(izdavac) {
    const odgovor = await IzdavacDataService.post(izdavac);
    if(odgovor.ok){
      // routing na izdavaci
      window.location.href='/izdavaci';
    }else{
      // pokaži grešku
     // console.log(odgovor.poruka.errors);
      let poruke = '';
      for (const key in odgovor.poruka.errors) {
        if (odgovor.poruka.errors.hasOwnProperty(key)) {
          poruke += `${odgovor.poruka.errors[key]}` + '\n';
         // console.log(`${key}: ${odgovor.poruka.errors[key]}`);
        }
      }

      alert(poruke);
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



    this.dodajIzdavac({
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
            maxLength={255} defaultValue={izdavac.naziv} required />
          </Form.Group>


          <Form.Group className="mb-3" controlId="drzava">
            <Form.Label>Država</Form.Label>
            <Form.Control type="text" name="drzava" placeholder="Država izdavača"
            maxLength={255} defaultValue={izdavac.naziv} required />
          </Form.Group>


          <Form.Group className="mb-3" controlId="webStranica">
            <Form.Label>Web stranica</Form.Label>
            <Form.Control type="text" name="webStranica" placeholder="Web stranica izdavača"
            maxLength={255} defaultValue={izdavac.naziv} required />
          </Form.Group>



          <Row>
            <Col>
              <Link className="btn btn-danger gumb" to={`/izdavaci`}>Odustani</Link>
            </Col>
            <Col>
            <Button variant="primary" className="gumb" type="submit">
              Dodaj izdavača
            </Button>
            </Col>
          </Row>
         
          
        </Form>


      
    </Container>
    );
  }
}

