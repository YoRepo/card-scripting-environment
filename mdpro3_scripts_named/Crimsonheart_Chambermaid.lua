--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Chambermaid  (ID: 211080)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Illusion
-- Level 3
-- ATK 0 | DEF 0
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- You can only use 1 "Crimsonheart Chambermaid" effect per turn and only once that turn.
-- (1) During the Main Phase (Quick Effect): You can discard this card; place 1 "Crimsonheart"
-- monster from your Deck or GY in your Spell/Trap Zone face-up as a Continuous Spell, except
-- "Crimsonheart Chambermaid".
-- (2) If this card battles a monster, neither can be destroyed by that battle.
-- (3) When a "Crimsonheart" monster(s) is targeted by a card effect while this card is in your GY,
-- OR a non-"Crimsonheart" monster is targeted for an attack while this card is in your GY and you
-- control "Barren Lady Lacrimosaica" (Quick Effect): You can Tribute 1 of those monsters; Special
-- Summon this card to its field, but banish it when it leaves the field.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Chambermaid
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	--(1) discard; place 1 "Crimsonheart" monster from Deck/GY in your S/T Zone face-up as a Continuous Spell
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.plcon)
	e1:SetCost(s.plcost)
	e1:SetTarget(s.pltg)
	e1:SetOperation(s.plop)
	c:RegisterEffect(e1)
	--(2) this card and the monster it battles cannot be destroyed by that battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(s.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--(3a) from GY: a "Crimsonheart" monster is targeted by a card effect; Tribute 1, Special Summon this card
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_BECOME_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,id)
	e3:SetCondition(s.spcon1)
	e3:SetCost(s.spcost1)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
	--(3b) from GY: a non-"Crimsonheart" monster is targeted for an attack while you control Lacrimosaica
	local e4=e3:Clone()
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetCondition(s.spcon2)
	e4:SetCost(s.spcost2)
	c:RegisterEffect(e4)
end
--(1)
function s.plcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function s.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function s.plfilter(c)
	return c:IsSetCard(0x95c) and c:IsType(TYPE_MONSTER) and not c:IsCode(id)
end
function s.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.plfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
end
function s.plop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,s.plfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil):GetFirst()
	if tc and Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then
		--treat the placed monster as a Continuous Spell while it remains on the field
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
	end
end
--(2)
function s.indtg(e,c)
	local tc=e:GetHandler()
	return c==tc or c==tc:GetBattleTarget()
end
--(3a) condition: a "Crimsonheart" monster(s) became the target of a card effect
function s.cfilter1(c)
	return c:IsSetCard(0x95c) and c:IsLocation(LOCATION_MZONE)
end
function s.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter1,1,nil)
end
function s.costfilter1(c)
	return c:IsSetCard(0x95c) and c:IsLocation(LOCATION_MZONE) and c:IsReleasable()
end
function s.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(s.costfilter1,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=eg:Filter(s.costfilter1,nil):Select(tp,1,1,nil)
	e:SetLabel(sg:GetFirst():GetControler())
	Duel.Release(sg,REASON_COST)
end
--(3b) condition: a non-"Crimsonheart" monster was targeted for an attack & you control Lacrimosaica
function s.cfilter2(c)
	return not c:IsSetCard(0x95c) and c:IsLocation(LOCATION_MZONE)
end
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter2,1,nil)
		and Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.costfilter2(c)
	return not c:IsSetCard(0x95c) and c:IsLocation(LOCATION_MZONE) and c:IsReleasable()
end
function s.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(s.costfilter2,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=eg:Filter(s.costfilter2,nil):Select(tp,1,1,nil)
	e:SetLabel(sg:GetFirst():GetControler())
	Duel.Release(sg,REASON_COST)
end
--(3) shared Special Summon target/operation (summon to the tributed monster's field; banish if it leaves)
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local rc=e:GetLabel()
	if Duel.SpecialSummon(c,0,tp,rc,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end
