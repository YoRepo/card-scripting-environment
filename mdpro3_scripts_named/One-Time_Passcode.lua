--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: One-Time Passcode  (ID: 93104632)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Special Summon 1 "Security Token" (Cyberse/LIGHT/Level 4/ATK 2000/DEF 2000) in Defense Position.
-- You can only activate 1 "One-Time Passcode" per turn.
--[[ __CARD_HEADER_END__ ]]

--ワンタイム・パスコード
function c93104632.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,93104632+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c93104632.target)
	e1:SetOperation(c93104632.activate)
	c:RegisterEffect(e1)
end
function c93104632.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93104633,0,TYPES_TOKEN_MONSTER,2000,2000,4,RACE_CYBERSE,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c93104632.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,93104633,0,TYPES_TOKEN_MONSTER,2000,2000,4,RACE_CYBERSE,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE) then return end
	local token=Duel.CreateToken(tp,93104633)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
