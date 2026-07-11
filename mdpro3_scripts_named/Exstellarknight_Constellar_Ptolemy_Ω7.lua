--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Exstellarknight Constellar Ptolemy Ω7  (ID: 6195332)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank: 7
-- ATK 2700 | DEF 2700
-- Setcode: 0x109c, 0x53
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 7 monsters
-- Once per turn, during your Main Phase 2, you can also Xyz Summon "Exstellarknight Constellar Ptolemy
-- Ω7" by using 1 "tellarknight" or "Constellar" Xyz Monster you control (transfer its materials).
-- While you have 7 or more "tellarknight" monsters with different names in your GY and/or banishment,
-- this card gains 2700 ATK/DEF, also it is unaffected by your opponent's activated effects.
-- Once per turn (Quick Effect): You can detach any number of materials from this card, then target
-- that many monsters your opponent controls; shuffle them into the Deck.
--[[ __CARD_HEADER_END__ ]]

--超神星輝士 セイクリッド・トレミスΩ７
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,s.ovfilter,aux.Stringid(id,0),3,s.xyzop)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.efcon)
	e1:SetValue(s.efilter)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCondition(s.efcon)
	e2:SetValue(2700)
	c:RegisterEffect(e2)
	--def up
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--to deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1)
	e4:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e4:SetTarget(s.tdtg)
	e4:SetOperation(s.tdop)
	c:RegisterEffect(e4)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9c,0x53) and c:IsXyzType(TYPE_XYZ)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 and Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_MAIN2 end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.cfilter(c)
	return c:IsFaceupEx() and c:IsSetCard(0x9c) and c:IsType(TYPE_MONSTER)
end
function s.efcon(e)
	local ct=Duel.GetMatchingGroup(s.cfilter,e:GetHandlerPlayer(),LOCATION_GRAVE+LOCATION_REMOVED,0,nil)
	return ct:GetClassCount(Card.GetCode)>=7
end
function s.efilter(e,re)
	return e:GetHandlerPlayer()~=re:GetOwnerPlayer() and re:IsActivated()
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToDeck() and chkc:IsControler(1-tp) end
	if chk==0 then
		if e:IsCostChecked() then
			return c:CheckRemoveOverlayCard(tp,1,REASON_COST)
				and Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,nil)
		else return false end
	end
	local rt=Duel.GetTargetCount(Card.IsAbleToDeck,tp,0,LOCATION_MZONE,nil)
	local ct=c:RemoveOverlayCard(tp,1,rt,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_MZONE,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function s.tdfilter(c)
	return c:IsRelateToChain() and c:IsType(TYPE_MONSTER)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local rg=tg:Filter(s.tdfilter,nil)
	if #rg>0 then
		Duel.SendtoDeck(rg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
