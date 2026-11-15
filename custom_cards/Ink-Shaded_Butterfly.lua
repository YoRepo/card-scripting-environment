--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shaded Butterfly  (ID: 99811010)
-- Type: Monster / Effect / Fusion / Tuner
-- Attribute: WIND
-- Race: Illusion
-- Level 3
-- ATK 600 | DEF 400
-- Setcode: 0x1961 (Ink-Shaded)
--
-- Materials: 1 "Ink Shader" monster + 1 WIND monster
--
-- Effect Text:
-- Must either be Fusion Summoned, or Special Summoned (from your Extra Deck) by sending 1 Spell/Trap
-- from the field to the GY while you control a Level 3 or higher "Ink Shader" monster. You can only
-- Special Summon "Ink-Shaded Butterfly(s)" once per turn.
-- ① If this card is Special Summoned: You can send 1 "Ink-Shade" Spell/Trap from your Deck to the GY.
-- ② "Ink Shader" monsters you control cannot be destroyed by card effects.
-- ③ If this card is in your GY (Quick Effect): You can return this card to the Extra Deck; add 1 "Ink
-- Shader" monster from your Deck or GY to your hand.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shaded Butterfly
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--you can only Special Summon "Ink-Shaded Butterfly(s)" once per turn (any method: no "this way")
	c:SetSPSummonOnce(id)
	--fusion material: 1 "Ink Shader" monster + 1 WIND monster
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x960),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WIND),true)
	--must be Fusion Summoned, or Special Summoned by the procedure below, which the engine does not check
	--against this (cf. Artmage Non-Finito, Divine Serpent Apophis)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.fuslimit)
	c:RegisterEffect(e0)
	--SS proc (from Extra Deck): send 1 Spell/Trap from the field to the GY while you control a Level 3+ "Ink Shader" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) if this card is Special Summoned: send 1 "Ink-Shade" Spell/Trap from Deck to GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(s.tgtg)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
	--(2) "Ink Shader" monsters you control cannot be destroyed by card effects
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x960))
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--(3) (Quick Effect) from GY: return this card to the Extra Deck; add 1 "Ink Shader" monster from Deck/GY to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_GRAVE_ACTION)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e4:SetCost(s.thcost)
	e4:SetTarget(s.thtg)
	e4:SetOperation(s.thop)
	c:RegisterEffect(e4)
end
--SS proc (send 1 Spell/Trap from the field to the GY while you control a Level 3+ "Ink Shader" monster)
function s.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960) and c:IsLevelAbove(3)
end
--"from the field": either player's, face-up or Set (cf. Trap Eater, which sends an opponent's Trap).
--A Monster Card treated as a Continuous Spell counts; one that would be banished instead cannot be sent as cost
function s.spcfilter(c,tp,sc)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
		and Duel.GetLocationCountFromEx(tp,tp,c,sc)>0
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.lvfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,tp,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_SPSUMMON)
end
--(1)
function s.tgfilter(c)
	return c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--(3)
function s.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function s.thfilter(c)
	return c:IsSetCard(0x960) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
