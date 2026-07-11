--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Magikey Battle  (ID: 54408264)
-- Type: Spell / Quick-Play
-- Setcode: 0x165
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 Normal Monster, 1 "Magikey" monster, or 1 "Magikey Maftea" in your GY; shuffle it into the
-- Deck, then if you activated this card in response to your opponent's card or effect activation,
-- Normal Monsters and "Magikey" monsters you control (except Tokens) are unaffected by that opponent's
-- card effect.
--[[ __CARD_HEADER_END__ ]]

--魔鍵闘争
function c54408264.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c54408264.target)
	e1:SetOperation(c54408264.activate)
	c:RegisterEffect(e1)
end
function c54408264.filter(c)
	return (c:IsType(TYPE_NORMAL) or c:IsType(TYPE_MONSTER) and c:IsSetCard(0x165) or c:IsCode(99426088)) and c:IsAbleToDeck()
end
function c54408264.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c54408264.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c54408264.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c54408264.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c54408264.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 then
		local ct=Duel.GetCurrentChain()
		if ct<2 then return end
		local te,tep=Duel.GetChainInfo(ct-1,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
		if tep==1-tp and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_IMMUNE_EFFECT)
			e1:SetTargetRange(LOCATION_MZONE,0)
			e1:SetTarget(c54408264.etarget)
			e1:SetValue(c54408264.efilter)
			e1:SetLabelObject(te)
			e1:SetReset(RESET_EVENT+RESET_CHAIN)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c54408264.efilter(e,re)
	return re==e:GetLabelObject()
end
function c54408264.etarget(e,c)
	return not c:IsType(TYPE_TOKEN) and (c:IsType(TYPE_NORMAL) or c:IsSetCard(0x165))
end
