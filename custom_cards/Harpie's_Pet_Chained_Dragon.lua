--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-09-26T00:00:00
-- Card: Harpie's Pet Chained Dragon  (ID: 99810040)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Dragon
-- Level 10
-- ATK 2900 | DEF 3400
-- Setcode: 0x64 (Harpie)
--
-- Materials: 1 Tuner + 1+ non-Tuner monsters
--
-- Effect Text:
-- Must first either be Synchro Summoned, or Special Summoned (from your Extra Deck) by banishing 1
-- "Harpie Lady" and 1 WIND Dragon monster from your GY. You can only Special Summon "Harpie's Pet
-- Chained Dragon" once per turn. You can only use each effect of "Harpie's Pet Chained Dragon" once
-- per turn.
-- ① When your opponent activates a card or effect (Quick Effect): You can return 1 "Harpie Lady" you
-- control to the hand or Extra Deck; negate the activation, then you can banish 1 card from your
-- opponent's field and/or GY for every "Harpie Lady" you control.
-- ② If this card leaves the field because of an opponent's card: You can Special Summon up to 2
-- "Harpie" monsters with different types from your Banishment.
--[[ __CARD_HEADER_END__ ]]

--Harpie's Pet Chained Dragon
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,76812113)
	aux.AddSetNameMonsterList(c,0x64)
	--synchro summon: 1 Tuner + 1 or more non-Tuner monsters
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--you can only Special Summon "Harpie's Pet Chained Dragon" once per turn (any method: no "this way")
	c:SetSPSummonOnce(id)
	--must first be Synchro Summoned, or Special Summoned by the procedure below (only gated in the Extra Deck)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(s.splimit)
	c:RegisterEffect(e0)
	--SS proc (from Extra Deck): banish 1 "Harpie Lady" and 1 WIND Dragon monster from your GY
	--(described, since the Synchro Summon is offered alongside it)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) (Quick Effect) when opponent activates a card or effect: return 1 "Harpie Lady" you control to the
	--hand/Extra Deck; negate the activation, then you can banish 1 card from their field/GY per "Harpie Lady" you control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.negcon)
	e2:SetCost(s.negcost)
	e2:SetTarget(s.negtg)
	e2:SetOperation(s.negop)
	c:RegisterEffect(e2)
	--(2) if this card leaves the field because of an opponent's card: SS up to 2 "Harpie" monsters with different Types from banishment
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.spcon2)
	e3:SetTarget(s.sptg2)
	e3:SetOperation(s.spop2)
	c:RegisterEffect(e3)
end
--Summoning Condition (from the Extra Deck: Synchro Summon, or the SS proc below, which the engine does not check against this)
function s.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.synlimit(e,se,sp,st)
end
--SS proc (banish 1 "Harpie Lady" and 1 WIND Dragon monster from your GY)
function s.wdfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_DRAGON)
end
function s.rmfilter(c)
	return (c:IsCode(76812113) or s.wdfilter(c)) and c:IsAbleToRemoveAsCost()
end
--2 different cards: one "Harpie Lady", the other a WIND Dragon (aux.gffcheck tries both assignments)
function s.fselect(g)
	return aux.gffcheck(g,Card.IsCode,76812113,s.wdfilter,nil)
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(s.rmfilter,tp,LOCATION_GRAVE,0,nil)
	return Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and g:CheckSubGroup(s.fselect,2,2)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.rmfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:SelectSubGroup(tp,s.fselect,true,2,2)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
	g:DeleteGroup()
end
--(1)
--"Harpie Lady" you control: face-up (a face-down card keeps its printed code)
function s.hlfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
--"to the hand or Extra Deck": IsAbleToHandAsCost is false for every Extra Deck monster, so a Fusion/Synchro
--"Harpie Lady" is checked with IsAbleToExtraAsCost (cf. the "Ashtra" monsters); SendtoHand sends it to the Extra Deck
function s.rthfilter(c)
	return s.hlfilter(c) and (c:IsAbleToHandAsCost() or c:IsAbleToExtraAsCost())
end
function s.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.rthfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,s.rthfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.HintSelection(g)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	--"then": only if the activation was negated; "Harpie Lady" are counted now, after the cost
	if not Duel.NegateActivation(ev) then return end
	local ct=Duel.GetMatchingGroupCount(s.hlfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(Card.IsAbleToRemove),tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	if ct>0 and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g:Select(tp,math.min(ct,#g),math.min(ct,#g),nil)
		Duel.HintSelection(sg)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
--(2)
--"because of an opponent's card": the reason player covers card effects and battle (cf. Chaos Archfiend)
function s.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp) and c:GetReasonPlayer()==1-tp
end
function s.spfilter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x64) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter2,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	local ft=math.min(Duel.GetLocationCount(tp,LOCATION_MZONE),2)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Duel.GetMatchingGroup(s.spfilter2,tp,LOCATION_REMOVED,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,aux.drccheck,false,1,ft)
	if sg then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
