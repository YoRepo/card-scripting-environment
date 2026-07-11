--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Hollowrokket Dragon  (ID: 51548207)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 6
-- ATK 2400 | DEF 1600
-- Setcode: 0x102
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Link Monster's effect is activated that targets this face-up card on the field (Quick
-- Effect): You can destroy this card, then excavate up to 6 cards from the top of your opponent's Deck
-- and banish 1 of them, and if you do, place the rest on top of the Deck in the same order.
-- During the End Phase, if this card is in the GY because it was destroyed on the field by battle or
-- card effect and sent there this turn: You can Special Summon 1 "Rokket" monster from your Deck,
-- except "Hollowrokket Dragon".
-- You can only use each effect of "Hollowrokket Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ホロウヴァレット・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.rmcon)
	e1:SetTarget(s.rmtg)
	e1:SetOperation(s.rmop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(s.regop)
	c:RegisterEffect(e2)
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(c) then return false end
	return re:IsActiveType(TYPE_LINK)
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetDecktopGroup(1-tp,1)
	if chk==0 then return c:IsDestructable() and g:GetCount()>0 and g:GetFirst():IsAbleToRemove(tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.Destroy(c,REASON_EFFECT)>0 then
		local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
		if ct>5 then ct=6 end
		if ct>1 then
			local cg=Duel.GetDecktopGroup(1-tp,1)
			if not cg:GetFirst():IsAbleToRemove(tp) then
				return
			end
			local tbl={}
			for i=1,ct do
				table.insert(tbl,i)
			end
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,2))
			ct=Duel.AnnounceNumber(tp,table.unpack(tbl))
		end
		Duel.BreakEffect()
		Duel.ConfirmDecktop(1-tp,ct)
		local g=Duel.GetDecktopGroup(1-tp,ct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		Duel.RevealSelectDeckSequence(true)
		local sg=g:FilterSelect(tp,Card.IsAbleToRemove,1,1,nil,tp)
		Duel.RevealSelectDeckSequence(false)
		if #sg>0 then
			Duel.DisableShuffleCheck(true)
			Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_ONFIELD) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(id,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1,id+o)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(s.sptg)
		e1:SetOperation(s.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x102) and not c:IsCode(id) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
