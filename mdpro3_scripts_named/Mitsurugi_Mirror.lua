--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Mitsurugi Mirror  (ID: 49721684)
-- Type: Spell / Ritual
-- Setcode: 0x1c3
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any Reptile Ritual Monster from your hand or GY.
-- You must also Tribute Reptile monsters from your hand or field whose total Levels equal or exceed
-- the Level of the Ritual Monster.
-- If "Ame no Murakumo no Mitsurugi", "Futsu no Mitama no Mitsurugi", or "Ame no Habakiri no Mitsurugi"
-- you control is Tributed, while this card is in your GY: You can shuffle this card into the Deck.
-- You can only use each effect of "Mitsurugi Mirror" once per turn.
--[[ __CARD_HEADER_END__ ]]

--巳剣之神鏡
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,13332685,19899073,55397172)
	--Activate
	local e1=aux.AddRitualProcGreater2(c,s.spfilter,LOCATION_HAND+LOCATION_GRAVE,nil,s.mfilter,true)
	e1:SetCountLimit(1,id)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.tdcon)
	e2:SetTarget(s.tdtg)
	e2:SetOperation(s.tdop)
	c:RegisterEffect(e2)
end
function s.spfilter(c)
	return c:IsRace(RACE_REPTILE)
end
function s.mfilter(c)
	return c:IsRace(RACE_REPTILE)
end
function s.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp)
		and (c:GetPreviousCodeOnField()==13332685 or c:GetPreviousCodeOnField()==19899073 or c:GetPreviousCodeOnField()==55397172)
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and aux.NecroValleyFilter()(c) then
		Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
