--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Wall of Ivy  (ID: 30069398)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Plant
-- Level: 2
-- ATK 300 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Special Summon 1 "Ivy Token" (Plant-Type/EARTH/Level 1/ATK 0/DEF 0) in Defense Position to
-- your opponent's side of the field.
-- When this Token is destroyed, its controller takes 300 damage.
--[[ __CARD_HEADER_END__ ]]

--アイヴィ・ウォール
function c30069398.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30069398,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetTarget(c30069398.target)
	e1:SetOperation(c30069398.operation)
	c:RegisterEffect(e1)
end
function c30069398.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c30069398.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,30069399,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) then return end
	local token=Duel.CreateToken(tp,30069399)
	if Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetOperation(c30069398.damop)
		token:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
function c30069398.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) then
		Duel.Damage(c:GetPreviousControler(),300,REASON_EFFECT)
	end
	e:Reset()
end
