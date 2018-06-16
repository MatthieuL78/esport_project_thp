$(document).on ("turbolinks:load", function(){
  // menu version mobile
  $('#nav-toggle').click(function(e) {
    $('.main-nav').toggleClass('is-open');
    $('.hamburger').toggleClass('is-open');
    $('body').toggleClass('fixed');
    $('#menu-app-slide').toggleClass('slider');
  });

// top 10
  $(".classement-players").hide();

  $('.classement-cover').click(function() {
    $(this).find('.classement-players').toggle(200);
  });

  // $(window).scroll(function(e) {
  //   console.log(e)
  // });


	//  Calcul de la valeur sur 100 pour le graphique
	function percentageMe(valeur, plafond){
		result = (valeur * 100) / plafond
		return result
	}
// Récupération des stats du joueur (cachées dans la page pr l'instant)

// -----------------------------------------------------------------------------------------------
	var chartOptions = {
		scale: {
		  gridLines: {
			 color: "black",
			 lineWidth: .2
		  },
		  angleLines: {
			 display: true
		  },
		  ticks: {
			 beginAtZero: true,
			 min: 0,
			 max: 100,
			 stepSize: 10
		  },
		  pointLabels: {
			 fontSize: 18,
			 fontColor: "black"
		  }
		},
		legend: {
		  position: 'top'
		}
	 };



	var ctx = document.getElementById('myChart').getContext('2d');
	var myRadarChart = new Chart(ctx, {
		 // The type of chart we want to create
		 type: 'radar',




		 // The data for our dataset
		 data: {
			  labels: ["Classement", "Gain", "activité", "Streaming", "R.sociaux", "Exp", "Ratio W/L"],
			  datasets: [{
					label: "My First dataset",
					backgroundColor: 'rgba(206, 251, 95,.8)',
					borderColor: 'rgb(15, 13, 51)',
					data: [
						percentageMe(4000, 4000),
						percentageMe(49000,50000),
						percentageMe(3500, 4000),
						percentageMe(20000,50000),
						percentageMe(3000, 4000),
						percentageMe(35000,50000),
						percentageMe(4000, 4000)
					],
			  }]
		 },


		 // Configuration options go here

		 options: chartOptions
})


})
