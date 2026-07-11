--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Gadget Box  (ID: 8025950)
-- Type: Spell / Continuous
-- Setcode: 0x51, 0x26
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as a "Morphtronic" card.)
-- When this card is activated: Place 3 Morph Counters on it.
-- Once per turn, during your Main Phase: You can remove 1 Morph Counter from your field, and if you
-- do, Special Summon 1 "Gadget Box Token" (Machine/EARTH/Level 1/ATK 0/DEF 0).
-- While that Token is in the Monster Zone, the player who Summoned it cannot Special Summon monsters
-- from the Extra Deck, except Synchro Monsters.
-- You can only activate 1 "Gadget Box" per turn.
--[[ __CARD_HEADER_END__ ]]

--ガジェット・ボックス
function c8025950.initial_effect(c)
	c:EnableCounterPermit(0x8)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,8025950+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c8025950.target)
	e1:SetOperation(c8025950.activate)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c8025950.sptg)
	e2:SetOperation(c8025950.spop)
	c:RegisterEffect(e2)
end
function c8025950.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanAddCounter(tp,0x8,3,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x8)
end
function c8025950.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:AddCounter(0x8,3)
	end
end
function c8025950.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x8,1,REASON_EFFECT) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,8025951,0x51,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c8025950.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.RemoveCounter(tp,1,0,0x8,1,REASON_EFFECT) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,8025951,0x51,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,8025951)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetAbsoluteRange(tp,1,0)
		e1:SetTarget(c8025950.splimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1,true)
		Duel.SpecialSummonComplete()
	end
end
function c8025950.splimit(e,c)
	return not c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_EXTRA)
end
