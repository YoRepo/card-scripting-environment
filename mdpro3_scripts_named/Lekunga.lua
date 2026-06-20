--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 裂蕈牙  (ID: 62543393)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level 4
-- ATK 1700 | DEF 500
--
-- Effect Text:
-- 从自己墓地里除外2只水属性怪兽，在自己场上以攻击表示特殊召唤1只「裂蕈牙衍生物」（水·2星·植物族·攻/守700）。
--[[ __CARD_HEADER_END__ ]]

--レクンガ
function c62543393.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62543393,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c62543393.cost)
	e1:SetTarget(c62543393.target)
	e1:SetOperation(c62543393.operation)
	c:RegisterEffect(e1)
end
function c62543393.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToRemoveAsCost()
end
function c62543393.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62543393.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c62543393.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c62543393.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,62543394,0,TYPES_TOKEN_MONSTER,700,700,2,RACE_PLANT,ATTRIBUTE_WATER,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c62543393.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,62543394,0,TYPES_TOKEN_MONSTER,700,700,2,RACE_PLANT,ATTRIBUTE_WATER,POS_FACEUP_ATTACK) then
		local token=Duel.CreateToken(tp,62543394)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
