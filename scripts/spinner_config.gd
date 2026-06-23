class_name SpinnerConfig

enum SpinnerType {
	Plus1,
	Plus5Minues1
}

const AREA_RADIUS = 62

const AREAS_PER_TYPE = {
	SpinnerType.Plus1 : [
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"amount": 0,
			"start_angle": -270.0,
			"end_angle": -90.0,
			"color": Color.GRAY,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": -90.0,
			"end_angle": 90.0,
			"color": Color.GREEN,
			"amount": 1,
			"radius": AREA_RADIUS
		}
	]
}
