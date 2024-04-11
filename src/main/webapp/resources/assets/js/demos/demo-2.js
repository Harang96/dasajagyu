// Demo 2 Js file
$(document).ready(function () {
    'use strict';

    // Deal of the day countdown
	if ( $.fn.countdown ) {
		$('.deal-countdown').each(function () {
			var $this = $(this), 
				untilDate = $this.data('until'),
				compact = $this.data('compact');

			$this.countdown({
			    until: untilDate, // this is relative date +10h +5m vs..
			    format: 'YODHMS',
			    padZeroes: true,
			    labels: ['년', '월', 'weeks', '일', '시', '분', '초'],
			    labels1: ['년', '월', 'week', '일', '시', '분', '초']
			});
		});

		// Pause
		// $('.deal-countdown').countdown('pause');
	}
});