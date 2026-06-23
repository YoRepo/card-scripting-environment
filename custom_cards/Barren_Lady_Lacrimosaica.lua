--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T00:00:00
-- Card: Barren Lady Lacrimosaica  (ID: 211000)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2800 | DEF 2200
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- Summoning Condition: You can Special Summon this card (from your Deck) by sending 3 "Crimsonheart"
-- cards you control to the GY. You can only use each effect of "Barren Lady Lacrimosaica" once per turn.
-- (1) (Quick Effect): You can shuffle this card from your hand into the Deck; send 1 "Crimsonheart" card
-- from your Deck to the GY (except "Barren Lady Lacrimosaica").
-- (2) After this card is Summoned, for the rest of the turn, you can activate the effects of "Crimsonheart"
-- Traps the turn they are Set.
--[[ __CARD_HEADER_END__ ]]

--Barren Lady Lacrimosaica
local s,id,o=GetID()
function s.initial_effect(c)
	--spsummon proc (from Deck by sending 3 "Crimsonheart" cards you control to the GY)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCondition(s.spcon)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) shuffle from hand into Deck; send 1 "Crimsonheart" from Deck to GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,id)
	e2:SetCost(s.tdcost)
	e2:SetTarget(s.dgtg)
	e2:SetOperation(s.dgop)
	c:RegisterEffect(e2)
	--(2) after this card is Summoned, can activate "Crimsonheart" Traps the turn they are Set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,id+o)
	e3:SetOperation(s.setop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
--Summoning Condition
function s.spfilter(c)
	return c:IsSetCard(0x95c) and c:IsAbleToGraveAsCost()
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_ONFIELD,0,nil)
	return g:GetCount()>=3 and Duel.GetMZoneCount(tp,g,tp)>0
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:Select(tp,3,3,nil)
	Duel.SendtoGrave(sg,REASON_COST)
end
--(1)
function s.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeckAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function s.dgfilter(c)
	return c:IsSetCard(0x95c) and not c:IsCode(id) and c:IsAbleToGrave()
end
function s.dgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.dgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.dgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.dgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--(2)
function s.actfilter(e,c)
	return c:IsSetCard(0x95c) and c:IsType(TYPE_TRAP)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(s.actfilter)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
