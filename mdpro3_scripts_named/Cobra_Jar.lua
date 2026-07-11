--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cobra Jar  (ID: 86801871)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Reptile
-- Level: 2
-- ATK 600 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Special Summon 1 "Poisonous Snake Token" (Reptile-Type/EARTH/Level 3/ATK 1200/DEF 1200).
-- When the "Poisonous Snake Token" is destroyed as a result of battle, inflict 500 points of damage to
-- your opponent's Life Points.
--[[ __CARD_HEADER_END__ ]]

--スネークポット
function c86801871.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86801871,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c86801871.sptg)
	e1:SetOperation(c86801871.spop)
	c:RegisterEffect(e1)
end
function c86801871.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c86801871.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,86801872,0,TYPES_TOKEN_MONSTER,1200,1200,3,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,86801872)
	if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYED)
		e1:SetLabelObject(token)
		e1:SetCondition(c86801871.damcon)
		e1:SetOperation(c86801871.damop)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.SpecialSummonComplete()
end
function c86801871.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tok=e:GetLabelObject()
	if eg:IsContains(tok) then
		return true
	else
		if not tok:IsLocation(LOCATION_MZONE) then e:Reset() end
		return false
	end
end
function c86801871.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
