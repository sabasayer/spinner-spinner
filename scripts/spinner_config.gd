class_name SpinnerConfig

enum SpinnerType {
	Plus1,
	Plus2,
	Plus5Minues1,
	Jackpot
}

const AREA_RADIUS = 62
const EARN_COLOR = Color("458600")
const LOOSE_COLOR = Color("d31930")
const EMPTY_COLOR = Color("ededed")

const SpinnerCosts = {
	SpinnerType.Plus1: {
		"buy": 3,
		"sell": 1
	},
	SpinnerType.Plus2: {
		"buy": 5,
		"sell": 2
	},
	SpinnerType.Plus5Minues1: {
		"buy": 10,
		"sell": 4
	},
	SpinnerType.Jackpot: {
		"buy": 100,
		"sell": 20
	}
}

const AREAS_PER_TYPE = {
	SpinnerType.Plus1 : [
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"amount": 0,
			"start_angle": 120.0,
			"end_angle": 240.0,
			"color": EMPTY_COLOR,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": -120.0,
			"end_angle": 120.0,
			"color": EARN_COLOR,
			"amount": 1,
			"radius": AREA_RADIUS
		}
	],
	SpinnerType.Plus2 : [
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"amount": 0,
			"start_angle": -300.0,
			"end_angle": -120.0,
			"color": EMPTY_COLOR,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": -120.0,
			"end_angle": 60.0,
			"color": EARN_COLOR,
			"amount": 2,
			"radius": AREA_RADIUS
		}
	],
	SpinnerType.Plus5Minues1 : [
		{
			"type": SpinnerArea.AreaType.LOSE_FIXED,
			"amount": 1,
			"start_angle": -150.0,
			"end_angle": -90.0,
			"color": LOOSE_COLOR,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"amount": 0,
			"start_angle": -270.0,
			"end_angle": -150.0,
			"color": EMPTY_COLOR,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": -90.0,
			"end_angle": 90.0,
			"color": EARN_COLOR,
			"amount": 5,
			"radius": AREA_RADIUS
		}
	],
	SpinnerType.Jackpot : [
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": 0.0,
			"end_angle": 30.0,
			"color": EARN_COLOR,
			"amount": 100,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.LOSE_FIXED,
			"start_angle": 30.0,
			"end_angle": 70.0,
			"color": LOOSE_COLOR,
			"amount": 5,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": 70.0,
			"end_angle": 120.0,
			"color": EARN_COLOR,
			"amount": 5,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.LOSE_FIXED,
			"start_angle": 120.0,
			"end_angle": 170.0,
			"color": LOOSE_COLOR,
			"amount": 5,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": 170.0,
			"end_angle": 220.0,
			"color": EARN_COLOR,
			"amount": 5,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.LOSE_FIXED,
			"start_angle": 220.0,
			"end_angle": 280.0,
			"color": LOOSE_COLOR,
			"amount": 5,
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"start_angle": 280.0,
			"end_angle": 360.0,
			"color": EMPTY_COLOR,
			"amount": 0,
			"radius": AREA_RADIUS
		}
	]
}

static func get_buy_cost(type:SpinnerType):
	return SpinnerCosts.get(type).buy
	

static func get_sell_cost(type:SpinnerType):
	return SpinnerCosts.get(type).sell
