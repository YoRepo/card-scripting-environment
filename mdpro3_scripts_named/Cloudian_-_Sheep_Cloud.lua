--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Cloudian - Sheep Cloud  (ID: 56597272)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fairy
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0x18
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is destroyed by battle and sent to the GY: Special Summon 2 "Cloudian Tokens"
-- (Fairy/WATER/Level 1/ATK 0/DEF 0) in Defense Position.
-- These Tokens cannot be Tributed for a Tribute Summon, except for "Cloudian" monsters.
--[[ __CARD_HEADER_END__ ]]

--雲魔物－羊雲
function c56597272.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56597272,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c56597272.condition)
	e1:SetTarget(c56597272.target)
	e1:SetOperation(c56597272.operation)
	c:RegisterEffect(e1)
end
function c56597272.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c56597272.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c56597272.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,56597273,0x18,TYPES_TOKEN_MONSTER,0,0,1,RACE_FAIRY,ATTRIBUTE_WATER,POS_FACEUP_DEFENSE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,56597273)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c56597272.sumlimit)
		token:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
function c56597272.sumlimit(e,c)
	return not c:IsSetCard(0x18)
end
