--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 推进战士  (ID: 80457744)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 102
--
-- Effect Text:
-- ①：自己场上有调整存在的场合，这张卡可以从手卡守备表示特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己场上的战士族怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--ブースト・ウォリアー
function c80457744.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c80457744.spcon)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WARRIOR))
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
function c80457744.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c80457744.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c80457744.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
